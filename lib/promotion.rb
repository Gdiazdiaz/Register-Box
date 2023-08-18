class Promotion
  attr_reader :name, :discount, :requirements

  def initialize(name, data)
    @name = name
    @discount = data['discount']
    @requirements = data['requirements']
  end

  def applies?(total_units, total_price)
    min_units_condition = @requirements['min_units'] ? total_units >= @requirements['min_units'] : true
    min_amount_condition = @requirements['min_amount'] ? total_price >= @requirements['min_amount'] : true

    min_units_condition && min_amount_condition
  end
end
