require 'net/http'
require 'cgi'
require 'json'

class SpotifySearch
  SEARCH_URI = URI('https://api.spotify.com/v1/search')
  CLIENT_ID = ENV['SPOTIFY_CLIENT_ID']
  SECRET = ENV['SPOTIFY_CLIENT_SECRET']

  attr_reader :results

  def initialize(search_string)
    json = make_request(search_string)
    if json[:error].present?
      Rails.logger.warn json[:error][:message]
      @results = {}
      return
    end
    @results = (json.dig(:tracks, :items) || {}).map { |track| SongRequest.build_from_json(track) }
  end

  private
  def make_request(search_string)
    params = {
      query: search_string,
      type: 'track',
      limit: '50',
      market: 'US'
    }

    uri = SEARCH_URI.clone
    uri.query = query_string(params)

    Net::HTTP.start(uri.host, uri.port,
                    use_ssl: uri.scheme == 'https') do |http|
      request = Net::HTTP::Get.new uri
      request['Accept'] = 'application/json'

      JSON.parse(http.request(request).body, symbolize_names: true)
    end
  rescue => e
    puts e
    {}
  end

  def query_string(params)
    params.map { |k, v| "#{k}=#{CGI::escape(v)}" }.join('&')
  end
end
