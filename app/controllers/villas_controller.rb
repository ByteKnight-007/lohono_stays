class VillasController < ApplicationController
  before_action :validate_dates, only: [ :index, :show ]


  def index
    villas = Villa.available_villas(@start_date, @end_date)

    if params[:sort] == "price"
      villas = villas.order("avg_price ASC")
    elsif params[:sort] == "availability"
      villas = villas.order("count(calendars.id) DESC")
    end

    render json: villas, methods: [ :avg_price ]
  end


  def show
    villa = Villa.find(params[:id])
    nights = villa.calendars.where(date: @start_date...@end_date)

    if nights.count == (@end_date - @start_date).to_i && nights.all?(&:available)
      actual_price = nights.sum(&:price)
      gst_rate = 0.18
      gst_amount = (actual_price * gst_rate).round(2)
      total_price = (actual_price + gst_amount).round(2)

      render json: {
        available: true,
        actual_price: actual_price,
        gst_rate: "#{(gst_rate * 100).to_i}%",
        gst_amount: gst_amount,
        total_price: total_price
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
end
