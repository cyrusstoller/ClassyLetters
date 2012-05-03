class PurchasesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_letter_order

  # GET /letter_orders/1/purchase
  def show
    @purchase = @letter_order.purchase

    if @purchase.nil?
      flash[:notice] = "This letter order hasn't been purchased yet."
      redirect_to :action => :new
      return
    end

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /letter_orders/1/purchase/new
  def new
    unless @letter_order.purchase.nil?
      flash[:notice] = "This letter order has already been purchased."
      redirect_to :action => :show
      return
    end
            
    @purchase = @letter_order.build_purchase

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # POST /purchases
  # POST /purchases.json
  def create
    unless @letter_order.purchase.nil?
      flash[:notice] = "This letter order has already been purchased. Why are you trying to pay again?"
      redirect_to :action => :show
      return
    end
    
    @purchase = @letter_order.build_purchase(params[:purchase])

    respond_to do |format|
      if @purchase.save_with_payment
        Receipt.send_text(@purchase).deliver
        Receipt.send_receipt(@purchase).deliver
        format.html { redirect_to letter_order_purchase_path(@letter_order.to_param), notice: 'Purchase was successfully created.' }
      else
        format.html { render :action => :new }
      end
    end
  end
  
  private
  
  def get_letter_order
    @letter_order = LetterOrder.find_by_uuid(params[:letter_order_id])
  end
end
