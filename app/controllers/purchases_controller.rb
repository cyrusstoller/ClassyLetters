class PurchasesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_lettre_order

  # GET /lettre_orders/1/purchase
  def show
    @purchase = @lettre_order.purchase

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /lettre_orders/1/purchase/new
  def new
    @purchase = @lettre_order.build_purchase

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # POST /purchases
  # POST /purchases.json
  def create
    @purchase = @lettre_order.build_purchase(params[:purchase])

    respond_to do |format|
      if @purchase.save_with_payment
        format.html { redirect_to lettre_order_purchase_path(@lettre_order.to_param), notice: 'Purchase was successfully created.' }
      else
        format.html { render :action => :new }
      end
    end
  end
  
  private
  
  def get_lettre_order
    @lettre_order = LettreOrder.find_by_uuid(params[:lettre_order_id])
  end
end
