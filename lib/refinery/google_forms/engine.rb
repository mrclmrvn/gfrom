module Refinery
  module GoogleForms
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::GoogleForms

      engine_name :refinery_google_forms

      initializer "register refinerycms_google_forms plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "google_forms"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.google_forms_admin_google_forms_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/google_forms/google_form',
            :title => 'name'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::GoogleForms)
      end
    end
  end
end
