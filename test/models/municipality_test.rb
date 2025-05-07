require "test_helper"

class MunicipalityTest < ActiveSupport::TestCase
  test "find_by_address returns municipality by municipality when only municipality matches aliases" do
    # Setup
    municipality = municipalities(:two)

    # Execute
    result_municipality, result_district = Municipality.find_by_address(
      city: "Irrelevant",
      municipality: "banska-bystrica",
      suburb: "Irrelevant"
    )

    # Verify
    assert_equal municipality, result_municipality
    assert_nil result_district
  end

  test "find_by_address returns municipality district when suburb matches district aliases" do
    # Setup
    municipality = municipalities(:one)
    district = municipality_districts(:one)

    # Execute
    result_municipality, result_district = Municipality.find_by_address(
      city: "Irrelevant",
      municipality: "Bratislava",
      suburb: "stare-mesto"
    )

    # Verify
    assert_equal municipality, result_municipality
    assert_equal district, result_district
  end

  test "find_by_address prioritizes district from Bratislava when multiple districts match" do
    # Setup
    bratislava = municipalities(:one)
    district = municipality_districts(:one)

    # Execute
    result_municipality, result_district = Municipality.find_by_address(
      city: "Bratislava",
      municipality: "Staré Mesto",
      suburb: "Irrelevant"
    )

    # Verify
    assert_equal bratislava, result_municipality
    assert_equal district, result_district
  end

  test "find_by_address returns nil when municipality exists but has no aliases" do
    # Setup
    municipality = municipalities(:one)
    municipality.update!(aliases: [])

    # Execute
    result_municipality, result_district = Municipality.find_by_address(
      city: "Irrelevant",
      municipality: "Bratislava",
      suburb: "Irrelevant"
    )

    # Verify
    assert_nil result_municipality
    assert_nil result_district
  end

  test "find_by_address returns nil, nil when municipality exists but is not active" do
    # Setup
    municipality = municipalities(:two)
    municipality.update!(active: false)

    # Execute
    result_municipality, result_district = Municipality.find_by_address(
      city: "Irrelevant",
      municipality: "banska-bystrica",
      suburb: "Irrelevant"
    )

    # Verify
    assert_nil result_municipality
    assert_nil result_district
  end
end
