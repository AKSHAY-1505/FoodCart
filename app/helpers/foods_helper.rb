module FoodsHelper
  def render_foods_of_category(category)
    yield if category.foods.count > 0
  end
end
