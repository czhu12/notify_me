FactoryBot.define do
  factory :social_watcher do
    score 1

    trait :hacker_news do
      source SocialWatcher::HACKER_NEWS_STORY
    end

    meta = { :subreddit => 'cscareerquestions' }
    trait :reddit_comment do
      source SocialWatcher::REDDIT_COMMENT
      metadata meta
    end

    trait :reddit_post do
      source SocialWatcher::REDDIT_POST
      metadata meta
    end
  end
end
