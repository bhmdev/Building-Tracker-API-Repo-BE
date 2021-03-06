# frozen_string_literal: true

class BuildingsController < OpenReadController
  before_action :set_building, only: %i[show update destroy]

  # GET /buildings
  def index
      # @buildings = Building.all
    @buildings = current_user.buildings

    render json: @buildings
  end

  # GET /buildings/1
  def show
    render json: @buildings
  end

  # POST /buildings
  def create
    @building = current_user.buildings.build(building_params)

    if @building.save
      render json: @building, status: :created, location: @building
    else
      render json: @building.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /buildings/1
  def update
    if @building.update(building_params)
      render json: @building
    else
      render json: @building.errors, status: :unprocessable_entity
    end
  end

  # DELETE /buildings/1
  def destroy
    @building.destroy

    head :no_content
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_building
    @building = current_user.buildings.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def building_params
    params.require(:building).permit(:address, :price, :built_date, :sq_feet,
                                     :user_id)
  end
end
