class Job < ApplicationRecord
  validates :title, :level_of_interest, :city, presence: true

  has_many :comments
  belongs_to :company
  belongs_to :category

  def sorted_comments
    comments.order(created_at: :desc)
  end

  def self.count_by_interest
    group(:level_of_interest).count
  end


  def self.jobs_by_location(location)
    where(city: location)
  end

  def self.top_companies
    joins(:company).group(:name).
    order("average_level_of_interest desc").
    average(:level_of_interest).take(3)
  end

  def self.sort_by(param)
    binding.pry
    if param == "location"
      order(:city)
    elsif param == "interest"
      order(:level_of_interest)
    else
    end
  end

  def self.count_by_location
    group(:city).count
  end

end
