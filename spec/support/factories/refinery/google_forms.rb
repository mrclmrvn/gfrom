
FactoryGirl.define do
  factory :google_form, :class => Refinery::GoogleForms::GoogleForm do
    sequence(:name) { |n| "refinery#{n}" }
  end
end

