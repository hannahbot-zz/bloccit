FactoryGirl.define do
	factory :user do
		name "Clara Oswin Oswald"
		sequence(:email) { |n| "person#{n}@example.com" }
		password "password"
		password_confirmation "password"
		confirmed_at Time.now
	end
end
