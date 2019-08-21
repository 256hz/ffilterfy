require 'base64'

# Gets @mentions from the Twitter API
class TwitterController < ApplicationController
  def index
    @token_string = ENV.fetch('TWITTER_API_KEY') + ':' + ENV.fetch('TWITTER_SECRET_KEY')
    @token_b64 = Base64.encode64(@token_string)
    # token = 'UGl1QnF0V1g3b1ZXSVNxVjNsTVdmTVFxeDo3d3hoR0cyTnRMQ3g1U1JJMUI0\n' \
    # 'TFlMR0c1T0lSTllBOERPc0o5VWt0VjB5M3ZmdFNnWA==\n'
    @auth_url = 'https://api.twitter.com/1.1/oauth2/token'
    # @mentions_url = 'https://api.twitter.com/1.1/statuses/mentions_timeline.json?trim_user=true'
    @headers = {
      # 'Host' => 'api.twitter.com',
      # 'User-Agent' => 'Ffilterfy 0.1',
      'Authorization' => "Basic #{@token_b64}",
      'Content-Type' => 'application/x-www-form-urlencoded;charset=UTF-8'
      # 'Content-Length' => '29',
      # 'Accept-Encoding' => 'gzip'
    }
    @bearer = HTTParty.post(@auth_url,
                            headers: @headers,
                            body: 'grant_type=client_credentials')
    render json: @bearer
    # render json: HTTParty.get(@mentions_url)
  end
end
