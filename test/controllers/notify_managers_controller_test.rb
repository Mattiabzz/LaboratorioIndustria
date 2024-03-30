require "test_helper"

class NotifyManagersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @notify_manager = notify_managers(:one)
  end

  test "should get index" do
    get notify_managers_url
    assert_response :success
  end

  test "should get new" do
    get new_notify_manager_url
    assert_response :success
  end

  test "should create notify_manager" do
    assert_difference("NotifyManager.count") do
      post notify_managers_url, params: { notify_manager: { event_id: @notify_manager.event_id, manager_id: @notify_manager.manager_id, tipo: @notify_manager.tipo } }
    end

    assert_redirected_to notify_manager_url(NotifyManager.last)
  end

  test "should show notify_manager" do
    get notify_manager_url(@notify_manager)
    assert_response :success
  end

  test "should get edit" do
    get edit_notify_manager_url(@notify_manager)
    assert_response :success
  end

  test "should update notify_manager" do
    patch notify_manager_url(@notify_manager), params: { notify_manager: { event_id: @notify_manager.event_id, manager_id: @notify_manager.manager_id, tipo: @notify_manager.tipo } }
    assert_redirected_to notify_manager_url(@notify_manager)
  end

  test "should destroy notify_manager" do
    assert_difference("NotifyManager.count", -1) do
      delete notify_manager_url(@notify_manager)
    end

    assert_redirected_to notify_managers_url
  end
end
