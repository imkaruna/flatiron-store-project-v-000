class LineItemsController < ApplicationController

  def index
    @line_items = LineItem.all
  end

  def create

    if current_user.current_cart.nil?
      current_user.current_cart = current_user.carts.create
      # alert[:notice] = 'Item successfully added'
      # session[:cart_id] = current_user.current_cart.id
      # redirect_to cart_path(current_cart.id)

    end
    current_user.current_cart.add_item(params[:item_id])
    current_user.save
      # alert[:notice] = 'Error adding the item'
      redirect_to cart_path(current_user.current_cart)
    
  end

  def create
      if current_user.current_cart.nil?
        current_user.current_cart = current_user.carts.create
      end
      current_user.current_cart.add_item(params[:item_id]).save
      current_user.save
      redirect_to cart_path(current_user.current_cart)
    end

end
