module Notion
  module Page

    def get_page(page_id)
      get("pages/#{page_id}")
    end

    def create_page(parent, properties, children_blocks)
      body = {parent: parent, properties: properties, children: children_blocks}
      post("pages", body.to_json)
    end

    def update_page(page_id, properties)
      patch("pages/#{page_id}", properties.to_json)
    end
  
  end
end