class Recipe
  attr_reader :name, :ingredients_required

  def initialize(name)
    @name = name
    @ingredients_required = {}
  end

  def add_ingredient(ingredient, amount)
    @ingredients_required[ingredient] = amount
  end

  def amount_required(ingredient)
    @ingredients_required[ingredient]
  end

  def ingredients
    @ingredients_required.keys
  end

  def ingredient_calories(ingredient)
    @ingredients_required[ingredient] * ingredient.calories
  end

  def total_calories
    @ingredients_required.sum { |key, value| key.calories * value }
  end

  def ingredients_in_units
    @ingredients_required.sort_by do |ingredient, amount|
      ingredient_calories(ingredient)
    end.reverse.map do |ingredient, amount|
      { ingredient: ingredient.name, amount: "#{amount} #{ingredient.unit}" }
    end
  end
end
