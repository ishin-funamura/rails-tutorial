FactoryBot.define do
  factory :user do
    name { "Michael Example" }
    email { "michael1@example.com" }
    password {"password"}
    password_digest {User.digest('password')}

    trait :second do
      name { "Michael2 Example" }
      email { "michael2@example.com" }
      password {"password2"}
      password_digest {User.digest('password2')}
    end
  end
end
