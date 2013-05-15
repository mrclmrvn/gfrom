module Refinery
  module GoogleForms
    module Admin
      class GoogleFormsController < ::Refinery::AdminController

        crudify :'refinery/google_forms/google_form',
                :title_attribute => 'name', :xhr_paging => true

      end
    end
  end
end
