class ThreadsController < ApplicationController
  def index
    agent = Mechanize.new
    url = get_url
    page = agent.get(url)
    html = Nokogiri::HTML(page.body)
    @title = html.css('h1').text;
    @replies = []
    html.css('dt').zip(html.css('dd')).each do |dt, dd|
      header = dt.text
      text = dd.to_html.sub(/(<br>){2}$/, '')
      reply = {header: header, text: text}
      @replies << reply
    end
  end

  private

  def get_url
    url = 'http://' + get_subback_server + '/test/read.cgi/' + get_subback_id + '/' + get_thread_id
  end

  def get_subback_server
    subback_server = params[:subback_server]
  end

  def get_subback_id
    subback_id = params[:subback_id]
  end

  def get_thread_id
    thread_id = params[:thread_id]
  end
end
