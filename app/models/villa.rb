class Villa < ApplicationRecord
  has_many :calendars, dependent: :destroy

  def self.available_villas(start_date, end_date)
    joins(:calendars)
      .where(calendars: { date: start_date...end_date, available: true })
      .group("villas.id")
      .having("COUNT(calendars.id) = ?", (end_date - start_date).to_i)
      .select("villas.*, AVG(calendars.price) as avg_price")
  end
end
