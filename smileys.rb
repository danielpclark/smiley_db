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
menu = <<-DOC
#{horizontal_line}
   <name>             lookup smiley
   <name> <smiley>    create smiley
   all                prints all smileys inline
   everything         prints catalog of name: smiley
   del <name>         delete smiley
   h, help            this menu
   q                  exit
#{horizontal_line}
DOC

puts horizontal_line, "\t  Smiley DB by Daniel P. Clark"
puts menu

loop do
  input = ask "\n:> "
  break if input == "q"
  input = input.split(/ /)
  case input.length
  when 1
    puts
    case input[0]
    when "h", "help"
      puts menu
    when "all"
      puts Smiley.pluck(:smile).join(" ")
    when "everything"
      results = Smiley.pluck(:name, :smile)
      results.each do |val_pairs|
        puts "%-#{results.max_by{|i|i[0].length}[0].length}s %s\n" % val_pairs
      end
      ask "Hit [Enter] to continue"
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
