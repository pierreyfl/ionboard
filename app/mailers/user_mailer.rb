class UserMailer < ActionMailer::Base
  default from: "ionboard <welcome@ionboardtech.com>"

  def signup_email(user)
    @user = user
    @twitter_message = "IONBoard"

    mail(:to => user.email, :subject => "Thank you for signing up!")
  end
  
  def registration_confirmation(user)
      @user = user
      mail(:to => user.email, :subject => "Registration Confirmation")
   end
end
