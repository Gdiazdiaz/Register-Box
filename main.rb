require 'yaml'
require_relative 'lib/product'
require_relative 'lib/promotion'
require_relative 'lib/optional'
require_relative 'lib/cart'

data = YAML.load_file('prices-exercise.yml')

cart = Cart.new(data['products'], data['promotions'], data['optionals'])

puts '============================================================='
puts 'Bienvenidos al MiniMarket'
puts '============================================================='

loop do
  puts '1. Agregar productos a la cesta'
  puts '2. Agregar bolsa'
  puts '3. Calcular total'
  puts '4. Salir'
  print 'Ingrese su eleccion: '
  choice = gets.chomp.to_i

  case choice
  when 1
    puts 'Productos disponibles:'
    data['products'].keys.each_with_index { |product, index| puts "#{index + 1}. #{product}" }
    print 'Ingrese el numero que corresponde a su eleccion: '
    product_number = gets.chomp.to_i - 1
    print 'Cuantas unidades desea?: '
    quantity = gets.chomp.to_i
    selected_product = data['products'].keys[product_number]
    cart.add_product(selected_product, quantity)
  when 2
    puts 'Cuantas bolsas desea agregar?'
    quantity = gets.chomp.to_i
    cart.add_optional('bag', quantity)
  when 3
    print 'Cuanto desea agregar de propina?: '
    tip_amount = gets.chomp.to_f
    cart.add_optional('tip', tip_amount)
    total_price = cart.calculate_total
    puts "Total a pagar: #{total_price.round(2)}"
    puts '======================================================'
  when 4
    break
  else
    puts 'Eleccion invalida'
  end
end
