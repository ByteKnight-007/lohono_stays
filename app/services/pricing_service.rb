class PricingService
  GST_RATE = 0.18

  def initialize(villa, start_date, end_date)
    @villa = villa
    @start_date = start_date
    @end_date = end_date
    @nights = villa.calendars.where(date: start_date...end_date)
  end

  def available?
    required_nights = (@end_date - @start_date).to_i
    @nights.count == required_nights && @nights.all?(&:available)
  end

  def base_price
    @nights.sum(&:price)
  end

  def gst_amount
    base_price * GST_RATE
  end

  def total_price
    base_price + gst_amount
  end
end
