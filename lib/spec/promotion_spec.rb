require_relative '../promotion'

describe Promotion do
  before(:each) do
    @promotion = Promotion.new('one', {
      'discount' => 0.5,
      'requirements' => { 'min_units' => 5 }
    })
    @promotion_b = Promotion.new('two', {
      'discount' => 0.6,
      'requirements' => { 'min_amount' => 50 }
    })
  end

  it 'it is an instance of promotion class' do
    expect(@promotion).to be_instance_of(Promotion)
  end

  it 'return true ya que el requerimiento para el descuento se cumple' do
    expect(@promotion.applies?(15, 5)).to eq(true)
    expect(@promotion_b.applies?(10, 1000)).to eq(true)
  end

  it 'returns false ya que el requerimiento para el descuento no se cumple' do
    expect(@promotion.applies?(1, 10)).to eq(false)
    expect(@promotion_b.applies?(30, 5)).to eq(false)
  end
end