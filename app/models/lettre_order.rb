# == Schema Information
# Schema version: 20120418224612
#
# Table name: lettre_orders
#
#  id                      :integer         not null, primary key
#  user_id                 :integer
#  preferred_delivery_date :date
#  signed_name             :string(255)
#  message_display_date    :date
#  message                 :text
#  created_at              :datetime        not null
#  updated_at              :datetime        not null
#  address_street1         :string(255)
#  address_street2         :string(255)
#  address_city            :string(255)
#  address_state           :string(255)
#  address_zip             :string(255)
#  paper_size              :integer         default(0)
#  writing_style           :integer         default(0)
#  wax_seal                :boolean         default(FALSE)
#  uuid                    :string(255)
#

class LettreOrder < ActiveRecord::Base
  attr_accessible :message, :message_display_date, :preferred_delivery_date, :signed_name
  attr_accessible :address_street1, :address_street2, :address_city, :address_state, :address_zip
  attr_accessible :paper_size, :writing_style, :wax_seal
    
  validates_presence_of :message
  validates_presence_of :preferred_delivery_date
  validate :in_the_future  
  validates_presence_of :user_id
  
  validates_presence_of :address_street1
  validates_presence_of :address_city
  validates_presence_of :address_state
  validates_format_of :address_state, :with => /^(A[LKSZRAEP]|C[AOT]|D[EC]|F[LM]|G[AU]|HI|I[ADLN]|K[SY]|LA|M[ADEHINOPST]|N[CDEHJMVY]|O[HKR]|P[ARW]|RI|S[CD]|T[NX]|UT|V[AIT]|W[AIVY])$/
  # For a reference on the zip codes http://en.wikipedia.org/wiki/ZIP_code
  # For a reference for the regex http://regexlib.com/REDetails.aspx?regexp_id=471&AspxAutoDetectCookieSupport=1
  validates_presence_of :address_zip
  validates_format_of :address_zip, :with => /^[0-9]{5}(-[0-9]{4})?$/
  
  validates_inclusion_of :paper_size, :in => 0..2
  validates_inclusion_of :writing_style, :in => 0..2
  
  validates_presence_of :uuid
  
  belongs_to :user
  
  def to_param
    uuid
  end
  
  def display_message
    message.gsub(/\n/, '<br/>').html_safe
  end
  
  def price
    subtotal = 9.99 # base price
    case paper_size
    when 1
      subtotal += 2 # medium
    when 2
      subtotal += 5 # large
    end
    
    case writing_style
    when 1
      subtotal += 5
    when 2
      subtotal += 10
    end
    return subtotal
  end
    
  private
  
  def in_the_future
    buffer = 2.days
    unless preferred_delivery_date.nil?
      if created_at 
        temp_date = created_at.to_date + buffer
        if preferred_delivery_date < temp_date
          errors.add(:preferred_delivery_date, "is unrealistic please choose a date after #{(created_at + buffer).strftime("%b %d %Y")}")
          return
        else
          return
        end
      end
      
      if preferred_delivery_date < Time.now.to_date + buffer
        errors.add(:preferred_delivery_date, "is unrealistic please choose a date after #{(Time.now + buffer).strftime("%b %d %Y")}")
      end
    end
  end
end
