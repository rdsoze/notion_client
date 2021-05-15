module Notion
  class Client

    include Database

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

    def interpret_response(response)
      if response.status == 200
        body = JSON.parse response.body
        interpret_object(body["results"], body["object"])
      else
        handle_response_code(response)
      end
    end

    def interpret_object(results, object)
      if object == 'list'
        results
      end
    end

    def handle_response_code(response)
      JSON.parse response.body
    end
  end
end