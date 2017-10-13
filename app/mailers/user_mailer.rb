class UserMailer < ActionMailer::Base
  default from: "ionboard <welcome@ionboardtech.com>"

  def signup_email(user)
    @user = user
    @twitter_message = "IONBoard"

    mail(:to => user.email, :subject => "Thank you for signing up!")
  end
  
  def registration_confirmation(user)
      @user = user
      headers "X-SMTPAPI" => {
        sub: {
          "%sender_name%" => [@user.email],
          "%sender_id%" = [@user.confirm_token]
          
        },
        filters: {
          templates: {
            settings: {
              enable: 1,
              template_id: 'eba4703c-27f6-4272-bfcf-19b3e4c90e0e' 
            }
          }  
        }  
      }.to_json
      mail(:to => user.email, :subject => "Thank you for signing up for ionboard!")
   end
end
