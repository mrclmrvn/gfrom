module Refinery
  module GoogleForms
    class GoogleFormsController < ::ApplicationController

      before_filter :find_all_google_forms
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @google_form in the line below:
        present(@page)
      end

      def show
        @google_form = GoogleForm.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @google_form in the line below:
        present(@page)
      end

    protected

      def find_all_google_forms
        @google_forms = GoogleForm.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/google_forms").first
      end

    end
  end
end
