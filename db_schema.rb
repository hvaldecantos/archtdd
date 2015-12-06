require 'sqlite3'
require 'active_record'

if ENV["ENV"] == "test"
  db = ":memory:"
else
  db = "database.db"
end

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: db
)

ActiveRecord::Schema.define do
  if !ActiveRecord::Base.connection.table_exists?(:users)
    create_table :users, force: true do |t|
      t.string :name
      t.string :password
      t.string :role, default: "guest"
    end
  end
  if !ActiveRecord::Base.connection.table_exists?(:sessions)
    create_table :sessions, force: true do |t|
      t.belongs_to :user, index: true
      t.datetime :created_at
      t.string :token
    end
  end
end
