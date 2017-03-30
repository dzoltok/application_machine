class UserMailer < ApplicationMailer
  default from: 'david.zoltok@futureadvisor.com'

  def thanks_for_applying_email(user)
    @user = user
    mail(to: @user.email_address, subject: 'Thank you for applying!')
  end
end
