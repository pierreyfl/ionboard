class OrdersController < ApplicationController
 
  
  def create
    @order = Order.new(order_params)
    data_url = params[:order][:image_json]
    #@order.set_image(data_url)
    image = Paperclip.io_adapters.for(params[:order][:image_json])
    image.original_filename = "base.png"
    @order.design = image
    #images = params[:order][:images_json]
    #images = images.first['source']
    #puts images
    #images.each do |k, v|
      #image = Paperclip.io_adapters.for(v["source"])
      #image.original_filename = v["title"] + ".png"
      #@picture = Picture.new
      #@picture.image = image
      #@picture.order_id = @order.id
      #@picture.save
      #end
    #puts "HAHAHAHAHA"
    #params[:order][:image_json] = params[:order][:image_json]['data:image/png;base64,'.length..-1]
    #Base64.decode64(data_url['data:image/png;base64,'.length..-1])
    #png = Base64.decode64(data_url['data:image/png;base64,'.length..-1])
    #File.open('text.png','wb') {|f| f.write(png)}
    if @order.save
      images = params[:order][:images_json]
      images.each do |k, v|
        if v["source"].include? "data:"
          image = Paperclip.io_adapters.for(v["source"])
          image.original_filename = v["title"]
          @picture = Picture.new
          @picture.image = image
          @picture.order_id = @order.id
          @picture.save
        else
          host_url = "https://www.ionboardtech.com/"
          @picture = Picture.new
          @picture.image_remote_url = host_url + v["source"]
          @picture.order_id = @order.id
          @picture.save
        end
      end
      @confirm = Confirm.new
      render :partial => 'checkout'
    else
      puts "FAILED"
      puts @order.errors.full_messages
      render :json => { :error => @order.errors.full_messages }, :status => 422
    end
  end
  
  def show
    @order = Order.find(params[:order_id])
  end
  
  
  private
  
  def order_params
    params.require(:order).permit(:name, :email, :order_number, :design, :amount)
  end
  
end
