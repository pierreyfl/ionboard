class UsersController < ApplicationController
  before_filter :skip_first_page, only: :new
  before_filter :handle_ip, only: :create

  def new
    @bodyId = 'home'
    @is_mobile = mobile_device?

    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def create
    ref_code = cookies[:h_ref]
    email = params[:user][:email]
    address = request.env['HTTP_X_FORWARDED_FOR']
    current_ip = IpAddress.find_by_address(address)
    
    if current_ip.count > 1
      if User.find_by_email(email)
        cookies[:h_email] = { value: email }
        redirect_to '/refer-a-friend'
      else
        redirect_to root_path, alert: 'You have created too many accounts!'
      end
    else
      if User.find_by_email(email)
        cookies[:h_email] = { value: email }
        redirect_to '/refer-a-friend'
      else
        @user = User.new(email: email)
        @user.referrer = User.find_by_referral_code(ref_code) if ref_code
    
        if @user.save
          UserMailer.registration_confirmation(@user).deliver
          cookies[:h_email] = { value: @user.email }
          #UserMailer.signup_email(@user).deliver_now
          redirect_to '/refer-a-friend'
        else
          logger.info("Error saving user with email, #{email}")
          redirect_to root_path, alert: 'Something went wrong!'
        end
      end
    end
  end

  def refer
    @bodyId = 'refer'
    @is_mobile = mobile_device?

    @user = User.find_by_email(cookies[:h_email])

    respond_to do |format|
      if @user.nil?
        format.html { redirect_to root_path, alert: 'Something went wrong!' }
      else
        format.html # refer.html.erb
      end
    end
  end
  
  def confirm_email
      user = User.find_by_confirm_token(params[:id])
      if user
        user.email_activate
        flash[:success] = "Welcome to the Sample App! Your email has been confirmed.
        Please sign in to continue."
        redirect_to root_url
      else
        flash[:error] = "Sorry. User does not exist"
        redirect_to root_url
      end
  end

  def policy
  end

  def redirect
    redirect_to root_path, status: 404
  end

  private

  def skip_first_page
    return if Rails.application.config.ended

    email = cookies[:h_email]
    if email && User.find_by_email(email)
      redirect_to '/refer-a-friend'
    else
      cookies.delete :h_email
    end
  end

  def handle_ip
    # Prevent someone from gaming the site by referring themselves.
    # Presumably, users are doing this from the same device so block
    # their ip after their ip appears three times in the database.

    address = request.env['HTTP_X_FORWARDED_FOR']
    return if address.nil?

    current_ip = IpAddress.find_by_address(address)
    if current_ip.nil?
      current_ip = IpAddress.create(address: address, count: 1)
    else
      current_ip.count += 1
      current_ip.save
    end
  end
end
