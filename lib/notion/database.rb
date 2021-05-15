module Notion
  module Database
    def get_database(id)
      get("databases/#{id}")
    end

    def get_databases
      get("databases")
    end

    def query_database(id, query)
      post("databases/#{id}/query", query.to_json)
    end
  end
end