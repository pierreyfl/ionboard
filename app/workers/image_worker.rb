class ImageWorker
  include Sidekiq::Worker

  def perform(images, order_id)
    images.each do |k, v|
      if v["source"].include? "data:"
        image = Paperclip.io_adapters.for(v["source"])
        image.original_filename = v["title"]
        @picture = Picture.new
        @picture.image = image
        @picture.order_id = order_id
        @picture.save
      else
        host_url = "https://www.ionboardtech.com/"
        @picture = Picture.new
        @picture.image_remote_url = host_url + v["source"]
        @picture.order_id = order_id
        @picture.save
      end
    end
  end
  
  
end
