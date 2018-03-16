require_relative 'coin_convert'

# Description: Create a program where it shows the user a list of items to buy and their price. 
# Then ask the user to pick an item and enter in the amount of money they would have inserted into the “vending 
# machine”. Have the program calculate the change and return it to the user in the form of quarters, dimes, nickels 
# and pennies. For example, if the user chooses an item that costs $1.25 and they say they give it $2.07 the program 
# would print out 3 quarters, 1 nickel and 2 pennies as change for the user. 

items = {sandwich: "3.36", soda: "0.75", lollipop: "1.25"}

puts items
puts "What item?"
food = gets.chomp

puts "How much?"
price = gets.chomp

amount  = CoinConvert.make_money(price) - CoinConvert.make_money(items[food.to_sym])

coins = CoinConvert.change_returned(amount)

puts "Here's your change:"
coins.reject {|x| x.split.first.to_i == 0 }.each do |coin|
    puts coin
end
