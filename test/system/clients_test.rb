require "application_system_test_case"

class ClientsTest < ApplicationSystemTestCase
  setup do
    @client = clients(:one)
  end

  test "visiting the index" do
    visit clients_url
    assert_selector "h1", text: "Connector clients"
  end

  test "should create connector client" do
    visit clients_url
    click_on "New connector client"

    fill_in "Api token public key", with: @client.api_token_public_key
    fill_in "Name", with: @client.name
    fill_in "Url", with: @client.url
    fill_in "Webhook private key", with: @client.webhook_private_key
    click_on "Create Connector client"

    assert_text "Connector client was successfully created"
    click_on "Back"
  end

  test "should update Connector client" do
    visit client_url(@client)
    click_on "Edit this connector client", match: :first

    fill_in "Api token public key", with: @client.api_token_public_key
    fill_in "Name", with: @client.name
    fill_in "Url", with: @client.url
    fill_in "Webhook private key", with: @client.webhook_private_key
    click_on "Update Connector client"

    assert_text "Connector client was successfully updated"
    click_on "Back"
  end

  test "should destroy Connector client" do
    visit client_url(@client)
    click_on "Destroy this connector client", match: :first

    assert_text "Connector client was successfully destroyed"
  end
end
