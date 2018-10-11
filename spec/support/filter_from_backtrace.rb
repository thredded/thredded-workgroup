# frozen_string_literal: true

RSpec.configure do |config|
  config.backtrace_exclusion_patterns << /gems/
  config.backtrace_inclusion_patterns << %r{gems/thredded}
end
