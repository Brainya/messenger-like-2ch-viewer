class SubbacksController < ApplicationController
  def index
    agent = Mechanize.new
    url = get_url
    agent.get(url) do |page|
      html = Nokogiri::HTML(page.body)
      @subback_title = html.css('head title').text.sub('＠2ch掲示板＃スレッド一覧', '');
      @threads = []
      is_removed_guide = false
      html.css('small#trad a').each do |thread_title|
        if thread_title.attribute('class').try(:value) == 'sc' && !is_removed_guide
          is_removed_guide = true
          next
        end
        thread_title['href'] = thread_title.attribute('href').try(:value).sub(/l50/, '').insert(0, '/threads/anime2/')
        title = thread_title.to_html.sub(/\d{1,3}: ?/, '')
        thread = {title: title}
        @threads << thread
      end
    end
  end

  def get_url
    url = 'http://ikura.2ch.sc/' + params[:subback_id] + '/subback.html'
  end
end
