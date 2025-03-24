class VillasController < ApplicationController
  before_action :validate_dates, only: [ :index, :show ]

  def index
    villas = VillaAvailabilityService.new(@start_date, @end_date).available_villas

    villas = sort_villas(villas)

    render json: villas, methods: [ :avg_price ]
  end

  def show
    villa = Villa.find(params[:id])
    pricing_service = PricingService.new(villa, @start_date, @end_date)

    if pricing_service.available?
      render json: {
        available: true,
        base_price: pricing_service.base_price,
        gst: pricing_service.gst_amount,
        total_price: pricing_service.total_price
      }
    else
      render json: { available: false, message: "Villa is not available for all nights" }, status: :unprocessable_entity
    end
  end

  private

  def validate_dates
    @start_date = Date.parse(params[:start_date]) rescue nil
    @end_date = Date.parse(params[:end_date]) rescue nil

    if @start_date.nil? || @end_date.nil? || @start_date >= @end_date
      render json: { error: "Invalid date range" }, status: :bad_request
    end
  end

  def sort_villas(villas)
    case params[:sort]
    when "price"
      villas.order("avg_price ASC")
    when "availability"
      villas.order("count(calendars.id) DESC")
    else
      villas
    end
  end
end
