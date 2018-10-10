# frozen_string_literal: true

ENV["RAILS_ENV"] = "test"
require File.expand_path("../dummy/config/environment", __FILE__)
db_config = Rails.configuration.database_configuration["test"]
db_adapter = db_config["adapter"]
db_database = db_config["database"]
db = ENV.fetch("DB", db_adapter)
db_is_memory = db_adapter.starts_with?("sqlite") && db_database == ":memory:"
puts "-" * 40
puts "DB: #{ENV['DB']}"
puts "DB: adapter: #{db_adapter}"
puts "    database: #{db_database}"
puts "    db_is_memory: #{db_is_memory}"
puts "-" * 40

# Re-create the test database and run the migrations
system({ "DB" => db }, "script/create-db-users") unless ENV["TRAVIS"]

def drop_recreate_db
  ActiveRecord::Tasks::DatabaseTasks.drop_current
  ActiveRecord::Tasks::DatabaseTasks.create_current
end

drop_recreate_db unless db_is_memory

begin
  verbose_was = ActiveRecord::Migration.verbose
  ActiveRecord::Migration.verbose = false
  ActiveRecord::Migrator.migrate([
                                   "#{Gem.loaded_specs['thredded'].full_gem_path}/db/migrate/",
                                   File.join(Rails.root, "db/migrate/")
                                 ])
ensure
  ActiveRecord::Migration.verbose = verbose_was
end

require "rspec/rails"
require "capybara/rspec"
require "pundit/rspec"
require "factory_bot_rails"
require "database_cleaner"
require "fileutils"
require "active_support/testing/time_helpers"

if Rails::VERSION::MAJOR >= 5
  require "rails-controller-testing"
  RSpec.configure do |config|
    [:controller, :view, :request].each do |type|
      config.include ::Rails::Controller::Testing::TestProcess, type: type
      config.include ::Rails::Controller::Testing::TemplateAssertions, type: type
      config.include ::Rails::Controller::Testing::Integration, type: type
    end
  end
end

Dir[Rails.root.join("../../spec/support/**/*.rb")].each { |f| require f }

FileUtils.mkdir("log") unless File.directory?("log")

ActiveRecord::SchemaMigration.logger = ActiveRecord::Base.logger = Logger.new(File.open("log/test.#{db}.log", "w"))

require "capybara-webkit"

require "transactional_capybara/ajax_helpers" # so we can wait for ajax (only!)
if db == "sqlite3"
  # see http://stackoverflow.com/questions/29387097/capybara-and-chrome-driver-sqlite3busyexception-database-is-locked
  dbcleaner_js_strategy = :deletion
  dbcleaner_nonjs_strategy = :truncation
else
  dbcleaner_js_strategy = :truncation
  dbcleaner_nonjs_strategy = :transaction
end

Capybara.javascript_driver = ENV["CAPYBARA_JS_DRIVER"].blank? ? :webkit : ENV["CAPYBARA_JS_DRIVER"].to_sym
Capybara::Webkit.configure(&:block_unknown_urls)
Capybara.asset_host = "http://localhost:3012" unless ENV["CI"]

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    ActiveJob::Base.queue_adapter = :test
  end

  config.before(:each) do
    Time.zone = "UTC"
  end

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation, reset_ids: true)
    if Rails::VERSION::MAJOR < 5
      # after_commit testing is baked into rails 5.
      require "test_after_commit"
      TestAfterCommit.enabled = true
    end
  end

  config.before(:each) do
    Time.zone = "UTC"
  end

  config.before(:each) do |example|
    strategy = if example.metadata[:js]
                 dbcleaner_js_strategy
               else
                 dbcleaner_nonjs_strategy
               end
    DatabaseCleaner.strategy = strategy
  end

  config.before(:each) do |_example|
    DatabaseCleaner.start
  end

  config.after(:each) do |example|
    if example.metadata[:js]
      TransactionalCapybara::AjaxHelpers.wait_for_ajax(page)
    end
  end
  config.append_after(:each) do |_example|
    DatabaseCleaner.clean
  end
end
