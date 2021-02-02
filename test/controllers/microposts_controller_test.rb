require 'test_helper'

class MicropostsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @micropost = microposts(:orange)
  end

  test ' should redirect create when not logged in' do
    assert_no_difference 'Micropost.count'
  end
end
