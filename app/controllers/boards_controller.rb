class BoardsController < ApplicationController
  def index
    agent = Mechanize.new
    url = 'http://2ch.sc/bbsmenu.html'
    page = agent.get(url)
    html = Nokogiri::HTML(page.body)
    @subbacks = []
    html.css('small a').each do |subback_title|      
      subback_url = subback_title['href'].match('http(s)?://[a-z0-9.]*.2ch.sc/[a-z0-9]+').to_s
      case subback_url
      when '' then
      when 'http://info.2ch.sc/guide' then # 2ch総合案内
      else
        subback_title['href'] = subback_title['href'].sub('http://', '').insert(0, 'subbacks/')
        title = subback_title.to_html
        subback = {title: title}
        @subbacks << subback
      end
    end
  end
end
