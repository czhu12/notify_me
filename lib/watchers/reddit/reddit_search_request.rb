class Watchers::Reddit::RedditSearchRequest < Watchers::Reddit::RedditRequest
  include Watchers::RequestHelpers

  BASE_URL = "https://www.reddit.com/search.json"
  def initialize(query)
    @query = query
  end

  def fetch
    response = HTTParty.get(BASE_URL, {
      query: { q: @query },
      headers: {"User-Agent" => random_user_agent},
    })
    if response.code >= 400
      []
    else
      JSON.parse(response.body)['data']['children']
    end
  end
end
