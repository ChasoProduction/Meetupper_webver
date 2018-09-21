User.create!(name:'Sample user', email:'sample@example.com',
             password:'Foobar21',
             password_confirmation:'Foobar21',)

User.create!(name:'Chaso', email:'Chaso@chasochaso.com',
             password:'Foobar21',
             password_confirmation:'Foobar21')

98.times do |n|
  name = Faker::Name.name
  email = "sample#{n + 2}@example.com"
  User.create!(name:name, email:email,
               password:'Foobar21',
               password_confirmation:'Foobar21')
end

users = User.order(:created_at).take(6)
start_time = Time.zone.local(2100, 1, 1, 0, 0, 0)
end_time = start_time + 1.day
20.times do
  content = Faker::Lorem.sentence(5)
  users.each do |user|
    user.personal_schedules.create!(content:content,
                                        starts_at:start_time,
                                        ends_at:end_time,
                                        importance:2)
  end
end
