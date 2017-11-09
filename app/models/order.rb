class Order < ActiveRecord::Base
  attr_accessor :image_json
  #before_validation :set_image
  
  validates_presence_of :email
  validates_presence_of :order_number
  has_attached_file :design, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :design, content_type: /\Aimage\/.*\z/
  has_one :confirm
  has_many :pictures
  
  def set_image(image_json)
      StringIO.open(Base64.decode64(image_json)) do |data|
        data.class.class_eval { attr_accessor :original_filename, :content_type }
        data.original_filename = "file.jpg"
        data.content_type = "image/jpeg"
        self.design = data
      end
    end
end
