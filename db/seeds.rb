# require 'natto'
# natto = Natto::MeCab.new
Book.create(title: '羅生門', txt_file: 'rashomon_result.txt')
Book.create(title: '人間失格', txt_file: 'ningen_shikkaku_result.txt')
# Book.create(title: 'こころ', sentence: natto.parse(File.read('db/txt/kokoro_result.txt')))
# text = ''
# File.open("db/txt/kokoro_result.txt", mode = "r") do |f|
#   f.each_line do |line|
#     next line if /^\s*$/ =~ line
#     break if f.lineno >= 50
#     text = text + line
#   end
# end

# Book.create(title: 'こころ', sentence: text.gsub(" ", ""))

# File.open("db/txt/kokoro_result.txt", mode = "r") do |f|
#   f.each_line(rs="") do |line|
#     break if f.lineno >= 1
#     Book.create(title: 'こころ', sentence: line.chomp(rs=""))
#   end
# end
