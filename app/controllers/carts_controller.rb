class CartsController < ApplicationController

  def index
    @carts = current_user.carts
  end

  def show
    @cart = Cart.find(params[:id])
  end

  def checkout
   @cart = Cart.find(params[:id])
   @cart.update(status: 'submitted')

   @cart.line_items.each do |line_item|
     line_item.item.update(inventory: line_item.item.inventory - line_item.quantity)
   end

   current_user.current_cart = nil
   redirect_to cart_path(@cart)
  end
end
