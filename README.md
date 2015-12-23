# smiley_db
ASCII command line database for storing smileys you find.  Copy and paste any smiley into your terminal to save it!

![alt text](https://github.com/danielpclark/smiley_db/blob/master/example.png "CLI example")

#Getting Started

```
git clone https://github.com/danielpclark/smiley_db.git
gem install activerecord highline
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

#License
MIT (see LICENSE file)
