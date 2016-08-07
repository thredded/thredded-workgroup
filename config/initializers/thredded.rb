require_dependency 'thredded/application_controller'
module Thredded
  class ApplicationController < ::ApplicationController
    def thredded_navbar_active
      :messageboards
    end
  end
end
Thredded::ApplicationController.send(:helper_method, :thredded_navbar_active)
