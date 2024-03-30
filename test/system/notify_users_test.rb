require "application_system_test_case"

class NotifyUsersTest < ApplicationSystemTestCase
  setup do
    @notify_user = notify_users(:one)
  end

  test "visiting the index" do
    visit notify_users_url
    assert_selector "h1", text: "Notify users"
  end

  test "should create notify user" do
    visit notify_users_url
    click_on "New notify user"

    fill_in "Event", with: @notify_user.event_id
    fill_in "Tipo", with: @notify_user.tipo
    fill_in "User", with: @notify_user.user_id
    click_on "Create Notify user"

    assert_text "Notify user was successfully created"
    click_on "Back"
  end

  test "should update Notify user" do
    visit notify_user_url(@notify_user)
    click_on "Edit this notify user", match: :first

    fill_in "Event", with: @notify_user.event_id
    fill_in "Tipo", with: @notify_user.tipo
    fill_in "User", with: @notify_user.user_id
    click_on "Update Notify user"

    assert_text "Notify user was successfully updated"
    click_on "Back"
  end

  test "should destroy Notify user" do
    visit notify_user_url(@notify_user)
    click_on "Destroy this notify user", match: :first

    assert_text "Notify user was successfully destroyed"
  end
end
