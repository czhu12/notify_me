require 'rails_helper'

RSpec.describe Watchers::HackerNews::HackerNewsRequest do
  it 'can parse /spec/api_files/hacker_news/comment.json' do
    f = File.read(Rails.root.join('spec', 'api_files', 'hacker_news', 'comment.json'))
    f = JSON.parse(f)
    comment = Watchers::HackerNews::Comment.parse(f)
    Watchers::HackerNews::Comment::ATTRS.each do |attr|
      expect(comment.instance_variable_get("@#{attr}")).to be_truthy
    end
  end

  it 'can parse /spec/api_files/hacker_news/story.json' do
    f = File.read(Rails.root.join('spec', 'api_files', 'hacker_news', 'story.json'))
    f = JSON.parse(f)
    story = Watchers::HackerNews::Story.parse(f)
    Watchers::HackerNews::Story::ATTRS.each do |attr|
      expect(story.instance_variable_get("@#{attr}")).to be_truthy
    end
  end
end
