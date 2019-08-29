class Tweet < ApplicationRecord
  belongs_to :user
	validates :tweet, presence: true, length: { maximum: 140 }
  acts_as_votable
  acts_as_nested_set
end
