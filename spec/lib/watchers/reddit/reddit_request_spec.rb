require 'rails_helper'

RSpec.describe Watchers::Reddit::RedditRequest do
  it 'can parse /spec/api_files/reddit/comments.json' do
    f = File.read(Rails.root.join('spec', 'api_files', 'reddit', 'comments.json'))
    f = JSON.parse(f)

    request = described_class.new("cscareerquestions")
    expect(request).to receive(:get).and_return(f)
    comments = request.recent_comments
    comments.each do |comment|
      Watchers::Reddit::Comment::ATTRS.each do |attr|
        expect(comment.instance_variable_get("@#{attr}")).to be_truthy
      end
    end
  end

  it 'can parse /spec/api_files/reddit/posts.json' do
    f = File.read(Rails.root.join('spec', 'api_files', 'reddit', 'posts.json'))
    f = JSON.parse(f)

    request = described_class.new("cscareerquestions")
    expect(request).to receive(:get).and_return(f)
    posts = request.recent_posts
    posts.each do |post|
      Watchers::Reddit::Post::ATTRS.each do |attr|
        expect(post.instance_variable_get("@#{attr}")).to be_truthy
      end
    end
  end
end
