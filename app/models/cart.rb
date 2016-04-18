class Cart < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy
  has_many :items, through: :line_items
  belongs_to :user, inverse_of: :carts

  def total
    self.line_items.collect{ |li| li.item.price*li.quantity}.sum
  end

  def add_item(item_id)
    this_line_item = self.line_items.find_by(item_id: item_id)
    if this_line_item
      updated_quantity = this_line_item.quantity+1
      this_line_item.update(:quantity => updated_quantity)
      this_line_item
    else
      self.line_items.build(item_id: item_id, quantity: 1)

    end
  end

  def checkout
    self.status = "submitted"
    self.line_items.each do |line_item|
      line_item.item.update(inventory: line_item.item.inventory - line_item.quantity)
    end
  end

end
