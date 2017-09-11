# coding: utf-8
# frozen_string_literal: true
# rubocop:disable Style/GuardClause
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "thredded/workgroup/version"

Gem::Specification.new do |s|
  s.name          = "thredded-workgroup"
  s.version       = Thredded::Workgroup::VERSION
  s.authors       = ["Tim Diggins"]
  s.email         = ["tim@red56.uk"]

  s.summary       = "Extension to Thredded with features for workgroup messaging (Unread, Unreplied, Following)."
  s.description   = "Write a longer description or delete this line."
  s.homepage      = "https://github.com/red56/thredded-workgroup."
  s.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if s.respond_to?(:metadata)
    s.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    fail "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  s.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  s.bindir        = "exe"
  s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]

  # needs thredded, you can specify a specific fork or version (in **your** gemfile) if you need to!
  s.add_dependency "thredded", "~> 0.12"

  # bundler added dependencies
  s.add_development_dependency "bundler", "~> 1.12"
  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency "rspec", "~> 3.0"

  # test dependencies
  s.add_development_dependency "capybara", "~> 2.4"
  s.add_development_dependency "capybara-webkit"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "faker", ">= 1.6.2"
  s.add_development_dependency "launchy"
  s.add_development_dependency "rspec-rails", ">= 3.5.0"
  s.add_development_dependency "rubocop", "= 0.41.2"
  s.add_development_dependency "transactional_capybara"

  # dummy app dependencies
  s.add_development_dependency "rails-i18n"
  s.add_development_dependency "kaminari-i18n"
  s.add_development_dependency "http_accept_language"
  s.add_development_dependency "mysql2"
  s.add_development_dependency "pg"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "puma"
  s.add_development_dependency "rails_email_preview", ">= 2.0.1"
  s.add_development_dependency "roadie-rails"
  s.add_development_dependency "i18n-tasks"
  s.add_development_dependency "web-console"
  s.add_development_dependency "jquery-rails"

  # add some plugins to the dummy app demo
  s.add_development_dependency "thredded-markdown_coderay"
  s.add_development_dependency "thredded-markdown_katex"

  # dummy app frontend
  s.add_development_dependency "turbolinks"
  # required by the turbolinks gem
  s.add_development_dependency "coffee-rails"
end
