class Receipt < ActionMailer::Base
  default :from => "info@knolcano.com"
  
  def send_text(purchase)
    @purchase = purchase
    @letter_order = @purchase.letter_order
    
    mail(:to => "#{ENV["ADMIN_TXT_NUMBER"]}@txt.att.net")
  end
  
  def send_receipt(purchase)
    @purchase = purchase
    @letter_order = @purchase.letter_order
    @user = @letter_order.user
    
    mail(:to => purchase.letter_order.user.email,
      :subject => "[Classy Letters] Receipt for Letter Order \# #{@letter_order.uuid}"
    )
  end
end
