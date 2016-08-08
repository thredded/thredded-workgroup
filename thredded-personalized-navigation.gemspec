# coding: utf-8
# frozen_string_literal: true
# rubocop:disable Style/GuardClause
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "thredded/personalized_navigation/version"

Gem::Specification.new do |spec|
  spec.name          = "thredded-personalized-navigation"
  spec.version       = Thredded::PersonalizedNavigation::VERSION
  spec.authors       = ["Tim Diggins"]
  spec.email         = ["tim@red56.uk"]

  spec.summary       = "Extension to Thredded with Personalized navigation (Unread, Posted, Following)."
  spec.description   = "Write a longer description or delete this line."
  spec.homepage      = "https://github.com/red56/thredded-personalized-navigation."
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    fail "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # needs thredded, you can specify a specific fork or version if you need to!
  spec .add_dependency "thredded", "~> 0.6"

  # bundler added dependencies
  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  # test dependencies
  spec.add_development_dependency "capybara", "~> 2.4"
  spec.add_development_dependency "database_cleaner"
  spec.add_development_dependency "factory_girl_rails"
  spec.add_development_dependency "faker", ">= 1.6.2"
  spec.add_development_dependency "launchy"
  spec.add_development_dependency "rspec-rails", ">= 3.5.0"
  spec.add_development_dependency "rubocop", "= 0.41.2"

  # dummy app dependencies
  spec.add_development_dependency "rails-i18n"
  spec.add_development_dependency "http_accept_language"
  spec.add_development_dependency "mysql2"
  spec.add_development_dependency "pg"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "puma"
  spec.add_development_dependency "rails_email_preview", ">= 2.0.1"
  spec.add_development_dependency "i18n-tasks"

  # dummy app frontend
  spec.add_development_dependency "jquery-turbolinks"
  # TODO: upgrade once Turbolinks 5 is supported by jquery-turbolinks:
  # https://github.com/kossnocorp/jquery.turbolinks/pull/58
  spec.add_development_dependency "turbolinks", "~> 2.5"
end
