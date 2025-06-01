class UserMailer < ApplicationMailer
   default from: '8e5a83001@smtp-brevo.com'


  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome
   @user = params[:user]

    mail to: "#{@user.email}", subject: "Bienvenue sur Family Loc !"
  end
end
