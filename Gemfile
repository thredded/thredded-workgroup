# frozen_string_literal: true
source "https://rubygems.org"

rails_version = ENV.fetch("RAILS", '4').to_i
# switch: bundle update rails json rails-i18n
if rails_version == 5
  gem "rails", "~> 5.0.0"
  group :test do
    gem "rails-controller-testing"
  end
elsif rails_version == 4
  gem "rails", "~> 4.2.5"
end

gemspec

eval_gemfile File.expand_path("shared.gemfile", File.dirname(__FILE__))
