name 'build_cookbook'
maintainer 'Dan Jakob Ofer'
maintainer_email 'dan@ofer.to'
license 'mit'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

depends 'delivery-truck'
