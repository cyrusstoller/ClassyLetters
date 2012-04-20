class PurchasedOrdersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :is_admin?
  
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
  
  private
  
  def is_admin?
    unless current_user.admin?
      flash[:alert] = "Sorry you're not an administrator."
      redirect_to root_path
    end
  end
end
