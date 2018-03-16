FactoryBot.define do
  factory :user do
    first_name 'Jake'
    last_name 'Fruci'
    sequence :email do |n|
      "email#{n}@example.com"
    end
    password 'password'
  end
end
