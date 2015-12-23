# 😂 
# 😊 
# 😻 
gem 'activerecord' #, '4.2.1'
gem 'highline'
require 'active_record'
require "highline/import"
#require "logger"


ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'smileys.db')
ActiveRecord::Base.logger = nil #Logger.new(STDOUT)

ActiveRecord::Schema.define do
  create_table :smileys do |t| 
    t.string :smile, null: false
    t.string :name, null: false
  end
end unless ActiveRecord::Base.connection.table_exists? 'smileys'

class Smiley < ActiveRecord::Base
end

horizontal_line = "~_" * 24 + "~"

loop do
  puts horizontal_line
  puts "Enter name to retrieve smiley"
  puts "Enter name followed by smiley to store smiley"
  puts "Enter q to quit"
  input = ask horizontal_line + "\n\n"
  break if input == "q"
  input = input.split(/ /)
  case input.length
  when 1
    smile = Smiley.where(name: input[0]).pluck(:smile).first
    if smile
      puts
      puts smile
      puts
    else
      puts
      puts "Smile not found"
      puts
    end
  when 2
    smile = Smiley.create(name: input[0], smile: input[1])
    if smile.errors.any?
      puts smile.errors
    else
      puts "Saved!"
      puts
    end
  end
end
