# 😂 
# 😊 
# 😻 
gem 'activerecord' #, '4.2.1'
gem 'highline'
require 'active_record'
require "highline/import"
#require "logger"

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: File.join(ENV['SMILEY_DB_PATH'] || '.', 'smileys.db'))
ActiveRecord::Base.logger = nil #Logger.new(STDOUT)

ActiveRecord::Schema.define do
  create_table :smileys do |t| 
    t.string :smile, null: false
    t.string :name, null: false
  end
end unless ActiveRecord::Base.connection.table_exists? 'smileys'

class Smiley < ActiveRecord::Base
end

#----------
group = ->results,input{
  if input.include? "group"
    rule = input.index("group") + 1
    results = results.keep_if {|n,s| n[/#{input[rule]}/] }
  end
  results
}
sort = ->results,input{
  if input.include? "sort"
    results = results.sort_by {|n,s| n}
  end
  results
}
smiles = ->results{results.map(&:last)}
process = ->input{group.(sort.(Smiley.pluck(:name, :smile),input),input)}
#---------

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
  input = ask("\n:> ").split(/ /)
  puts
  case input[0]
  when "q", "quit", "exit"
    break
  when "h", "help"
    puts menu
  when "all"
    puts smiles.(process.(input)).join(" ")
  when "everything"
    results = process.(input)
    results.each do |val_pairs|
      puts "%-#{results.max_by{|i|i[0].length}[0].length}s %s\n" % val_pairs
    end
  when "del"
    if input.length != 2
      puts "You need to provide a name for deletion"
      next
    end
    Smiley.where(name: input[1]).destroy_all
    puts "Removed!"
  else
    if input.length == 1
      smile = Smiley.where(name: input[0]).pluck(:smile).first
      smile ? puts(smile) : puts("Smile not found")
    elsif input.length == 2
      smile = Smiley.where(name: input[0]).first_or_initialize
      smile.update(smile: input[1])
      smile.save
      if smile.errors.any?
        puts smile.errors
      else
        puts "Saved!"
      end
    end
  end
end
