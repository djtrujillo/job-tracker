class Company < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :jobs, dependent: :destroy
  has_many :contacts

  def self.average_level_of_interest
    Company.jobs.average(:level_of_interest).order.limit(3)
  end
end
