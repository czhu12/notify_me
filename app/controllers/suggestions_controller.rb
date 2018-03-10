class SuggestionsController < ApplicationController
  def index
    source = params[:source]
    query = params[:query]

    if SocialWatcher::REDDIT.include?(source.to_i)
      suggestions = Watchers::Reddit::RedditSearchRequest.new(query).fetch
      subreddits = order_by_frequency(
        suggestions.map { |suggestion| suggestion['data']['subreddit'] }
      )[0..5]
      return render :json => { suggestions: subreddits }
    end
    render :json => { suggestions: [] }
  end

  def order_by_frequency(subreddits)
    counts = Hash.new(0)
    subreddits.each { |name| counts[name] -= 1 }
    sorted = subreddits.sort_by { |v| counts[v] }.uniq
    sorted
  end
end
