# == Schema Information
# Schema version: 20120417044746
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(255)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  password_salt          :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  failed_attempts        :integer         default(0)
#  unlock_token           :string(255)
#  locked_at              :datetime
#  authentication_token   :string(255)
#  username               :string(255)
#  admin                  :boolean
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#

require 'spec_helper'

describe User do
  describe "display_name" do
    it "should respond_to display_name" do
      Factory.build(:user).should respond_to(:display_name)
    end
    
    it "should return the username if there is one" do
      user = Factory(:user)
      user.display_name.should == user.username
    end
    
    it "should return the part of the email address before the @ if there is no username" do
      user = Factory(:user, :username => nil, :email => "cyrus@knolcano.com")
      user.display_name.should == "cyrus"
    end
  end  
end
