class RoutesController < ApplicationController
  before_action :set_route, only: [:show, :edit, :update, :destroy]

  # GET /routes
  # GET /routes.json
  def index
    @routes = Route.all
  end

  # GET /routes/1
  # GET /routes/1.json
  def show
  end

  # GET /routes/new
  def new
    @route = Route.new
  end

  # GET /routes/1/edit
  def edit
  end

  # POST /routes
  # POST /routes.json
  def create
    @route = Route.new(route_params)

    respond_to do |format|
      if @route.save
        format.html { redirect_to @route, notice: 'Route was successfully created.' }
        format.json { render :show, status: :created, location: @route }
      else
        format.html { render :new }
        format.json { render json: @route.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /routes/1
  # PATCH/PUT /routes/1.json
  def update
    respond_to do |format|
      if @route.update(route_params)
        format.html { redirect_to @route, notice: 'Route was successfully updated.' }
        format.json { render :show, status: :ok, location: @route }
      else
        format.html { render :edit }
        format.json { render json: @route.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /routes/1
  # DELETE /routes/1.json
  def destroy
    @route.destroy
    respond_to do |format|
      format.html { redirect_to routes_url, notice: 'Route was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def auto_assign_routes
    routes = Route.unassigned_routes
    drivers = Driver.ids_all_drivers_order_by_cities
    routes.order("starts_at asc").each do |route|
      assign_route(route, drivers, "first")      
    end
    routes = Route.unassigned_routes
    drivers = Route.get_drivers_with_a_route
    routes.each do |route|      
      assign_route(route, drivers, "second")
    end
    @routes = Route.all
  end

  def reset_routes  
    respond_to do |format|  
      if Route.all.update_all(driver_id: nil, vehicle_id: nil)
        format.html { redirect_to routes_path, notice: "Rutas reseteadas." }
      else
        format.html { render :new , notice: "error"}
      end
    end
  end

  private

    def assign_route(route, drivers, route_type)
      cities_ok = false
      assigned_driver = nil     
      assigned_vehicle = nil 
      candidate_vehicle = nil
      candidate_driver = nil
      max_stops_amount= nil
      drivers.each do |driver|

        candidate_driver = Driver.find(driver)
        if !candidate_driver.vehicle_id.nil?        
          candidate_vehicle = candidate_driver.vehicle
        else
          if route_type == "first"
            candidate_vehicle = Vehicle.where.not(id: Route.all.pluck(:vehicle_id))
                                       .where("capacity >= ? AND load_type = ?",route.load_sum, route.load_type).first
          else 
            route_search = Route.find_by(driver_id: candidate_driver.id)
            candidate_vehicle = Vehicle.find(route_search.vehicle_id)                                     
          end
        end

        route.cities.split(",").each do |city|
          if !candidate_driver.specific_cities.nil?
            if candidate_driver.specific_cities.include? city
              cities_ok = true
            else
              cities_ok = false
            end
          else
            cities_ok = true
          end
        end
        
        if candidate_driver.max_stops_amount.nil?
          max_stops_amount = 99
        else
          max_stops_amount = candidate_driver.max_stops_amount
        end
    
        if !candidate_vehicle.nil?
          if route_type == "first"
            if ((cities_ok == true) && 
              (max_stops_amount >= route.stops_amount ) && 
              (candidate_vehicle.capacity >= route.load_sum) && 
              (route.load_type == candidate_vehicle.load_type))
              assigned_driver = candidate_driver  
              assigned_vehicle = candidate_vehicle          
              drivers.delete(driver)
              break
            end       
          else
            pre_assigned_route = Route.find_by(driver_id: candidate_driver.id)
            if ((cities_ok == true) && 
              (max_stops_amount >= route.stops_amount ) && 
              (candidate_vehicle.capacity >= route.load_sum) && 
              (route.load_type == candidate_vehicle.load_type) &&
              (route.starts_at > pre_assigned_route.ends_at))
              assigned_driver = candidate_driver  
              assigned_vehicle = candidate_vehicle          
              drivers.delete(driver)
              break       
            end
          end 
            assigned_vehicle = nil
            assigned_driver = nil         
        end
      end

      if (assigned_driver != nil && assigned_vehicle != nil)
        route.update_columns(vehicle_id: assigned_vehicle.id, driver_id: assigned_driver.id)      
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_route
      @route = Route.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def route_params
      params.require(:route).permit(:starts_at, :ends_at, :load_type, :load_sum, :cities, :stops_amount)
    end
end
