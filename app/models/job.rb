class Job < ApplicationRecord
  validates :title, :level_of_interest, :city, presence: true

  has_many :comments
  belongs_to :company
  belongs_to :category

  def sorted_comments
    comments.order(created_at: :desc)
  end

  def self.count_by_interest
    Job.group(:level_of_interest).count
  end

end
