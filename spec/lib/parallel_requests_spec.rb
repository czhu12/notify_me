require 'rails_helper'

RSpec.describe ParallelRequests do
  before do
    allow(HTTParty).to receive(:get).and_return({})
  end

  it 'correctly requests all URLs' do
    urls = [*1..10].map { |i| "example.com/#{i}" }
    results = ParallelRequests.fetch_parallel(urls)
    urls.each do |url|
      expect(results.key?(url)).to be true
    end
  end
end
