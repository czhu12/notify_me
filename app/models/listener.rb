class Listener < ApplicationRecord
  has_many :social_watchers
  has_many :alerts, :through => :social_watchers
  ALLOWED_TOKENS = [
    '|', # and
    ',', # or
  ]

  validates_presence_of :email
  validates_presence_of :phone_number
  validates :query, presence: true, allow_blank: false
  before_create :generate_access_token

  def matches_query?(content)
    Listener.matches_query?(content, self.query)
  end

  def self.matches_query?(content, query)
    content = content.downcase
    or_matches = query.downcase.split(',')
    or_matches.each do |or_match|
      or_match = or_match.strip

      and_matches = or_match.split('|')
      contains_all = and_matches.all? do |and_match|
        and_match = and_match.strip

        content.include?(and_match)
      end

      return or_match if contains_all
    end

    false
  end

  def permalink
    "#{Notifyme::Application::APP_DOMAIN}/#{self.token}"
  end

  def source_names
    @source_names ||= self.social_watchers.map { |watcher| watcher.source_name }
  end

  private

  def generate_access_token
    begin
      self.token = SecureRandom.hex
    end while self.class.exists?(token: self.token)
  end
end
