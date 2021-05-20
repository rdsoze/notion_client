module Notion
  class Client

    include Database
    include Page
    include Block
    include Search
    include User

    attr_accessor :access_token

    URL = 'https://api.notion.com/v1/'

    def initialize(access_token)
      @access_token = access_token
    end

    def connection
      @connection ||= Faraday.new(url: URL) do |faraday|
        faraday.request :url_encoded
        faraday.adapter Faraday.default_adapter
      end
    end


    private

    def get(path, options = {})
      response = connection.get do |req|
        req.url path
        req.headers["Authorization"] = "Bearer #{access_token}"
        req.params = options
      end
      
      interpret_response(response)
    end

    def post(path, options = {})
      response = connection.post do |req|
        req.url path
        req.headers["Authorization"] = "Bearer #{access_token}"
        req.headers['Content-Type'] = "application/json"
        req.body = options
      end

      interpret_response(response)
    end

    def patch(path, options = {})
      response = connection.patch do |req|
        req.url path
        req.headers["Authorization"] = "Bearer #{access_token}"
        req.headers['Content-Type'] = "application/json"
        req.body = options
      end

      interpret_response(response)
    end

    def interpret_response(response)
      if response.status == 200
        JSON.parse response.body
      else
        handle_response_code(response)
      end
    end

    #improve
    def handle_response_code(response)
      JSON.parse response.body
    end
  end
end