class Chef
  class Recipe
    class Network
      def self.get_nodes(role_name)
        role_name = role_name.to_s.strip

        ::Chef::Search::Query
          .new
          .search('node', "role:#{role_name}")[0]
          .reject { |i| i.nil? || i['cloud'].nil? }
          .reject { |i| i['roles'].empty? }
      end
    end
  end
end
