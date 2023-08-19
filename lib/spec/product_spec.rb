require_relative '../product'

describe Product do
  before(:each) do
    @product = Product.new('apple', {
      'price_model' => 'fixed',
      'price' => 10
    })
    @product_b = Product.new('apple', {
      'price_model' => 'tiered',
      'tiers' => [
        { 'from' => 1, 'to' => 10, 'price' => 5 },
        { 'from' => 11, 'to' => 20, 'price' => 1 },
        { 'from' => 21, 'to' => 30, 'price' => 2 }
      ]
    })
  end

  it 'it is an instance of Product class' do
    expect(@product).to be_instance_of(Product)
  end

  it 'calcula el valor segun la cantidad' do
    expect(@product.calculate_price(5)).to eq(50)
  end

  it 'calcula el valor segun la cantidad' do
    expect(@product_b.calculate_price(30)).to eq(80)
  end
end