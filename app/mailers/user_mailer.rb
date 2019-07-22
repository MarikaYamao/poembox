class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    @url = edit_password_reset_url(id: @user.reset_token,email: @user.email)
    mail to: @user.email, subject: "Password reset"
  end
end
