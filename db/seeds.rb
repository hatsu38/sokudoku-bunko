# frozen_string_literal: true

require 'zip'
require 'csv'
require 'open-uri'

WORK_TITLE = '作品名'
WORK_TXT_ZIP_URL = 'テキストファイルURL'
base_dir = 'db/txt/'

CSV.foreach('db/list_person_all_extended_utf8.csv', headers: true).with_index do |row, i|
  break if i > 12
  URI.parse(URI.escape(row[WORK_TXT_ZIP_URL])).open do |file|
    Zip::File.open_buffer(file.read) do |zip|
      zip.each do |entry|
        next unless entry.name.end_with?('.txt')

        save_path = entry.name.delete('.txt') + '/' + entry.name
        author = Author.find_by(authorid: row['人物ID'])
        if author.nil?
          author = Author.create!(name: row['姓'] + row['名'], birthday: row['生年月日'], authorid: row['人物ID'])
        end
        book = Book.find_by(bookid: row['作品ID'])
        if book.nil?
          published_str = row['底本初版発行年1'].gsub!(/（(.*?)）/,'')
          published = Date.strptime(published_str,'%Y年%m月%d日')
          book = author.books.create!(title: row[WORK_TITLE], published: published, txt_file: save_path, bookid: row['作品ID'])
          Dir.mkdir(base_dir + entry.name.delete('.txt'))
          zip.extract(entry, base_dir + save_path) { true }
        end

        if book.rakuten_book_info.nil?
          item = RakutenWebService::Ichiba::Item.search(keyword: book.title) ? RakutenWebService::Ichiba::Item.search(keyword: book.title).first : nil
          small_image_url = item['smallImageUrls'] ? item['smallImageUrls'][0] : nil
          medium_image_url = item['mediumImageUrls'] ? item['mediumImageUrls'][0] : nil
          if item
            book.create_rakuten_book_info(
              price: item['itemPrice'],
              affiliate_url: item['affiliateUrl'],
              small_image_url: small_image_url,
              medium_image_url: medium_image_url,
              caption: item['itemCaption']
            )
          end
        end
      end
    end
  end
rescue => e
  Rails.logger.warn e
  next
end

system('bash bin/script/all_encode.sh')
system('bundle exec rails txt_fix:all_txt_fix')
