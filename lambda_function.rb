require 'json'

def lambda_handler(event:, context:)
  url = "https://lm-api-reads.fantasy.espn.com/apis/v3/games/flb/seasons/2024/segments/0/leagues/#{ENV['SWID']}?scoringPeriodId=151&view=kona_playercard"
  headers = {
    'Host' => 'lm-api-reads.fantasy.espn.com',
    'Cookie' => "espn_s2=#{ENV['ESPN_S2']}",
    'X-Fantasy-Filter' => '{"players":{"filterIds":{"value":[4781491]},"filterStatsForTopScoringPeriodIds":{"value":162,"additionalValue":["002024","102024","002023","012024","022024","032024","042024","062024","010002024"]}}}'
  }

  response = JSON.parse(Net::HTTP.get(URI(url), headers))
  
  { statusCode: 200, body: response.dig('players') || {} }
end
