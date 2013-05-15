module Refinery
  module GoogleForms
    class GoogleForm < Refinery::Core::BaseModel
      self.table_name = 'refinery_google_forms'

      attr_accessible :name, :position

      acts_as_indexed :fields => [:name]

      validates :name, :presence => true, :uniqueness => true
    end
  end
end
