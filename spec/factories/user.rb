FactoryGirl.define do
	factory :user do
		name "Clara Oswin Oswald"
		email "clara@example.com"
		password "password"
		password_confirmation "password"
		confirmed_at Time.now
	end
end
