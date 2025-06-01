class UserMailer < ApplicationMailer
   default from: ENV.fetch('MAIL_FROM', 'FamilyLoc <vhsoulas@gmail.com>')

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
