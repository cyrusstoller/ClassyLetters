Factory.sequence :username do |n|
  "username#{n}"
end

Factory.sequence :email do |n|
  "name#{n}@knolcano.com"
end

Factory.define :user do |user|
  user.username   "cyrus"
  user.email      "cyrus@knolcano.com"
  user.password   "foobar"
end

Factory.define :lettre_order do |order|
  order.user_id                  1
  order.preferred_delivery_date  Time.now.to_date + 2.days
  order.signed_name              "John Doe"
  order.message_display_date     "April 1, 1920"
  order.message                  "This is my blank message"
end