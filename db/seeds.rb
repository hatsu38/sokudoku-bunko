require 'zip'
require 'csv'
require 'open-uri'

WORK_TITLE = '作品名'
WORK_TXT_ZIP_URL = 'テキストファイルURL'
base_dir = 'db/txt/'

CSV.foreach('db/list_person_all_extended_utf8.csv', headers: true).with_index  do |row, i|
  begin
    open(URI.escape(row[WORK_TXT_ZIP_URL])) do |file|
      Zip::File.open_buffer(file.read) do |zip|
        zip.each do |entry|
          next unless entry.name.end_with?(".txt")
          Dir::mkdir(base_dir + entry.name.delete('.txt'))
          save_path = entry.name.delete('.txt') + "/" + entry.name
          zip.extract(entry, base_dir + save_path) { true }
          Book.create!(title: row[WORK_TITLE], txt_file: save_path)
        end
      end
    end
  rescue
    next
  end
end

system('bash bin/script/all_encode.sh')
system('bundle exec rails txt_fix:all_txt_fix')
