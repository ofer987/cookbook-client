class Chef
  class Recipe
    def get_nodes(role_name)
      role_name = role_name.to_s.strip

      ::Chef::Search::Query
        .new
        .search(:node, "role:#{role_name}")
        .first
    end
  end
end
