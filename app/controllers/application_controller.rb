class ApplicationController < ActionController::Base
  protect_from_forgery

  # määritellään, että metodi current_user tulee käyttöön myös näkymissä
  helper_method :current_user, :currently_signed_in?, :is_not_admin, :printRedColor, :printGreenColor

  def current_user
    return nil if session[:user_id].nil?
    User.find(session[:user_id])
  end

  def currently_signed_in?(user)
    current_user == user
  end

  def ensure_that_signed_in
    redirect_to signin_path, :notice => 'you should be signed in' if current_user.nil?
  end

  def is_not_admin
     if current_user.admin.nil? || current_user.admin == false
       return true
     end
    return false
  end

  def printRedColor(code)
    return '<font color="#FF0000">' + code + '</font>'
  end

  def printGreenColor(code)
    return '<font color="#00FF00">' + code + '</font>'
  end

end
