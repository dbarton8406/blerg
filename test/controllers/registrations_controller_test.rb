require 'test_helper'

class RegistrationsControllerTest < ActionController::TestCase

  # def setup
  #   @request.headers['Access-Token'] = users(:brit).access_token
  # end

  test "new method supplies a empty model" do
    get :new
    assert_response :success
    assert_not_nil assigns(:user)
    assert assigns(:user).is_a?(User)
    assert_template :new
  end
end
