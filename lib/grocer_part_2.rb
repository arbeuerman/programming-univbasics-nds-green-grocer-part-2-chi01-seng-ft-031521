require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(consolidated_cart, coupons)
  #binding.pry 
  consolidated_cart.each do |consolidated_item|
    item_with_coupon = find_item_by_name_in_collection(consolidated_item[:item], coupons)
    if item_with_coupon != nil
      #create item with coupon applied
      item_coupon_applied = {}
      #update item name for coupon hash
      item_coupon_applied[:item] = item_with_coupon[:item] + " W/COUPON"
      #update count of original item and remove item if count is 0
      #do nothing if there are fewer items than coupon is applicable for
      #binding.pry
      if consolidated_item[:count] >= item_with_coupon[:num]
        consolidated_item[:count] -= item_with_coupon[:num]
        #update price per item from coupon 
        item_coupon_applied[:price] = item_with_coupon[:cost]/item_with_coupon[:num]
        #add rest of entries into hash 
        item_coupon_applied[:clearance] = true 
        item_coupon_applied[:count] = item_with_coupon[:num]
        consolidated_cart << item_coupon_applied
        #binding.pry
      end
    end 
  end 
#binding.pry
consolidated_cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
end

consolidated_cart = [
      {:item => "AVOCADO", :price => 3.00, :clearance => true},
      {:item => "KALE", :price => 3.00, :clearance => false},
      {:item => "BLACK_BEANS", :price => 2.50, :clearance => false},
      {:item => "ALMONDS", :price => 9.00, :clearance => false},
      {:item => "TEMPEH", :price => 3.00, :clearance => true},
      {:item => "CHEESE", :price => 6.50, :clearance => false},
      {:item => "BEER", :price => 13.00, :clearance => false},
      {:item => "PEANUTBUTTER", :price => 3.00, :clearance => true},
      {:item => "BEETS", :price => 2.50, :clearance => false},
      {:item => "SOY MILK", :price => 4.50, :clearance => true}
    ]

coupons = [
      {:item => "AVOCADO", :num => 2, :cost => 5.00},
      {:item => "BEER", :num => 2, :cost => 20.00},
      {:item => "CHEESE", :num => 3, :cost => 15.00}
    ]

puts apply_coupons(consolidated_cart, coupons)