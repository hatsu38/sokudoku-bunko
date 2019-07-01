# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Book.create(title: 'こころ', sentence: '太郎はこの本を二郎を見た女性に渡した。')

# require 'natto'
# natto = Natto::MeCab.new
# Book.create(title: 'こころ', sentence: natto.parse(File.read('db/txt/kokoro_result.txt')))
text = ''
File.open("db/txt/kokoro_result.txt", mode = "r") do |f|
  f.each_line do |line|
    next line if /^\s*$/ =~ line
    break if f.lineno >= 50
    text = text + line
  end
end

Book.create(title: 'こころ', sentence: text.gsub(" ", ""))

# File.open("db/txt/kokoro_result.txt", mode = "r") do |f|
#   f.each_line(rs="") do |line|
#     break if f.lineno >= 1
#     Book.create(title: 'こころ', sentence: line.chomp(rs=""))
#   end
# end

