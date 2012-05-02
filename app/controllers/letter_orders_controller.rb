class LetterOrdersController < ApplicationController
  before_filter :authenticate_user!

  # GET /letter_orders
  # GET /letter_orders.json
  def index
    @letter_order_drafts     = current_user.letter_orders.where("delivery_status = 0").
                                                          order("updated_at desc").paginate(:page => params[:drafts_page])
    @letter_orders_purchased = current_user.letter_orders.where("delivery_status = 1").
                                                          order("updated_at desc").paginate(:page => params[:purchased_page])
    @letter_orders_delivered = current_user.letter_orders.where("delivery_status = 2").
                                                          order("updated_at desc").paginate(:page => params[:delivered_page])
    
    if @letter_order_drafts.empty? and @letter_orders_purchased.empty? and @letter_orders_delivered.empty?
      flash[:notice] = "You haven't written any letters yet."
      redirect_to :action => :new
      return
    end

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /letter_orders/1
  # GET /letter_orders/1.json
  def show
    @letter_order = LetterOrder.find_by_uuid(params[:id])

    authorize! :show, @letter_order

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @letter_order }
    end
  end

  # GET /letter_orders/new
  # GET /letter_orders/new.json
  def new
    @letter_order = LetterOrder.new
    @letter_order.preferred_delivery_date = (Time.now + 3.days).strftime("%b %d %Y")
    @letter_order.message_display_date = Time.now.strftime("%b %d %Y")

    authorize! :new, LetterOrder

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @letter_order }
    end
  end

  # GET /letter_orders/1/edit
  def edit
    @letter_order = LetterOrder.find_by_uuid(params[:id])
    
    authorize! :edit, @letter_order
  end

  # POST /letter_orders
  # POST /letter_orders.json
  def create
    @letter_order = current_user.letter_orders.build(params[:letter_order])
    @letter_order.uuid = SecureRandom.uuid

    authorize! :create, LetterOrder

    respond_to do |format|
      if @letter_order.save
        format.html { redirect_to @letter_order, notice: 'Letter order was successfully created.' }
        format.json { render json: @letter_order, status: :created, location: @letter_order }
      else
        format.html { render action: "new" }
        format.json { render json: @letter_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /letter_orders/1
  # PUT /letter_orders/1.json
  def update
    @letter_order = LetterOrder.find_by_uuid(params[:id])

    authorize! :update, @letter_order

    respond_to do |format|
      if @letter_order.update_attributes(params[:letter_order])
        format.html { redirect_to @letter_order, notice: 'Letter order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @letter_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /letter_orders/1
  # DELETE /letter_orders/1.json
  def destroy
    @letter_order = LetterOrder.find_by_uuid(params[:id])
    authorize! :destroy, @letter_order

    @letter_order.destroy

    respond_to do |format|
      format.html { redirect_to letter_orders_url }
      format.json { head :no_content }
    end
  end
end
