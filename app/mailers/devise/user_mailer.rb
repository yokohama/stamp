class Devise::UserMailer < Devise::Mailer   
  helper :application
  include Devise::Controllers::UrlHelpers

  def confirmation_instructions(record, token, opts={})
    opts[:from] = "info@#{ENV['DOMAIN']}"
    opts[:reply_to] = "info@#{ENV['DOMAIN']}"
    opts[:subject] = t('.subject')

    @name = record.name
    @email = record.email
    @temp_password = record.temp_password

    super
  end

  def reset_password_instructions(record, token, opts={})
    opts[:from] = "info@#{ENV['DOMAIN']}"
    opts[:reply_to] = "info@#{ENV['DOMAIN']}"
    opts[:subject] = t('.subject')

    @email = record.email

    super
  end
end
