class UserMailer < ApplicationMailer
  default from: 'david.zoltok@futureadvisor.com'

  def thanks_for_applying_email(user)
    @user = user
    mail(to: @user.email_address, subject: 'Thank you for applying!')
  end

  def docusign_sent_email(user)
    @user = user
    @link = 'http://www.docusign.com'
    mail(to: @user.email_address, subject: 'Your DocuSign is on it\'s way!')
  end
end
