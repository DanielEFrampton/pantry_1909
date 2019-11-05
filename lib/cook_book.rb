class CookBook
  attr_reader :recipes

  def initialize
    @recipes = []
  end

  def add_recipe(recipe)
    @recipes << recipe
  end

  def single_summary(recipe)
    { name: recipe.name,
      details: {
                ingredients: recipe.ingredients_in_units,
                total_calories: recipe.total_calories
               }
    }
  end

end
