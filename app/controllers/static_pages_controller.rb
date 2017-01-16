class StaticPagesController < ApplicationController
  @@dailySentence=nil
  @@now_day=nil
  def home
    if !@@dailySentence||@@now_day!=Time.now.day
      @@dailySentence = get_sentence.force_encoding("UTF-8")
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

  def help
  end

  def contact
  end

end
