class Watchers::Reddit::RedditRequest
  include Watchers::RequestHelpers

  RATE_LIMIT = 1 # RPS
  attr_accessor :subreddit

  def self.build_request(subreddit)
    Watchers::Reddit::RedditRequest.new(subreddit)
  end

  def initialize(subreddit)
    @subreddit = subreddit
  end

  def recent_posts
    url = "https://reddit.com/r/#{subreddit}/new.json?limit=100"
    body = get(url)
    body['data']['children'].map do |post|
      Watchers::Reddit::Post.parse(post)
    end
  end

  def recent_comments
    url = "https://reddit.com/r/#{subreddit}/comments.json?limit=100"
    body = get(url)
    body['data']['children'].map do |comment|
      Watchers::Reddit::Comment.parse(comment)
    end
  end

  def top_posts
    url = "https://reddit.com/r/#{subreddit}/json?limit=100"
    body = get(url)
    body['data']['children'].map do |post|
      Watchers::Reddit::Post.parse(post)
    end
  end

  def get(url)
    response = HTTParty.get(url, {
      headers: {"User-Agent" => random_user_agent},
    })
    if response.code > 400
      #TODO: Alert to datadog
    end
    JSON.parse(response.body)
  end
end
