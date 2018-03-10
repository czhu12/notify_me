require 'rails_helper'

class HackerNewsRequestMock
  def request
  end
end

class RedditRequestMock
  def top_posts
  end

  def recent_comments
  end
end

describe SocialWatcher do
  before do
    @hacker_news = HackerNewsRequestMock.new
    @reddit = RedditRequestMock.new
    allow(Watchers::HackerNews::HackerNewsRequest).to receive(:build_request).and_return(
      @hacker_news
    )
    allow(Watchers::Reddit::RedditRequest).to receive(:build_request).and_return(
      @reddit
    )
  end

  context 'reddit' do
    it 'requests posts' do
      expect(@reddit).to receive(:top_posts)
      social_watcher = build(:social_watcher, :reddit_post)
      social_watcher.fetch_data
    end

    it 'requests comments' do
      expect(@reddit).to receive(:recent_comments)
      social_watcher = build(:social_watcher, :reddit_comment)
      social_watcher.fetch_data
    end
  end

  context 'hacker news' do
    it 'requests stories' do
      expect(@hacker_news).to receive(:request)
      social_watcher = build(:social_watcher, :hacker_news)
      social_watcher.fetch_data
    end
  end
end
