#
# Chef Documentation
# https://docs.chef.io/libraries.html
#
class Chef
  class Recipe
    class User
      attr_reader :name, :home, :node

      def initialize(name, home, node)
        self.name = name or raise 'name cannot be nil'
        self.home = home or raise 'home cannot be nil'
        self.node = node or raise 'node cannot be nil'
      end

      def transit_tips_path
        File.join(home, node['transit.tips']['dir'])
      end

      def client_path
        File.join(transit_tips_path, 'client')
      end

      def secrets_path
        File.join(home, node['secrets']['dir'])
      end

      private

      attr_writer :name, :home, :node
    end

    def my_chef_user
      User.new('chef', '/home/chef', node)
    end

    def my_nginx_user
      User.new(node['nginx']['user'], Dir.home(node['nginx']['user']), node)
    end

    def my_root_user
      User.new('root', Dir.home('root'), node)
    end
  end
end
