class CreateGoogleFormsGoogleForms < ActiveRecord::Migration

  def up
    create_table :refinery_google_forms do |t|
      t.string :name
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-google_forms"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/google_forms/google_forms"})
    end

    drop_table :refinery_google_forms

  end

end
