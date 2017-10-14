class SubbacksController < ApplicationController
  def index
    agent = Mechanize.new
    url = get_url
    page = agent.get(url)
    html = Nokogiri::HTML(page.body)
    @subback_title = html.css('head title').text.sub('＠2ch掲示板＃スレッド一覧', '');
    @threads = []
    html.css('small#trad a').each do |thread_title|
      thread_title['href'] = thread_title['href'].sub(/l50/, '').insert(0, "/threads/#{get_subback_server}/#{get_subback_id}/#{get_thread_id}")
      title = thread_title.to_html.sub(/\d{1,3}: ?/, '')
      thread = {title: title}
      @threads << thread
    end
  end

  private

  def get_url
    url = 'http://' + get_subback_server + '/' + get_subback_id + '/subback.html'
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
