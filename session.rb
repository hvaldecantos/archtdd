require 'active_record'
require './db_schema'

class Session < ActiveRecord::Base
	belongs_to :user
	EXPIRE_TIMEOUT_SECONDS = 60

	def is_expired
		return Time.now - self.created_at > EXPIRE_TIMEOUT_SECONDS
	end
end