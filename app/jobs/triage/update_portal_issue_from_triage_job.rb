class Triage::UpdatePortalIssueFromTriageJob < ApplicationJob
  def perform(ticket_id, triage_zammad_client: TriageZammadEnvironment.client)
    ticket = triage_zammad_client.get_ticket(ticket_id)
    raise "Ticket not found" unless ticket

    issue = Issue.find_by(triage_external_id: ticket_id)
    raise "Issue not found" unless issue

    municipality = Municipality.find_by(name: ticket[:address_municipality].split("::").first)
    municipality_district = municipality&.municipality_districts&.find_by(name: ticket[:address_municipality].split("::").last)

    category = Issues::Category.find_by(name: ticket[:category])
    subcategory = category&.subcategories&.find_by(name: ticket[:subcategory])
    subtype = subcategory&.subtypes&.find_by(name: ticket[:subtype])

    issue.update!(
      title: ticket[:title],
      municipality: municipality,
      municipality_district: municipality_district,
      address_state: ticket[:address_state],
      address_county: ticket[:address_county],
      address_postcode: ticket[:address_postcode],
      address_street: ticket[:address_street],
      address_house_number: ticket[:address_house_number],
      latitude: ticket[:address_lat],
      longitude: ticket[:address_lon],
      category: category,
      subcategory: subcategory,
      subtype: subtype,
      state: Issues::State.find_by(name: ticket[:state]),
      responsible_subject: ticket[:responsible_subject],
    )

    return unless issue.should_create_resolution_process?

    resolution_external_id = triage_zammad_client.create_ticket_from_issue!(
      issue,
      process_type: "portal_issue_resolution",
      group: ticket[:triage_group],
      owner_id: ticket[:triage_owner_id]
    )

    issue.update!(
      resolution_external_id: resolution_external_id,
      last_synced_at: Time.now
    )

    triage_zammad_client.link_tickets!(issue.triage_external_id, resolution_external_id)

    # add article to old ticket
    triage_zammad_client.create_system_article!(
      ticket_id,
      "Triáž podnetu bola ukončená a bol vytvorený nový tiket na jeho vyriešenie."
    )

    # close the old triage ticket
    triage_zammad_client.close_ticket!(ticket_id)
  end
end
