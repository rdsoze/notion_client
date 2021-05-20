module Notion
  module Search

    def search(body)
      post("search", body.to_json)
    end

  end
end