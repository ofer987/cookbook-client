# # encoding: utf-8

# Inspec test for recipe transit.tips::client

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

unless os.windows?
  # This is an example test, replace with your own test.
  describe user('root') do
    it { should exist }
  end
end

# This is an example test, replace it with your own test.
describe port(80) do
  it { should be_listening }
end

describe package 'nginx' do
  xit { is_expected.to be_installed }
end

describe service 'nginx-client' do
  xit { is_expected.to be_enabled }
  xit { is_expected.to be_running }
end

describe port 80 do
  it { is_expected.to be_listening }
end

describe command 'wget -qSO- --spider localhost' do
  its(:stderr) { is_expected.to match %r{HTTP/1\.1 200 OK} }
end

describe command 'wget -qO- localhost' do
  # its(:stdout) { is_expected.to match %r{Getting Schedule} }
end

describe service 'nginx-client', :skip do
  xit { should have_module('nginx::http_v2_module') }
end
