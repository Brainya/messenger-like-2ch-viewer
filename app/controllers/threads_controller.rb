class ThreadsController < ApplicationController
  def index
    agent = Mechanize.new
    url = get_url
    agent.get(url) do |page|
      html = Nokogiri::HTML(page.body)
      @title = html.css('h1').text;
      @replies = []
      html.css('dt').zip(html.css('dd')).each do |dt, dd|
        header = dt.text
        text = dd.to_html
        reply = {header: header, text: text}
        @replies << reply
      end
    end
  end

  def get_url
    url = 'http://ikura.2ch.sc/test/read.cgi/' + params[:subback_id] + '/' + params[:thread_id]
  end
end
