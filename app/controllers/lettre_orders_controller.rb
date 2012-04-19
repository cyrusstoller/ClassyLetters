class LettreOrdersController < ApplicationController
  before_filter :authenticate_user!

  # GET /lettre_orders
  # GET /lettre_orders.json
  def index
    @lettre_orders = LettreOrder.accessible_by(current_ability)
    
    if @lettre_orders.empty?
      flash[:notice] = "You haven't written any lettres yet."
      redirect_to :action => :new
      return
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lettre_orders }
    end
  end

  # GET /lettre_orders/1
  # GET /lettre_orders/1.json
  def show
    @lettre_order = LettreOrder.find_by_uuid(params[:id])

    authorize! :show, @lettre_order

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lettre_order }
    end
  end

  # GET /lettre_orders/new
  # GET /lettre_orders/new.json
  def new
    @lettre_order = LettreOrder.new
    @lettre_order.preferred_delivery_date = (Time.now + 3.days).strftime("%b %d %Y")
    @lettre_order.message_display_date = Time.now.strftime("%b %d %Y")

    authorize! :new, LettreOrder

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lettre_order }
    end
  end

  # GET /lettre_orders/1/edit
  def edit
    @lettre_order = LettreOrder.find_by_uuid(params[:id])
    
    authorize! :edit, @lettre_order
  end

  # POST /lettre_orders
  # POST /lettre_orders.json
  def create
    @lettre_order = current_user.lettre_orders.build(params[:lettre_order])
    @lettre_order.uuid = SecureRandom.uuid

    authorize! :create, LettreOrder

    respond_to do |format|
      if @lettre_order.save
        format.html { redirect_to @lettre_order, notice: 'Lettre order was successfully created.' }
        format.json { render json: @lettre_order, status: :created, location: @lettre_order }
      else
        format.html { render action: "new" }
        format.json { render json: @lettre_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /lettre_orders/1
  # PUT /lettre_orders/1.json
  def update
    @lettre_order = LettreOrder.find_by_uuid(params[:id])

    authorize! :update, @lettre_order

    respond_to do |format|
      if @lettre_order.update_attributes(params[:lettre_order])
        format.html { redirect_to @lettre_order, notice: 'Lettre order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @lettre_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lettre_orders/1
  # DELETE /lettre_orders/1.json
  def destroy
    @lettre_order = LettreOrder.find_by_uuid(params[:id])
    authorize! :destroy, @lettre_order

    @lettre_order.destroy

    respond_to do |format|
      format.html { redirect_to lettre_orders_url }
      format.json { head :no_content }
    end
  end
end
