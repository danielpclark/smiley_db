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
    puts
    case input[0]
    when "all"
      puts Smiley.pluck(:smile).join(" ")
    when "everything"
      results = Smiley.pluck(:name, :smile)
      results.each do |val_pairs|
        puts "%-#{results.max_by{|i|i[0].length}[0].length}s %s\n" % val_pairs
      end
    else
      smile = Smiley.where(name: input[0]).pluck(:smile).first
      smile ? puts(smile) : puts("Smile not found")
    end
    puts
  when 2
    case input[0]
    when "del"
      Smiley.where(name: input[1]).destroy_all
      puts "Removed!"
    else
      smile = Smiley.where(name: input[0]).first_or_initialize
      smile.update(smile: input[1])
      smile.save
      if smile.errors.any?
        puts smile.errors
      else
        puts "Saved!"
      end
    end
    puts
  end
end
