require 'users_helper'

class User < ActiveRecord::Base
  belongs_to :referrer, class_name: 'User', foreign_key: 'referrer_id'
  has_many :referrals, class_name: 'User', foreign_key: 'referrer_id'

  validates :email, presence: true, uniqueness: true, format: {
    with: /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/i,
    message: 'Invalid email format.'
  }
  validates :referral_code, uniqueness: true

  before_create :create_referral_code
  before_create :confirmation_token
  after_create :send_welcome_email

  REFERRAL_STEPS = [
    {
      'count' => 10,
      'html' => 'Discount<br>$50',
      'class' => 'two'
    },
    {
      'count' => 50,
      'html' => 'Discount<br>$100',
      'class' => 'three'
    },
    {
      'count' => 100,
      'html' => 'Free',
      'class' => 'four'
    }
  ]
  
  
  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end
  
  def display_name
    self.email
  end
    

  private

  def create_referral_code
    self.referral_code = UsersHelper.unused_referral_code
  end

  def send_welcome_email
    UserMailer.delay.signup_email(self)
  end
  
  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end
  
end
