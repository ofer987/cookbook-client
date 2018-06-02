default['nginx']['server_names_hash_bucket_size'] = '128'

default['transit.tips']['url'] = 'https://github.com/ofer987/transit.tips.git'
default['transit.tips']['dir'] = 'transit.tips'

default['transit.tips']['load_balancer']['domain'] =
  '~^(www|load)?\.transit\.tips$'
default['transit.tips']['load_balancer']['public_url'] =
  'https://load.transit.tips'

default['transit.tips']['client']['domain'] = 'client.transit.tips'
default['transit.tips']['client']['public_url'] = 'https://client.transit.tips'
default['transit.tips']['client']['dir'] = 'client'

default['transit.tips']['restbus']['domain'] = 'restbus.transit.tips'
default['transit.tips']['restbus']['public_url'] =
  'https://restbus.transit.tips'
default['transit.tips']['restbus']['dir'] = 'restbus'

default['secrets']['url'] = 'git@github.com:ofer987/secrets.git'
default['secrets']['dir'] = 'secrets'
