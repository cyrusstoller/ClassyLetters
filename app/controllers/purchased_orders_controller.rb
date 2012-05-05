class PurchasedOrdersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :is_admin?
  
  # GET /purchased_orders
  def index
    if params[:uuid].present?
      uuid = params[:uuid].strip
      letter_order = LetterOrder.find_by_uuid(uuid)
      if letter_order.nil?
        flash.now[:alert] = "#{params[:uuid]} is an invalid uuid."
      else
        redirect_to purchased_order_path(uuid)
        return
      end
    end
    
    @letter_orders_purchased = LetterOrder.accessible_by(current_ability).
                                           where("delivery_status = 1").
                                           order("preferred_delivery_date ASC").
                                           paginate(:page => params[:purchased_page])
    @letter_orders_delivered = LetterOrder.accessible_by(current_ability).
                                           where("delivery_status = 2").
                                           order("updated_at DESC").
                                           paginate(:page => params[:delivered_page])
    
    if @letter_orders_purchased.empty? and @letter_orders_delivered.empty?
      flash[:notice] = "No letters have been purchased yet."
      redirect_to root_path
      return
    end

    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  # GET /purchased_orders/1
  def show
    @letter_order = LetterOrder.find_by_uuid(params[:id])

    if @letter_order.delivery_status == 0
      flash[:alert] = "Letter #{params[:id]} has not been purchased yet."
      redirect_to purchased_orders_path
      return
    end
    
    respond_to do |format|
      format.html
      format.json { render json: @letter_order }
    end
  end
  
  # PUT /purchased_orders/1/fulfilled
  def fulfilled
    @letter_order = LetterOrder.find_by_uuid(params[:id])
    error_free = @letter_order.set_delivery_status!(params[:delivery_status])
    if error_free == false
      flash[:error] = "You can't set the delivery status to #{params[:delivery_status]}" 
    else
      case @letter_order.delivery_status
      when 0
        flash[:notice] = "Letter Order #{params[:id]} has been set to draft."
      when 1
        flash[:notice] = "Letter Order #{params[:id]} has been set to purchased but not fulfilled."
      when 2
        flash[:notice] = "Letter Order #{params[:id]} has been set to fulfilled."
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
