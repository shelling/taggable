require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: "taggable.sqlite",
)

ActiveRecord::Schema.define do
  create_table :documents, if_not_exists: true do |table|
    table.column :created_at, :datetime
    table.column :updated_at, :datetime
  end

  create_table :nodes, if_not_exists: true do |table|
    table.column :created_at, :datetime
    table.column :updated_at, :datetime
    table.column :parent_id, :integer
    table.column :parent_type, :string
    table.column :kind, :integer
    table.column :content, :string
  end
end

$:.unshift "."

require 'document'
require 'node'
