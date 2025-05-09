module Issues
  module DraftsHelper
    def geolocate_latest_draft
      draft = Issues::Draft.last
      draft.address_data = {}
      draft.address_city = "Bratislava"
      draft.address_municipality = "Karlova Ves"
      draft.address_street = "Zohorská"
      draft.address_house_number = "3"
      draft.save!
    end

    def generate_checks_for_latest_draft
      d = Issues::Draft.last
      d.checks = [
        {
          title: "Graffity",
          info: "Toto moze chvilu trvat",
          more_info: "/more-info",
          action: "confirm"
        }
      ]
      d.save!
    end
  end
end
