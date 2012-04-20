class PurchasedOrdersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :is_admin?
  
  # GET /purchased_orders
  def index
    @lettre_orders_purchased = LettreOrder.accessible_by(current_ability).where("delivery_status = 1")
    @lettre_orders_delivered = LettreOrder.accessible_by(current_ability).where("delivery_status = 2")
    
    if @lettre_orders_purchased.empty? and @lettre_orders_delivered.empty?
      flash[:notice] = "No lettres have been purchased yet."
      redirect_to root_path
      return
    end

    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  # GET /purchased_orders/1
  def show
    @lettre_order = LettreOrder.find_by_uuid(params[:id])

    if @lettre_order.delivery_status == 0
      redirect_to purchased_orders_path
      return
    end
    
    respond_to do |format|
      format.html
      format.json { render json: @lettre_order }
    end
  end
  
  # PUT /purchased_orders/1/fulfilled
  def fulfilled
    @lettre_order = LettreOrder.find_by_uuid(params[:id])
    error_free = @lettre_order.set_delivery_status!(params[:delivery_status])
    if error_free == false
      flash[:error] = "You can't set the delivery status to #{params[:delivery_status]}" 
    else
      case params[:delivery_status].to_i
      when 0
        flash[:notice] = "Lettre Order #{params[:id]} has been set to draft."
      when 1
        flash[:notice] = "Lettre Order #{params[:id]} has been set to purchased but not fulfilled."
      when 2
        flash[:notice] = "Lettre Order #{params[:id]} has been set to fulfilled."
      end
    end
    
    redirect_to purchased_orders_path
  end
  
  private
  
  def is_admin?
    unless current_user.admin?
      flash[:alert] = "Sorry you're not an administrator."
      redirect_to root_path
    end
  end
end
