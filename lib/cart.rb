class Cart
  def initialize(products_data, promotions_data, optionals_data)
    @products = load_products(products_data)
    @promotions = load_promotions(promotions_data)
    @optionals = load_optionals(optionals_data)
    @selected_products = {}
    @selected_optionals = {}
  end

  def add_product(product_name, quantity)
    @selected_products[product_name] = quantity
  end

  def add_optional(optional_name, quantity)
    @selected_optionals[optional_name] = quantity
  end

  def calculate_total
    total_units = @selected_products.values.sum
    total_value = calculate_products_total
    total_price = calculate_optionals_total(total_value)
    applicable_promotions = @promotions.select { |_, promotion| promotion.applies?(total_units, total_value) }
    discount = applicable_promotions.values.map(&:discount).max || 0
    total_value = apply_promotion_discount(total_value, discount)
    total_value + total_price
  end

  def calculate_products_total
    @selected_products.sum { |product_name, quantity| @products[product_name].calculate_price(quantity) }
  end

  private

  def load_products(products_data)
    products_data.to_h { |name, data| [name, Product.new(name, data)] }
  end

  def load_optionals(optionals_data)
    optionals_data.to_h { |name, data| [name, Optional.new(name, data)] }
  end

  def load_promotions(promotions_data)
    promotions_data.to_h { |name, data| [name, Promotion.new(name, data)] }
  end

  def calculate_optionals_total(products_total)
    @selected_optionals.sum do |optional_name, quantity|
      @optionals[optional_name].calculate_price(quantity, products_total)
    end
  end

  def apply_promotion_discount(total_price, discount)
    total_price * (1 - discount)
  end
end
