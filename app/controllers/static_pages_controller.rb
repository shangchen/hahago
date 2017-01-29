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
    if @@infoNews&&@@now_hour==Time.now.hour
    else
      @@infoNews = get_infoq().force_encoding("UTF-8")
      @@now_hour=Time.now.hour      
    end
    @infoNews=@@infoNews    
  end

  @@VR=nil
  @@hour_getVR=nil
  def vr_ar
    url = 'http://www.leiphone.com/category/arvr'
    re_first = '<div class="list">'
    re_second = '<div class="lph-page">'
    if @@VR&&@@hour_getVR==Time.now.hour
    else
      @@VR = get_sentence(url,re_first,re_second).force_encoding("UTF-8")
      @@VR.gsub!('<div class="img">','<div class="img" style="display:none">')  
      @@hour_getVR=Time.now.hour  
    end
      @VR=@@VR
  end

  @@AI=nil
  @@hour_getAI=nil
  def ai
    url = 'http://www.leiphone.com/category/ai'
    re_first = '<div class="list">'
    re_second = '<div class="lph-page">'
    if @@AI&&@@hour_getAI==Time.now.hour
    else
      @@AI = get_sentence(url,re_first,re_second).force_encoding("UTF-8")
      @@AI.gsub!('<div class="img">','<div class="img" style="display:none">')  
      @@hour_getAI=Time.now.hour 
    end
      @AI=@@AI
  end

  @@fun=nil
  @@day_getFun=nil
  def fun
    url = 'http://chuansong.me/account/lengtoo'
    re_first = '<div class="main_col col w4_5">'
    re_second = '<div id="li"'
    # if @@fun&&@@day_getFun==Time.now.day
    # else
      @@fun = get_sentence(url,re_first,re_second).force_encoding("UTF-8")
      @@fun.gsub!('<div class="img">','<div class="img" style="display:none">')  
      @@day_getFun=Time.now.day 
    # end
      @fun=@@fun
  end
end
