require 'active_record'
require './db_schema'

class Session < ActiveRecord::Base
  belongs_to :user
  validates :user_id, uniqueness: true
  EXPIRE_TIMEOUT_SECONDS = 60

  def initialize opt = {}
    super opt
    self.token = Digest::SHA1.hexdigest Time.now.to_f.to_s
  end
  def is_expired?
    return Time.now - self.created_at > EXPIRE_TIMEOUT_SECONDS
  end
end
