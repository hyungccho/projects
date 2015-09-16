class CatRentalRequest < ActiveRecord::Base
  STATUSES = ["PENDING", "APPROVED", "DENIED"]

  validates :status, inclusion: { in: STATUSES }
  validates :cat_id, :start_date, :end_date, presence: true
  validate :overlapping_approved_requests

  after_initialize do |request|
    request.status ||= "PENDING"
  end

  belongs_to :cat,
    class_name: "Cat",
    foreign_key: "cat_id",
    primary_key: "id"

  def overlapping_requests
    cat.rental_requests.select do |request|
      request.end_date >= start_date && end_date >= request.start_date && request != self
    end
  end

  def overlapping_approved_requests
    approved_requests = overlapping_requests.select do |request|
      request.status == "APPROVED"
    end

    approved_requests.empty?
  end

  def approve!
    CatRentalRequest.transaction do
      self.status = "APPROVED"
      save!

      overlapping_requests.each do |request|
        request.deny!
      end
    end
  end

  def deny!
    self.status = "DENIED"
    save!
  end
end
