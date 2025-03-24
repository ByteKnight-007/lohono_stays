class VillaAvailabilityService
  def initialize(start_date, end_date)
    @start_date = start_date
    @end_date = end_date
  end

  def available_villas
    Villa.available_villas(@start_date, @end_date)
  end
end
