class ConfirmsController < ApplicationController
 
  
  def create
    
    @confirm = Confirm.new(confirm_params)
    if @confirm.save
      
        Stripe.api_key = Rails.application.secrets.stripe_secret_key

        customer = Stripe::Customer.create(
          email: params[:stripeEmail],
          source: params[:stripeToken]
        )

        charge = Stripe::Charge.create(
          customer: customer.id,
          amount: @confirm.amount * 100,
          description: 'Iondesign customer',
          currency: 'usd'
        )

        redirect_to iondesign_path

    else
      puts "FAILED"
      puts @order.errors.full_messages
      render :json => { :error => @order.errors.full_messages }, :status => 422
    end
  end
  
  
  private
  
  def confirm_params
    params.require(:confirm).permit(:email, :address, :name, :order_id, :amount)
  end
  
end
