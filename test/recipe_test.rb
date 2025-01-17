require 'minitest/autorun'
require 'minitest/pride'
require './lib/ingredient'
require './lib/recipe'

class RecipeTest < Minitest::Test
  def setup
    @cheese = Ingredient.new("Cheese", "C", 100)
    @mac = Ingredient.new("Macaroni", "oz", 30)
    @mac_and_cheese = Recipe.new("Mac and Cheese")
  end

  def test_it_exists
    assert_instance_of Recipe, @mac_and_cheese
  end

  def test_it_initializes_with_readable_attributes
    assert_equal "Mac and Cheese", @mac_and_cheese.name
    expected = {}
    assert_equal expected, @mac_and_cheese.ingredients_required
  end

  def test_it_can_add_ingredient_to_required_ingredients
    @mac_and_cheese.add_ingredient(@cheese, 2)
    @mac_and_cheese.add_ingredient(@mac, 8)
    expected = { @cheese => 2, @mac => 8}
    assert_equal expected, @mac_and_cheese.ingredients_required
  end

  def test_it_can_return_amount_required_of_given_ingredient
    @mac_and_cheese.add_ingredient(@cheese, 2)
    @mac_and_cheese.add_ingredient(@mac, 8)
    assert_equal 2, @mac_and_cheese.amount_required(@cheese)
    assert_equal 8, @mac_and_cheese.amount_required(@mac)
  end

  def test_it_can_return_array_of_alL_ingredients
    @mac_and_cheese.add_ingredient(@cheese, 2)
    @mac_and_cheese.add_ingredient(@mac, 8)
    expected = [@cheese, @mac]
    assert_equal expected, @mac_and_cheese.ingredients
  end

  def test_it_can_calculate_total_calories_of_all_ingredients
    @mac_and_cheese.add_ingredient(@cheese, 2)
    @mac_and_cheese.add_ingredient(@mac, 8)
    assert_equal 440, @mac_and_cheese.total_calories
  end

  def test_it_can_calculate_ingredient_contributions_to_total_calories
    @mac_and_cheese.add_ingredient(@cheese, 2)
    @mac_and_cheese.add_ingredient(@mac, 8)
    assert_equal 200, @mac_and_cheese.ingredient_calories(@cheese)
    assert_equal 240, @mac_and_cheese.ingredient_calories(@mac)
  end

  def test_it_can_concatenate_amount_and_unit_of_ingredient_as_string
    @mac_and_cheese.add_ingredient(@cheese, 2)
    @mac_and_cheese.add_ingredient(@mac, 8)
    expected = [{:ingredient=>"Macaroni", :amount=>"8 oz"},
                {:ingredient=>"Cheese", :amount=>"2 C"}]
    assert_equal expected, @mac_and_cheese.ingredients_in_units
  end
end
