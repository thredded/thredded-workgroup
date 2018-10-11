# frozen_string_literal: true

RSpec::Matchers.define :have_link_to do |expected_path|
  match do |actual_page|
    actual_page.has_css?(%(a[href="#{expected_path}"]))
  end
  failure_message do |_actual|
    "expected to have a link to #{expected_path}"
  end
end
# class Capybara::Session
#   def has_link_to?(path)
#     has_css?(%Q{a[href="#{path}"]})
#   end
# end

# module LinkageSupport
#   extend RSpec::SharedContext
# end
# RSpec.configure do |config|
#   config.include LinkageSupport, type: :feature
# end
