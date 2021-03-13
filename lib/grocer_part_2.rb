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
        item_coupon_applied[:clearance] = consolidated_item[:clearance] 
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
  cart.each do |consolidated_item|
    if consolidated_item[:clearance]
      consolidated_item[:price] = (consolidated_item[:price] * 0.8).round(2)
    end 
  end 
  cart
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
  consolidated_cart = consolidate_cart(cart)
  consolidated_cart_w_coupons = apply_coupons(consolidated_cart, coupons)
  updated_prices_cart = apply_clearance(consolidated_cart_w_coupons)
  total_cost = 0
  updated_prices_cart.each do |item_with_updated_price|
    cost_of_item = item_with_updated_price[:count] * item_with_updated_price[:price]
    total_cost += cost_of_item  
  end 
  
  if total_cost > 100
    total_cost *= 0.90
  end   
  total_cost
end

consolidated_cart = [
  {:item => "AVOCADO", :price => 3.00, :clearance => true, :count => 1},
  {:item => "AVOCADO", :price => 3.00, :clearance => true, :count => 1},
  {:item => "AVOCADO", :price => 3.00, :clearance => true, :count => 1},
  {:item => "KALE",    :price => 3.00, :clearance => false, :count => 1}
]

coupons = [
      {:item => "AVOCADO", :num => 2, :cost => 5.00},
      {:item => "BEER", :num => 2, :cost => 20.00},
      {:item => "CHEESE", :num => 3, :cost => 15.00}
    ]

#puts apply_coupons(consolidated_cart, coupons)
puts apply_clearance(consolidated_cart)