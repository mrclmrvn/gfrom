module Refinery
  class GoogleFormsGenerator < Rails::Generators::Base

    def rake_db
      rake "refinery_google_forms:install:migrations"
    end

    def append_load_seed_data
      create_file 'db/seeds.rb' unless File.exists?(File.join(destination_root, 'db', 'seeds.rb'))
      append_file 'db/seeds.rb', :verbose => true do
        <<-EOH

# Added by Refinery CMS Google Forms extension
Refinery::GoogleForms::Engine.load_seed
        EOH
      end
    end
  end
end
