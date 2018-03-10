class Watchers::Reddit::Post
  ATTRS = [:author, :subreddit, :permalink, :url, :title, :body, :score, :id]
  attr_accessor(*ATTRS)

  def self.parse(data)
    Watchers::Reddit::Post.new(data['data'])
  end
  
  def initialize(data)
    @author = data['author']
    @subreddit = data['subreddit']
    @permalink = data['permalink']
    @url = data['url']
    @title = data['title']
    @body = data['selftext']
    @score = data['score']
    @id = data['id']
  end

  def text
    "#{title} #{body}"
  end

  def to_hash
    {
      id: id,
      author: author,
      subreddit: subreddit,
      permalink: permalink,
      url: url,
      title: title,
      body: body,
      score: score,
    }
  end
end
