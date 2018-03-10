class Alert < ApplicationRecord
  belongs_to :social_watcher

  validates_presence_of :social_watcher_id
  validates_presence_of :data_id
  validates_presence_of :data
  validates_uniqueness_of :data_id

  serialize :data, Hash
end
