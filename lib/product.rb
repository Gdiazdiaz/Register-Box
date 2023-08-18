class Product
  attr_reader :name, :price_model, :tiers, :price

  def initialize(name, data)
    @name = name
    @price_model = data['price_model']
    @price = data['price']
    @tiers = data['tiers']
  end

  def calculate_price(quantity)
    case @price_model
    when 'fixed'
      @price * quantity
    when 'tiered'
      tiered_price(quantity)
    end
  end

  private

  def tiered_price(quantity)
    total_price = 0
    remaining = quantity

    @tiers.each do |tier|
      range = (tier['from']..tier['to'])
      units = [remaining, range.size].min

      total_price += units * tier['price']
      remaining -= units

      break if remaining <= 0
    end

    total_price
  end
end
