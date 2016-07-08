json.array!(@rsvps) do |rsvp|
  json.extract! rsvp, :id, :first_name, :last_name, :guests
  json.url rsvp_url(rsvp, format: :json)
end
