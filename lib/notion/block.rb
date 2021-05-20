module Notion
  module Block

    def get_children(block_id)
      get("blocks/#{block_id}/children")
    end

    def add_children(block_id, children_blocks)
      patch("blocks/#{block_id}/children", children_blocks.to_json)
    end

  end
end