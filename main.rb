require 'yaml'
require_relative 'lib/product'
require_relative 'lib/promotion'
require_relative 'lib/optional'
require_relative 'lib/cart'

data = YAML.load_file('prices-exercise.yml')

cart = Cart.new(data['products'], data['promotions'], data['optionals'])

cart.add_product('orange', 5)
cart.add_product('apple', 15)
cart.add_optional('bag', 1)

print 'Ingrese cuanto el monto de propina: '
tip_amount = gets.chomp.to_i

cart.add_optional('tip', tip_amount)

total_price = cart.calculate_total

puts "Total to pay: #{total_price.round(2)}"
