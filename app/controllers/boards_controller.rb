class BoardsController < ApplicationController
  def index
    agent = Mechanize.new
    url = 'http://2ch.sc/bbsmenu.html'
    page = agent.get(url)
    html = Nokogiri::HTML(page.body)
    @subbacks = []
    html.css('small a').each do |subback_title|
      # subback_url = subback_title.attribute('href').match(/http(s)?://([\w-]+\.)+[\w-]+(/[\w- ./?%&=]*)?/)
      # if subback_url.blank?
      #   next
      # end
      p subback_title
      subback_title['href'] = subback_title['href'].sub('http://', '').insert(0, 'subbacks/')
      title = subback_title.to_html
      subback = {title: title}
      @subbacks << subback
    end
  end
end
