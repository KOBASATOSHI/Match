require 'test_helper'

class FavoriteTest < ActiveSupport::TestCase
  def setup
    @favorite = Favorite.new(favor_id: users(:User1).id,
                                     favored_id: users(:User2).id)
  end
  
  test "should be valid" do
    assert @favorite.valid?
  end

  test "should require a fovor_id" do
    @favorite.favor_id = nil
    assert_not @favorite.valid?
  end

  test "should require a fovored_id" do
    @favorite.favored_id = nil
    assert_not @favorite.valid?
  end
end
