class Confirmation < ApplicationMailer
  default from: 'admin@music_app.com'

  def confirm_email(user)
    @user = user
    @url = "http://localhost:3000/users/activate?activation_token=#{@user.activation_token}"

    mail(to: @user.email, subject: 'Please confirm your email address')
  end
end
