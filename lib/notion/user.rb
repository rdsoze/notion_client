module Notion
  module User

    def get_user(user_id)
      get("users/#{user_id}")
    end

    def get_users
      get("users")
    end

  end
end