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
  after_create :send_welcome_email

  REFERRAL_STEPS = [
    {
      'count' => 1,
      'html' => '$5 Discount',
      'class' => '1',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 2,
      'html' => '$5 Discount',
      'class' => '2',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 3,
      'html' => '$5 Discount',
      'class' => '3',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 4,
      'html' => '$5 Discount',
      'class' => '4',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 5,
      'html' => '$5 Discount',
      'class' => '5',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 6,
      'html' => '$5 Discount',
      'class' => '6',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 7,
      'html' => '$5 Discount',
      'class' => '7',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 8,
      'html' => '$5 Discount',
      'class' => '8',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 9,
      'html' => '$5 Discount',
      'class' => '9',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 10,
      'html' => '$5 Discount',
      'class' => '10',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 11,
      'html' => '$5 Discount',
      'class' => '11',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },    {
      'count' => 12,
      'html' => '$5 Discount',
      'class' => '12',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 13,
      'html' => '$5 Discount',
      'class' => '13',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 14,
      'html' => '$5 Discount',
      'class' => '14',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 15,
      'html' => '$5 Discount',
      'class' => '15',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 16,
      'html' => '$5 Discount',
      'class' => '16',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 17,
      'html' => '$5 Discount',
      'class' => '17',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 18,
      'html' => '$5 Discount',
      'class' => '18',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 19,
      'html' => '$5 Discount',
      'class' => '19',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 20,
      'html' => '$5 Discount',
      'class' => '20',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 21,
      'html' => '$5 Discount',
      'class' => '21',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 22,
      'html' => '$5 Discount',
      'class' => '22',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },    {
      'count' => 23,
      'html' => '$5 Discount',
      'class' => '23',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 24,
      'html' => '$5 Discount',
      'class' => '24',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 25,
      'html' => '$5 Discount',
      'class' => '25',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 26,
      'html' => '$5 Discount',
      'class' => '26',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 27,
      'html' => '$5 Discount',
      'class' => '27',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 28,
      'html' => '$5 Discount',
      'class' => '28',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 29,
      'html' => '$5 Discount',
      'class' => '29',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 30,
      'html' => '$5 Discount',
      'class' => '30',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 31,
      'html' => '$5 Discount',
      'class' => '31',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 32,
      'html' => '$5 Discount',
      'class' => '32',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 33,
      'html' => '$5 Discount',
      'class' => '33',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },    {
      'count' => 34,
      'html' => '$5 Discount',
      'class' => '34',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 35,
      'html' => '$5 Discount',
      'class' => '35',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 36,
      'html' => '$5 Discount',
      'class' => '36',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 37,
      'html' => '$5 Discount',
      'class' => '37',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 38,
      'html' => '$5 Discount',
      'class' => '38',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 39,
      'html' => '$5 Discount',
      'class' => '39',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 40,
      'html' => '$5 Discount',
      'class' => '40',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 41,
      'html' => '$5 Discount',
      'class' => '41',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 42,
      'html' => '$5 Discount',
      'class' => '42',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 43,
      'html' => '$5 Discount',
      'class' => '43',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 44,
      'html' => '$5 Discount',
      'class' => '44',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },    {
      'count' => 45,
      'html' => '$5 Discount',
      'class' => '45',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 46,
      'html' => '$5 Discount',
      'class' => '46',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 47,
      'html' => '$5 Discount',
      'class' => '47',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 48,
      'html' => '$5 Discount',
      'class' => '48',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 49,
      'html' => '$5 Discount',
      'class' => '49',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 50,
      'html' => '$5 Discount',
      'class' => '50',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 51,
      'html' => '$5 Discount',
      'class' => '51',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 52,
      'html' => '$5 Discount',
      'class' => '52',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 53,
      'html' => '$5 Discount',
      'class' => '53',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 54,
      'html' => '$5 Discount',
      'class' => '54',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 55,
      'html' => '$5 Discount',
      'class' => '56',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },    {
      'count' => 57,
      'html' => '$5 Discount',
      'class' => '57',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 58,
      'html' => '$5 Discount',
      'class' => '58',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 59,
      'html' => '$5 Discount',
      'class' => '59',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 60,
      'html' => '$5 Discount',
      'class' => '60',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 61,
      'html' => '$5 Discount',
      'class' => '61',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 62,
      'html' => '$5 Discount',
      'class' => '62',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 63,
      'html' => '$5 Discount',
      'class' => '63',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 64,
      'html' => '$5 Discount',
      'class' => '64',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 65,
      'html' => '$5 Discount',
      'class' => '65',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 66,
      'html' => '$5 Discount',
      'class' => '66',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 67,
      'html' => '$5 Discount',
      'class' => '67',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },    {
      'count' => 68,
      'html' => '$5 Discount',
      'class' => '68',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 69,
      'html' => '$5 Discount',
      'class' => '69',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 70,
      'html' => '$5 Discount',
      'class' => '70',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 71,
      'html' => '$5 Discount',
      'class' => '71',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 72,
      'html' => '$5 Discount',
      'class' => '72',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 73,
      'html' => '$5 Discount',
      'class' => '73',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 74,
      'html' => '$5 Discount',
      'class' => '74',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 75,
      'html' => '$5 Discount',
      'class' => '75',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 76,
      'html' => '$5 Discount',
      'class' => '76',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 77,
      'html' => '$5 Discount',
      'class' => '77',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 78,
      'html' => '$5 Discount',
      'class' => '78',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/cream-tooltip@2x.png')
    },
    {
      'count' => 79,
      'html' => '$10 Discount',
      'class' => '79',
      'image' => ActionController::Base.helpers.asset_path(
        'refer/truman@2x.png')
    },
    {
      'count' => 80,
      'html' => '$25 Discount',
      'class' => '80',
      'image' => ActionController::Base.helpers.asset_path(
        'refer/winston@2x.png')
    }
  ]

  private

  def create_referral_code
    self.referral_code = UsersHelper.unused_referral_code
  end

  def send_welcome_email
    UserMailer.delay.signup_email(self)
  end
end
