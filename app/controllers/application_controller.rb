class ApplicationController < ActionController::Base
  # määritellään, että metodi current_user tulee käyttöön myös näkymissä
  helper_method :current_user
  helper_method :delete_session
  helper_method :add_latest_search

  def add_latest_search(city)
    session[:latest_search] = city
  end

  def current_user
    return nil if session[:user_id].nil?

    User.find(session[:user_id])
  end

  def delete_session
    session[:user_id] = nil
  end

  def ensure_that_signed_in
    redirect_to signin_path, notice: 'you should be signed in' if current_user.nil?
  end

  def user_is_admin
    return if current_user.admin?

    flash[:alert] = "You must be an admin to perform this action."
    redirect_to breweries_path
  end
end
