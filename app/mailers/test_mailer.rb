class TestMailer < ApplicationMailer
  default from: '8e5a83001@smtp-brevo.com'

  def sample_email
    mail(to: 'vhsoulas@gmail.com', subject: 'Test SMTP Brevo', body: 'Test d’envoi d’email via Brevo SMTP')
  end
end
