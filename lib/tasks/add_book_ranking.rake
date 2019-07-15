# frozen_string_literal: true

namespace :ranking do
  desc '引数に設定した数までのランキングを収集する'
  task :add_ranking, [:ranking] => :environment do |_, args|
    require 'mechanize'
    RANKING_URL = 'https://www.aozora.gr.jp/access_ranking/2019_04_xhtml.html'

    agent = Mechanize.new
    page = agent.get(RANKING_URL)
    trs = page.search('table.list tbody tr')
    trs.each_with_index do |tr, i|
      break if i > args.ranking.to_i

      ranking_tag = tr.at('.normal')
      book_link_tag = tr.at('.normal a')
      next if ranking_tag.nil? || book_link_tag.nil?

      ranking = get_ranking(ranking_tag)
      card_num = get_card_num(book_link_tag)
      next if ranking.nil? || card_num.nil?

      book = Book.find_by(bookid: card_num)
      next if book.nil? || book.ranking

      book.create_ranking(rank: ranking)
    end
  end
end

def get_ranking(ranking_tag)
  return nil if ranking_tag.nil?

  ranking_tag.inner_text.to_i
end

def get_card_num(book_link_tag)
  book_link = book_link_tag.get_attribute(:href)
  card_num_html = book_link.match(/card\d+\.html/)
  return nil if card_num_html.nil?

  card_num = card_num_html[0].match(/\d+/)
  return nil if card_num.nil?

  card_num[0].to_i
end
