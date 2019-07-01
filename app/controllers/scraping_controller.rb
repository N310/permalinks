class ScrapingController < ApplicationController
  require 'open-uri'
  require 'nokogiri'

  def new
    if info_params.present?
      charset = nil
      page_no = 1
      @path_data = []
      @errors = []

      @errors.push("TOPページのURLを正しい形式で入力してください。") if info_params[:url].match(%r{https?://[\w.-]+\/?$}).nil?
      @errors.push("投稿記事 aタグのセレクタを入力してください。") if info_params[:selector].blank?
      return render action: "new" if @errors.present?

      @host = info_params[:url].gsub(/(.*[^\/])\/?$/, '\1')
      @link_selecter = info_params[:selector]

      begin
        url = "#{@host}/page/#{page_no}"
        while true
          html = open(url) do |f|
            charset = f.charset
            f.read
          end
          doc = Nokogiri::HTML.parse(html, nil, charset)

          post_links = doc.css(@link_selecter)
          post_links.each do |post_link|
            path = post_link.attributes["href"].value.gsub(/#{@host}(.*[^\/])\/?$/, '\1')
            @path_data.push(path)
          end

          page_no += 1
          url = "#{@host}/page/#{page_no}"
        end
        render action: "new"

      rescue OpenURI::HTTPError => error
        @no_data = true if @path_data.length
        render action: "new"
      end
    end
  end

  private

  def info_params
    params.permit(:url, :selector)
  end
end
