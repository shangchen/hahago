class StaticPagesController < ApplicationController
  @@dailySentence=nil
  @@now_day=nil
  def home
    url = 'http://www.dailyenglishquote.com/?variant=zh-hans'
    re_first = '<div class="separator" .*'
    re_second = '<!-- AddThis Sharing Buttons below -->'

    if @@dailySentence&&@@now_day==Time.now.day
    else
      @@dailySentence = get_sentence(url,re_first,re_second).force_encoding("UTF-8")
      @@now_day=Time.now.day      
    end
    @dailySentence=@@dailySentence
    
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def about
  end

  @@infoNews=nil
  @@now_hour=nil
  def info
    # if @@infoNews&&@@now_hour==Time.now.hour
    # else
      @@infoNews = get_infoq().force_encoding("UTF-8")
      @@now_hour=Time.now.hour      
    # end
    @infoNews=@@infoNews    
  end

  def contact
  end

end
