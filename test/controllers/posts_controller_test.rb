require 'test_helper'

class PostsControllerTest < ActionController::TestCase

  def login_brit!
    session[:user_id] = users(:brit).id
    # For APIs: @request.headers['Access-Token'] = users(:brit).access_token
  end

  test "logged in users can write a new post" do
    login_brit!
    get :new
    assert_response 200
    assert_not_nil assigns(:post)
  end

  test "non-logged in users can't write posts" do
    get :new
    assert_redirected_to login_path
  end

  test "editing a post succeeds with valid IDs" do
    login_brit!
    get :edit, { id: posts(:one).id }
    assert_response :success
    assert_not_nil assigns(:post)
  end
end
