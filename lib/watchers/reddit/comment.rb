class Watchers::Reddit::Comment
  ATTRS = [:author, :subreddit, :permalink, :url, :body, :score, :id]
  attr_accessor(*ATTRS)

  def self.parse(data)
    Watchers::Reddit::Comment.new(data['data'])
  end

  def initialize(data)
    @author = data['author']
    @subreddit = data['subreddit']
    @permalink = data['permalink']
    @url = data['link_permalink']
    @body = data['body']
    @score = data['score']
    @id = data['id']
  end

  def matchable_text
    body
  end

  def to_hash
    {
      id: id,
      author: author,
      subreddit: subreddit,
      permalink: permalink,
      url: url,
      body: body,
      score: score,
    }
  end
end
