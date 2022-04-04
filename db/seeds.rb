# Create a main sample user.
User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

# Generate a bunch of additional users.
99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

# Me
User.create!(name:  "Erik Westrup",
             email: "erik.westrup@gmail.com",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

  # Microposts
  users = User.order(:created_at).take(6).concat [User.find_by(email: "erik.westrup@gmail.com")]
  50.times do
    content = Faker::Lorem.sentence(word_count: 5)
    users.each { |u| u.microposts.create!(content: content) }
  end