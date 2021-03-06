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
      id = header.match(/\d+/)
      text = dd.to_html.sub(/(<br>){2}$/, '')
      text = text.gsub(/<a href(\w|\d|=|>|<|"|\.|\/|_|\\|\s|-)+&gt;&gt;(\d+|\d+-\d+)<\/a>/) {
        link_id = $2
        link = (link_id.match(/-/) == nil ? link_id : link_id.gsub(/-\d+/, ''))
        "<a href=##{link}>&gt;&gt;#{link_id}</a>"
      }
      reply = {id: id, header: header, text: text}
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
