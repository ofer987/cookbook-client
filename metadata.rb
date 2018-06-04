name 'transit.tips'
maintainer 'Dan Jakob Ofer'
maintainer_email 'dan@ofer.to'
license 'MIT'
description 'Installs/Configures transit.tips'
long_description 'Installs/Configures transit.tips'
version '0.1.54'
chef_version '>= 12.1' if respond_to?(:chef_version)

depends 'nginx', '~> 7.0.1'
depends 'git', '~> 8.0.0'
depends 'nodejs', '~> 5.0.0'
depends 'ruby_rbenv', '~> 2.0.5'
depends 'chef-client', '~> 10.0.3'

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/transit.tips/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/transit.tips'
