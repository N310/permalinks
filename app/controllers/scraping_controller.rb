class ScrapingController < ApplicationController
  # URLにアクセスするためのライブラリの読み込み
  require 'open-uri'
  # Nokogiriライブラリの読み込み
  require 'nokogiri'

  def new
    charset = nil
    page_no = 1
    @url_data = []
    # スクレイピング先のURL
    url = "https://310nae.com/page/#{page_no}"

    begin
      while true
        html = open(url) do |f|
          charset = f.charset # 文字種別を取得
          f.read # htmlを読み込んで変数htmlに渡す
        end

        # htmlをパース(解析)してオブジェクトを生成
        doc = Nokogiri::HTML.parse(html, nil, charset)

        post_links = doc.css(".post-list a")
        post_links.each do |post_link|
          @url_data.push(post_link.attributes["href"].value)
        end

        page_no += 1
        url = "https://310nae.com/page/#{page_no}"
      end
    rescue OpenURI::HTTPError => error
    end
  end
end
