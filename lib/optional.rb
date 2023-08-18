class Optional
  attr_reader :name, :price_model, :min_porcentage, :price

  def initialize(name, data)
    @name = name
    @price_model = data['price_model']
    @min_porcentage = data['min']
    @price = data['price']
  end

  def calculate_price(quantity, total_value)
    case @price_model
    when 'fixed'
      quantity * @price
    when 'user_defined'
      validate_and_calculate_tip(quantity, total_value)
    end
  end

  def validate_and_calculate_tip(amount, total_value)
    raise 'La propina debe ser mayor al 10% del valor de los productos' unless amount >= @min_porcentage * total_value

    amount
  end
end
