# == Schema Information
# Schema version: 20120420233855
#
# Table name: purchases
#
#  id                 :integer         not null, primary key
#  lettre_order_id    :integer
#  last_four          :integer
#  stripe_id          :string(255)
#  stripe_fingerprint :string(255)
#  card_type          :string(255)
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#

class Purchase < ActiveRecord::Base
  attr_accessible :stripe_card_token
  attr_accessor   :stripe_card_token
  
  validates_presence_of :lettre_order_id
  validates_uniqueness_of :lettre_order_id
  validates_presence_of :last_four
  validates_presence_of :stripe_id # this is the charge id that can be used to refund a purchase through stripe
  validates_presence_of :stripe_fingerprint
  validates_presence_of :card_type
  
  belongs_to :lettre_order, :class_name => "LettreOrder", :foreign_key => "lettre_order_id"

  def save_with_payment
    begin
      stripe_charge = Stripe::Charge.create(
        :amount => (lettre_order.price * 100).to_i,
        :currency => "usd",
        :card => stripe_card_token, # obtained with Stripe.js
        :description => "Charge for lettre order #{lettre_order.uuid}"
      )
      self.last_four = stripe_charge["card"]["last4"]
      self.stripe_id = stripe_charge["id"]
      self.stripe_fingerprint = stripe_charge["card"]["fingerprint"]
      self.card_type = stripe_charge["card"]["type"]
      save!
    rescue Stripe::InvalidRequestError => e
      logger.error "Stripe error while creating the charge: #{e.message}"
      errors.add :base, "There was a problem with your credit card."
      return false
    end
  end
end
