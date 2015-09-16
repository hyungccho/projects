class Cat < ActiveRecord::Base
  COLORS = [
    "gray",
    "calico",
    "white",
    "black"
  ]

  SEX = ["M", "F"]

  validates :name, :sex, presence: true
  validates :color, inclusion: { in: COLORS }
  validates :sex, inclusion: { in: SEX }

  has_many :rental_requests,
    class_name: "CatRentalRequest",
    foreign_key: "cat_id",
    primary_key: "id",
    dependent: :destroy

  def age
    birth_year, birth_month, birth_day = birth_date.to_s.split("-").map(&:to_i)

    now = Time.new
    age = now.year - birth_year

    if birth_month < now.month
      age -= 1
    elsif birth_month == now.month
      if birth_day < now.day
        age -= 1
      end
    end

    age
  end
end
