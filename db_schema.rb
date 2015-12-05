require 'sqlite3'
require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)

ActiveRecord::Schema.define do
  create_table :users, force: true do |t|
    t.string :name
    t.string :password
    t.string :role, default: "guest"
  end
  create_table :sessions, force: true do |t|
    # t.string :token
    t.belongs_to :user, index: true
    t.datetime :created_at
    t.string :token
  end
end