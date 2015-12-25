# smiley_db
ASCII command line database for storing smileys you find.  Copy and paste any smiley into your terminal to save it!

![alt text](https://github.com/danielpclark/smiley_db/blob/master/example.png "CLI example")

#Getting Started

```
git clone https://github.com/danielpclark/smiley_db.git
gem install activerecord highline sqlite3
ruby smiley.rb
```

#Usage

```ruby
<name>          # => lookup smiley
<name> <smiley> # => create smiley
all             # => prints all smileys inline
everything      # => prints catalog of name: smiley
del <name>      # => delete smiley
```
**all** and **everything** accept parameters `sort` and `group <word>` and the word can be in regex form

#License
MIT (see LICENSE file)
