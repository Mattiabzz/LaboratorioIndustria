require "application_system_test_case"

class NotifyManagersTest < ApplicationSystemTestCase
  setup do
    @notify_manager = notify_managers(:one)
  end

  test "visiting the index" do
    visit notify_managers_url
    assert_selector "h1", text: "Notify managers"
  end

  test "should create notify manager" do
    visit notify_managers_url
    click_on "New notify manager"

    fill_in "Event", with: @notify_manager.event_id
    fill_in "Manager", with: @notify_manager.manager_id
    fill_in "Tipo", with: @notify_manager.tipo
    click_on "Create Notify manager"

    assert_text "Notify manager was successfully created"
    click_on "Back"
  end

  test "should update Notify manager" do
    visit notify_manager_url(@notify_manager)
    click_on "Edit this notify manager", match: :first

    fill_in "Event", with: @notify_manager.event_id
    fill_in "Manager", with: @notify_manager.manager_id
    fill_in "Tipo", with: @notify_manager.tipo
    click_on "Update Notify manager"

    assert_text "Notify manager was successfully updated"
    click_on "Back"
  end

  test "should destroy Notify manager" do
    visit notify_manager_url(@notify_manager)
    click_on "Destroy this notify manager", match: :first

    assert_text "Notify manager was successfully destroyed"
  end
end
