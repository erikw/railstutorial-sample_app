module SessionsHelper
  def login(user)
    session[:user_id] = user.id
    # Session replay attack guard using a volatile value in the session cookie
    # https://binarysolo.chapter24.blog/avoiding-session-replay-attacks-in-rails/
    session[:session_token] = user.session_token
  end

  def remember(user)
    user.remember
    cookies.permanent.encrypted[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def current_user
    if (user_id = session[:user_id])
      user = User.find_by(id: user_id)
      if user && session[:session_token] == user.session_token
        @current_user = user
      end
    elsif (user_id = cookies.encrypted[:user_id])
      user = User.find_by(id: user_id)
      if user&.authenticated?(:remember, cookies[:remember_token])
        login user
        @current_user = user
      end
    end
  end

  def current_user?(user)
    #user && user == current_user
    user&. == current_user
  end

  def logged_in?
    !current_user.nil?
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_user)
    reset_session
    @current_user = nil
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end