require 'rails_helper'

RSpec.describe FetchContentWorker do
  let(:listener) {
    create(:listener, email:'test@email.com', query: 'learn, programming')
  }
  let(:social_watcher) {
    build(:social_watcher, :reddit_post, listener: listener)
  }

  let(:reddit_posts) { [
    Watchers::Reddit::Post.new(
      'id' => 'id-123',
      'selftext' => 'i need help getting an amazon internship',
    ),
    Watchers::Reddit::Post.new(
      'id' => 'id-abc',
      'selftext' => 'how do i start learning programming',
    ),
  ] }

  it 'doesn\'t try to create alert if already exists' do
    worker = FetchContentWorker.new
    allow(worker).to receive(:get_watcher).and_return(
      social_watcher
    )
    allow(social_watcher).to receive(:fetch_data).and_return(reddit_posts)

    expect(social_watcher).to receive(:create_alert).once
    worker.perform(
      rate_limit_key: 'key',
      rate_limit_time: 0,
      social_watcher_id: social_watcher.id,
    )
  end
end
