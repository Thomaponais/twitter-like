module TweetsHelper
  def older_brother? (tweet)
    has_older_brother = false
    if !tweet.root? && tweet.self_and_siblings.first != tweet
      has_older_brother = true
    end
    return has_older_brother
  end
end
