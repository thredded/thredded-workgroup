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

require File.expand_path("../../lib/thredded/db_tools", Thredded::Engine.called_from)
if ENV["MIGRATION_SPEC"]
  Thredded::DbTools.restore
else
  Thredded::DbTools.migrate(
    paths: [
      "#{Gem.loaded_specs['thredded'].full_gem_path}/db/migrate/",
      Rails.root.join("db", "migrate")
    ],
    quiet: true
  )
end

require "rspec/rails"
require "capybara/rspec"
require "webdrivers"
require "pundit/rspec"
require "factory_bot_rails"
require "fileutils"
require "active_support/testing/time_helpers"

require "rails-controller-testing"
RSpec.configure do |config|
  [:controller, :view, :request].each do |type|
    config.include ::Rails::Controller::Testing::TestProcess, type: type
    config.include ::Rails::Controller::Testing::TemplateAssertions, type: type
    config.include ::Rails::Controller::Testing::Integration, type: type
  end
end

Dir[Rails.root.join("../../spec/support/**/*.rb")].each { |f| require f }

FileUtils.mkdir("log") unless File.directory?("log")

ActiveRecord::SchemaMigration.logger = ActiveRecord::Base.logger = Logger.new(File.open("log/test.#{db}.log", "w"))

Capybara.asset_host = "http://localhost:3012" unless ENV["CI"]

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.include FactoryBot::Syntax::Methods
  config.infer_spec_type_from_file_location!

  config.before(:suite) do
    ActiveJob::Base.queue_adapter = :test
  end

  config.before(:each) do
    Time.zone = "UTC"
  end
end
