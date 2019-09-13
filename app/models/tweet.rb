class Tweet < ApplicationRecord
  belongs_to :user
	validates :tweet, presence: true, length: { maximum: 140 }
  acts_as_votable
  acts_as_nested_set :dependent => :nullify

  def delete_tweet_keep_sub_tweets
    if self.child?
      self.move_children_to_immediate_parent
    else
      self.move_children_to_root
    end
  end

  def move_children_to_immediate_parent
    tweet_immediate_children = self.children
    tweet_immediate_parent = self.parent
    tweet_immediate_children.each do |child|
      child.move_to_child_of(tweet_immediate_parent)
      tweet_immediate_parent.reload
    end
  end

  def move_children_to_root
    tweet_immediate_children = self.children
    tweet_immediate_children.each do |child|
      child.move_to_root
      child.reload
    end
  end
end
