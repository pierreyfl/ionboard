class OrdersController < ApplicationController
  
  def create
    @order = Order.new(order_params)
    data_url = params[:order][:base64_image]
    Base64.decode64(data_url['data:image/png;base64,'.length..-1])
    png = Base64.decode64(data_url['data:image/png;base64,'.length..-1])
    File.open('text.png','wb') {|f| f.write(png)}
    puts params[:order]
    @order.save
    redirect_to root_path  
  end
  
  
  private
  
  def order_params
    params.require(:order).permit(:name)
  end
  
end
