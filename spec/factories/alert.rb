FactoryBot.define do
  factory :alert do
    text 'hello'
    permalink 'http://example.com/123'
    user_permalink 'http://example.com/user-123'
  end
end
