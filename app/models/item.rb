class Item < ActiveRecord::Base
  belongs_to :category
  has_many :line_items, -> { where "quantity > 0" },
    class_name: "LineItem"

  def self.available_items
    Item.where("inventory > 0")
  end
end
