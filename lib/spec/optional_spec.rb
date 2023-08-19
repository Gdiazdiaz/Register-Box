require_relative '../optional'

describe Optional do
  before(:each) do
    @optional = Optional.new('bag', {
      'price_model' => 'fixed',
      'price' => 5
    })
    @optional_b = Optional.new('tip', {
      'price_model' => 'user_defined',
      'min' => 0.2
    })
  end

  it 'it is an instance of Optional class' do
    expect(@optional).to be_instance_of(Optional)
  end

  it 'calcula el valor segun la cantidad' do
    expect(@optional.calculate_price(1, 300)).to eq(5)
  end

  it 'valida la propina como correcta' do
    expect(@optional_b.calculate_price(150, 300)).to eq(150)
  end

  it 'tira error por propina no valida' do
    expect { @optional_b.calculate_price(15, 300) }.to raise_error(StandardError, 'La propina debe ser mayor al 10% del valor de los productos')
  end
end