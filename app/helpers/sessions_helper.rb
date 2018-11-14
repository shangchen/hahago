module SessionsHelper
	  # 登入指定的用户
  def log_in(user)
    session[:user_id] = user.id
  end

	def current_user
	    if (user_id = session[:user_id])
	      @current_user ||= User.find_by(id: user_id)
	    elsif (user_id = cookies.signed[:user_id])
	      user = User.find_by(id: user_id)
	      if user && user.authenticated?(:remember, cookies[:remember_token])
	        log_in user
	        @current_user = user
	      end
	    end
	end

	  # 如果用户已登录，返回 true，否则返回 false
	def logged_in?
		!current_user.nil?
	end

	  # 退出当前用户
	def log_out
		forget(current_user)
		session.delete(:user_id)
		@current_user = nil
	end

	# 在持久会话中记住用户
	def remember(user)
		user.remember
		cookies.permanent.signed[:user_id] = user.id
		cookies.permanent[:remember_token] = user.remember_token
	end

	def forget(user)
		user.forget
		cookies[:user_id]=nil
		cookies[:remember_token]=nil
	end

	# 重定向到存储的地址或者默认地址
	def redirect_back_or(default)
		redirect_to(session[:forwarding_url] || default)
		session.delete(:forwarding_url)
	end

	# 存储后面需要使用的地址
	def store_location
		session[:forwarding_url] = request.original_url if request.get?
	end

	# 如果指定用户是当前用户，返回 true
	def current_user?(user)
		user == current_user
	end

	def get_sentence(url,re_first,re_second,re_third=nil)
	    begin
			re1=Net::HTTP.get_response(URI(url))
			re=re1.read_body
	    rescue
	      error_info='sorry,server not response'
	      return error_info
	    end
			re=~/#{re_first}/
			re1= $'.to_s 
			re1=~ /#{re_second}/
			re2 = '<div>'+$`.to_s	
		end

	def get_infoq()
		url='https://www.infoq.com/news/'
	    begin
			re1=Net::HTTP.get_response(URI(url))
			re=re1.read_body
	    rescue
	      error_info='Sorry, no response from server'
	      return error_info
	    end
	    re=~/<!--	#######		HEADER END	#########	 -->/
	    re1= $'.to_s 
	    re1=~/<div class="clear"><\/div>/
	    re2= $'.to_s
	    re2=~ /<!--	#######		load more news	#########	 -->/
	    re3 =  $`.to_s.gsub!(/<div class="news_type_block/,'<hr><div class="news_type_block')
	    re4=re3.gsub!(/href="\/news/,'target="_blank" href="https://www.infoq.com/news')	    
	    #re5=re4.gsub!(/class="followers" style="display: inline;"/,'class="followers" style="display: none;"')  
		re5=re4.gsub!(/<span>/,'<span style="display: none;">')  
	end

end
