class TestMailer < ApplicationMailer
  default from: 'soulas@family-loc.store'

  def test_email(to_email)
    mail(to: to_email, subject: 'Test Action Mailer') do |format|
      format.text { render plain: "Ceci est un email de test." }
    end
  end
end
