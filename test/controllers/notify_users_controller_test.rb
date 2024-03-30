require "test_helper"

class NotifyUsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @notify_user = notify_users(:one)
  end

  test "should get index" do
    get notify_users_url
    assert_response :success
  end

  test "should get new" do
    get new_notify_user_url
    assert_response :success
  end

  test "should create notify_user" do
    assert_difference("NotifyUser.count") do
      post notify_users_url, params: { notify_user: { event_id: @notify_user.event_id, tipo: @notify_user.tipo, user_id: @notify_user.user_id } }
    end

    assert_redirected_to notify_user_url(NotifyUser.last)
  end

  test "should show notify_user" do
    get notify_user_url(@notify_user)
    assert_response :success
  end

  test "should get edit" do
    get edit_notify_user_url(@notify_user)
    assert_response :success
  end

  test "should update notify_user" do
    patch notify_user_url(@notify_user), params: { notify_user: { event_id: @notify_user.event_id, tipo: @notify_user.tipo, user_id: @notify_user.user_id } }
    assert_redirected_to notify_user_url(@notify_user)
  end

  test "should destroy notify_user" do
    assert_difference("NotifyUser.count", -1) do
      delete notify_user_url(@notify_user)
    end

    assert_redirected_to notify_users_url
  end
end
