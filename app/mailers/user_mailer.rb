class UserMailer < ApplicationMailer
  default from: "info@#{ENV['DOMAIN']}"
  default reply_to: "info@#{ENV['DOMAIN']}"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.invite_submittion.subject
  #
  def invite_submittion(submit)
    @greeting = submit.user.name
    @url = edit_users_submit_url(submit.id)

    mail(
      to: submit.user.email, 
      subject: t('.subject', company_name: Settings.company_name, service_name: Settings.service_name)
    )
  end
end
