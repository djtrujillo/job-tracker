class Company < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :jobs, dependent: :destroy
  has_many :contacts

  # def self.top_three_by_interest
  #   binding.pry
  #   Company.jobs.average(:level_of_interest).order.limit(3)
  # end
end
