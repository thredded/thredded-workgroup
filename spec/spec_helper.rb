# frozen_string_literal: true

ENV["RAILS_ENV"] = "test"
require File.expand_path("../dummy/config/environment", __FILE__)
db_config   = Rails.configuration.database_configuration["test"]
db_adapter = db_config["adapter"]
db_database = db_config["database"]
db = ENV.fetch("DB", db_adapter)
db_is_memory = db_adapter == 'sqlite' && db_database == ':memory:'
puts "-"*40
puts "DB: #{ENV['DB']}"
puts "DB: adapter: #{db_adapter}"
puts "    database: #{db_database}"
puts "    db_is_memory: #{db_is_memory}"
dbcleaner_strategy_override = ENV["DBCLEANER"]&.to_sym
puts "    dbcleaner_strategy_override: #{dbcleaner_strategy_override}" if dbcleaner_strategy_override
puts "-"*40

# Re-create the test database and run the migrations
system({ "DB" => db }, "script/create-db-users") unless ENV["TRAVIS"]

ActiveRecord::Tasks::DatabaseTasks.drop_current unless db_is_memory
ActiveRecord::Tasks::DatabaseTasks.create_current unless db_is_memory

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
require "factory_girl_rails"
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

if db == "sqlite3"
  require "transactional_capybara/rspec" # so we can do sqlite (memory requires only one db obs,
                                         # but actually file is a problem with write access across two threads)
  dbcleaner_js_strategy = :deletion
  # see http://stackoverflow.com/questions/29387097/capybara-and-chrome-driver-sqlite3busyexception-database-is-locked
else
  require "transactional_capybara/ajax_helpers" # so we can wait for ajax (only!)
  dbcleaner_js_strategy = :truncation
end

Capybara.javascript_driver = ENV["CAPYBARA_JS_DRIVER"].blank? ? :webkit : ENV["CAPYBARA_JS_DRIVER"].to_sym
Capybara::Webkit.configure(&:block_unknown_urls)


RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    if Rails::VERSION::MAJOR < 5
      # after_commit testing is baked into rails 5.
      require "test_after_commit"
      # causes many problems with capybara-webkit, so we turn it off generally
      TestAfterCommit.enabled = false
    end
    ActiveJob::Base.queue_adapter = :inline
  end

  config.before(:each) do
    Time.zone = "UTC"
  end

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    Time.zone = "UTC"
  end

  config.before(:each) do |example|
    msg, strategy = if example.metadata[:js]
                      ["JS strategy", dbcleaner_strategy_override || dbcleaner_js_strategy]
                    else
                      ["strategy", dbcleaner_strategy_override || :transaction]
    end
    puts "setting #{msg} to #{strategy} #{example}" if ENV["DBC_VERBOSE"]
    DatabaseCleaner.strategy = strategy
  end

  config.before(:each) do |example|
    DatabaseCleaner.start
    puts "DatabaseCleaner.start #{example}" if ENV["DBC_VERBOSE"]
  end

  config.after(:each) do |example|
    if example.metadata[:js]
      puts "AjaxHelpers.wait_for_ajax #{example}" if ENV["DBC_VERBOSE"]
      TransactionalCapybara::AjaxHelpers.wait_for_ajax(page)
    end
    puts "DatabaseCleaner.clean #{example}" if ENV["DBC_VERBOSE"]
    DatabaseCleaner.clean
  end
end
