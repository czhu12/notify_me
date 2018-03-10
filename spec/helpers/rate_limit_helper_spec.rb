require 'rails_helper'

RSpec.describe RateLimitHelper do
  include RateLimitHelper

  it 'saves rate limits in redis' do
    expect(REDIS).to receive(:set).with('key', 1)
    expect(REDIS).to receive(:expire).with('key', 2)

    rate_limited('key', 2) do
      sleep(1)
    end
  end

  it 'rate limits' do
    start_time = Time.now
    REDIS.set('key', 1)
    REDIS.expire('key', 1)

    rate_limited('key', 0) do
      end_time = Time.now
      # Lets assume it will be at least 2 seconds
      expect((end_time - start_time) >= 0.5).to be true
    end
  end
end
