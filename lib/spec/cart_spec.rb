require 'yaml'
require_relative '../cart'
require_relative '../product'
require_relative '../optional'
require_relative '../promotion'

test_yml_path = File.join(__dir__, 'test.yml')

data = YAML.load(File.read(test_yml_path))

describe Cart do
  before(:each) do
    @cart = Cart.new(data['products'], data['promotions'], data['optionals'])
  end

  it 'is an instance of Cart class' do
    expect(@cart).to be_instance_of(Cart)
  end

  it 'calcula el valor de la orden' do
    @cart.add_product('apple', 3)
    expect(@cart.calculate_total).to eq(30)
  end

  it 'calcula el valor de la orden' do
    @cart.add_optional('bag', 2)
    expect(@cart.calculate_total).to eq(2)
  end

  it 'calcula el valor de la orden con propina y promociones' do
    @cart.add_product('orange', 10)
    @cart.add_product('apple', 15)
    expect(@cart.calculate_total).to eq(168)
  end

  it 'calcula el valor de la orden con propina y promociones' do
    @cart.add_product('apple', 5)
    @cart.add_optional('bag', 2)
    expect(@cart.calculate_total).to eq(52)
  end
end