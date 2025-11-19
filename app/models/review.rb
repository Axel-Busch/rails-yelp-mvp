class Review < ApplicationRecord
  belongs_to :restaurant

  validates :rating, presence: true, inclusion: { in: (0..5) }, numericality: {only_integer: true}
  validates :content, presence: true

  def self.average_rating(reviews)
    return 0 if reviews.empty?

    total_rating = reviews.sum(&:rating)
    (total_rating.to_f / reviews.size).round(2)
  end
end
