class PagesController < ApplicationController
  def home
    @title = "Home"
  end

  def about
    @title = "About"
  end

  def contact
    @title = "Contact Us"
  end
  
  def faq
    @title = "FAQ"
  end
  
  def product
    @title = "Product"
  end
end
