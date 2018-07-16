class Watchers::Reddit::Post
  ATTRS = [:author, :subreddit, :permalink, :url, :title, :body, :score, :id, :user_permalink]
  attr_accessor(*ATTRS)

  def self.parse(data)
    Watchers::Reddit::Post.new(data['data'])
  end
  
  def initialize(data)
    @author = data['author']
    @subreddit = data['subreddit']
    @permalink = "https://reddit.com/#{data['permalink']}"
    @url = data['url']
    @title = data['title']
    @body = data['selftext']
    @score = data['score']
    @id = data['id']
    @user_permalink = "https://www.reddit.com/user/#{author}"
  end

  def matchable_text
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
      user_permalink: user_permalink,
    }
  end
end
