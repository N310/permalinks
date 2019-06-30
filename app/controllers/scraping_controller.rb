class ScrapingController < ApplicationController
  # URLにアクセスするためのライブラリの読み込み
  require 'open-uri'
  # Nokogiriライブラリの読み込み
  require 'nokogiri'

  def new
    charset = nil
    page_no = 1
    @path_data = []
    @host = "https://310nae.com"
    url = "#{@host}/page/#{page_no}"
    link_selecter = ".post-list a"

    begin
      while true
        html = open(url) do |f|
          charset = f.charset # 文字種別を取得
          f.read # htmlを読み込んで変数htmlに渡す
        end

        # htmlをパース(解析)してオブジェクトを生成
        doc = Nokogiri::HTML.parse(html, nil, charset)

        post_links = doc.css(link_selecter)
        post_links.each do |post_link|
          path = post_link.attributes["href"].value.gsub(/#{@host}/, "")
          @path_data.push(path)
        end

        page_no += 1
        url = "#{@host}/page/#{page_no}"
      end

    rescue OpenURI::HTTPError => error
    end
  end
end
