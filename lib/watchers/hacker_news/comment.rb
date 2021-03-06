#{
#  "by" : "norvig",
#  "id" : 2921983,
#  "kids" : [ 2922097, 2922429, 2924562, 2922709, 2922573, 2922140, 2922141 ],
#  "parent" : 2921506,
#  "text" : "Aw shucks, guys ... you make me blush with your compliments.<p>Tell you what, Ill make a deal: I'll keep writing if you keep reading. K?",
#  "time" : 1314211127,
#  "type" : "comment"
#}

class Watchers::HackerNews::Comment
  ATTRS = [:id, :author, :kids, :parent, :text, :time, :permalink, :user_permalink]
  attr_accessor(*ATTRS)

  def self.parse(data)
    return Watchers::HackerNews::Comment.new(data)
  end

  def initialize(data)
    @id = data['id']
    @author = data['by']
    @kids = data['kids']
    @parent = data['parent']
    @text = data['text']
    @time = data['time']
    @permalink = "https://news.ycombinator.com/item?id=#{id}"
    @user_permalink = "https://news.ycombinator.com/user?id=#{author}"
  end

  def to_hash
    {
      id: @id,
      author: @author,
      kids: @kids,
      parent: @parent,
      text: @text,
      time: @time,
      permalink: @permalink,
      user_permalink: @user_permalink,
    }
  end

  def matchable_text
    text
  end
end
