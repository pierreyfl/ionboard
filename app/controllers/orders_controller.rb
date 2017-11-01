class OrdersController < ApplicationController
 
  
  def create
    @order = Order.new(order_params)
    data_url = params[:order][:image_json]
    #@order.set_image(data_url)
    image = Paperclip.io_adapters.for(params[:order][:image_json])
    image.original_filename = "something.png"
    @order.design = image
    #params[:order][:image_json] = params[:order][:image_json]['data:image/png;base64,'.length..-1]
    #Base64.decode64(data_url['data:image/png;base64,'.length..-1])
    #png = Base64.decode64(data_url['data:image/png;base64,'.length..-1])
    #File.open('text.png','wb') {|f| f.write(png)}
    if @order.save
      render :json => { :success => true }
    else
      puts "FAILED"
      puts @order.errors.full_messages
      render :json => { :error => @order.errors.full_messages }, :status => 422
    end
  end
  
  
  private
  
  def order_params
    params.require(:order).permit(:name, :email, :order_number, :design, :amount)
  end
  
end
