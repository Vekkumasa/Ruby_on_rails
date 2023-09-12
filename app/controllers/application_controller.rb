class ApplicationController < ActionController::Base
  # määritellään, että metodi current_user tulee käyttöön myös näkymissä
  helper_method :current_user
  helper_method :delete_session

  def current_user
    return nil if session[:user_id].nil?

    User.find(session[:user_id])
  end

  def delete_session
    session[:user_id] = nil
  end
end
