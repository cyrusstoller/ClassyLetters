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

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :token_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :username, :remember_me #:password_confirmation
  # attr_accessible :title, :body
  
  #to allow a user to sign in using either thier username or email
  attr_accessor :login
  attr_accessible :login

  validates_uniqueness_of :username, :on => :create, :message => "is already taken", :case_sensitive => false, :allow_nil => true, :allow_blank => true
  validates_length_of :username, :within => 3..15, :on => :create, :allow_nil => true, :allow_blank => true
  validates_format_of :username, :with => /^[\w\d]+$/, :allow_nil => true, :allow_blank => true
  
  before_save :reset_authentication_token
  
  has_many :lettre_orders
    
  def display_name
    return username unless username.nil? or username.blank?
    return email.split("@")[0]
  end
  
  protected    

  def self.find_for_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  end

end
