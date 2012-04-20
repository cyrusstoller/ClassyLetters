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

Factory.sequence :uuid do |u|
  SecureRandom.uuid
end

Factory.define :lettre_order do |order|
  order.user_id                  1
  order.preferred_delivery_date  Time.now.to_date + 4.days
  order.signed_name              "John Doe"
  order.message_display_date     "April 1, 1920"
  order.message                  "This is my blank message"
  order.address_street1          "776 University"
  order.address_street2          ""
  order.address_city             "Palo Alto"
  order.address_state            "CA"
  order.address_zip              "94116"
  order.paper_size               0
  order.writing_style            0
  order.wax_seal                 false
  order.uuid                     SecureRandom.uuid
end