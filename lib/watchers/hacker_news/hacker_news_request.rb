class Watchers::HackerNews::HackerNewsRequest
  """
  Lists:
  'https://hacker-news.firebaseio.com/v0/topstories.json'
  'https://hacker-news.firebaseio.com/v0/newstories.json'
  'https://hacker-news.firebaseio.com/v0/askstories.json'

  Any Item:
  'https://hacker-news.firebaseio.com/v0/item/121003.json'
  """

  TYPE_STORY = 'story'
  TYPE_COMMENT = 'comment'
  ITEM_TYPES = [
    TYPE_STORY,
    TYPE_COMMENT,
  ]
  LISTS = [
    'topstories',
    'newstories',
    'askstories',
  ]
  attr_accessor :list

  def self.build_request(list)
    raise StandardError unless LISTS.include?(list)
    Watchers::HackerNews::HackerNewsRequest.new(list)
  end

  def initialize(list)
    @list = list
  end

  def request
    response = HTTParty.get("https://hacker-news.firebaseio.com/v0/#{list}.json")
    items = JSON.parse(response.body)
    urls = items.map { |item_id| "https://hacker-news.firebaseio.com/v0/item/#{item_id}.json" }
    responses = ParallelRequests.fetch_parallel(urls)
    stories = responses.map do |url, response|
      if response.code >= 400
        # TODO: log to datadog
      end

      body = JSON.parse(response.body)
      story = Watchers::HackerNews::Story.parse(body)
      story
    end

    stories = stories.select { |s| s }
    stories.each do |story|
      story.comments
    end
    stories
  end
end
