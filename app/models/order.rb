class Order < ActiveRecord::Base
  # 订单销毁，所有该订单的商品项目也要被销毁
  # 购物车里的line_item应该在产生订单时就清空了 
  has_many :line_items, dependent: :destroy 
  PAYMENT_TYPES = ["check", "Credit card", "Purchase order"]
  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: PAYMENT_TYPES 

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
end
