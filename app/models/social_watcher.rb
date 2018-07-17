class SocialWatcher < ApplicationRecord
  HACKER_NEWS_STORY = 0
  REDDIT_POST = 1
  REDDIT_COMMENT = 2

  HACKER_NEWS = [
    HACKER_NEWS_STORY
  ]

  REDDIT = [
    REDDIT_POST,
    REDDIT_COMMENT,
  ]

  ALLOWED_SOURCES = [
    HACKER_NEWS_STORY,
    REDDIT_POST,
    REDDIT_COMMENT,
  ]

  SOURCE_NAMES = {
    HACKER_NEWS_STORY => "Hacker News",
    REDDIT_POST => "Reddit Post",
    REDDIT_COMMENT => "Reddit Comment",
  }

  belongs_to :listener
  has_many :alerts
  serialize :metadata, Hash

  validates_inclusion_of :source, :in => ALLOWED_SOURCES
  validates_presence_of :source
  validates_presence_of :listener_id
  validate :validate_metadata

  def validate_metadata
    if reddit?
      unless metadata[:subreddit]
        errors.add(:metadata, "reddit metadata needs to contain subreddit")
      end
    end
  end

  def hacker_news_story?
    source == HACKER_NEWS_STORY
  end

  def reddit?
    reddit_post? || reddit_comment?
  end

  def reddit_post?
    source == REDDIT_POST
  end

  def reddit_comment?
    source == REDDIT_COMMENT
  end

  def fetch_data
    if source == HACKER_NEWS_STORY
      # This should be cached
      Watchers::HackerNews::HackerNewsRequest.build_request('topstories').request
    elsif source == REDDIT_POST
      Watchers::Reddit::RedditRequest.build_request(
        metadata[:subreddit]
      ).top_posts
    elsif source == REDDIT_COMMENT
      Watchers::Reddit::RedditRequest.build_request(
        metadata[:subreddit],
      ).recent_comments
    end
  end

  def create_alert(data)
    return Alert.new(
      data_id: data.id,
      text: data.matchable_text,
      permalink: data.permalink,
      username: data.author,
      user_permalink: data.user_permalink,
      social_watcher: self,
      data: data.to_hash, # All other attributes that are potentially relevant but not required
    )
  end

  def rate_limit_key
    if source == HACKER_NEWS_STORY
      return 'hacker-news-key'
    elsif source == REDDIT_POST
      return 'reddit-key'
    elsif source == REDDIT_COMMENT
      return 'reddit-key'
    end
    'unknown-key'
  end

  def rate_limit_time
    if source == HACKER_NEWS_STORY
      # Lets not hammer their endpoint even if they don't set rate limits
      return 0.25
    elsif source == REDDIT_POST
      return 1
    elsif source == REDDIT_COMMENT
      return 1
    end
    1
  end

  def source_name
    if hacker_news_story?
      'Hacker News'
    else
      'Reddit'
    end
  end
end
