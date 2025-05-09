require "application_system_test_case"
require "test_helpers/issues/drafts_helper"

class Issues::DraftsTest < ApplicationSystemTestCase
  include Issues::DraftsHelper

  setup do
    @user = users(:one)
  end

  test "full issue creation with checks" do
    login(@user.email, "password")

    click_on "Nahlásiť podnet"

    attach_file "issues_draft_photos", "test/fixtures/files/graffiti-with-geo.jpg", visible: false

    assert_text "Lokalita"
    click_on "Pokračovať"

    assert_text "Popis podnetu"

    click_on "Vlastný nadpis podnetu"

    assert_text "Výber kategórie problému"
    click_on "Zeleň a životné prostredie"

    assert_text "Výber podkategórie problému"
    click_on "Strom"

    assert_text "Výber typu problému"
    click_on "vyvaleny"

    geolocate_latest_draft

    assert_text "Popis podnetu"
    fill_in "Názov", with: "Graffiti"
    fill_in "Popis", with: "Je tu graffiti, treba vycistit"
    click_on "Pokračovať"

    generate_checks_for_latest_draft

    assert_text "Zhrnutie podnetu"
    click_on "Odoslať podnet"

    assert_text "Podnet má problém"
    click_on "Odoslať podnet aj tak"

    assert_text "Podnet bol odoslaný!"
  end
end
