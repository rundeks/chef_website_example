require 'spec_helper'

describe 'the httpd is working' do
  it 'is up and running' do
    expect(command('curl localhost').stdout).to match '<h1>Automation for the People</h1>'
  end
end

describe 'the web_admin user' do
  it 'has home directory /home/www_admin' do
    expect(user 'www_admin').to have_home_directory '/home/www_admin'
  end

  it 'has login shell /bin/bash' do
    expect(user 'www_admin').to have_login_shell '/bin/bash'
  end
end

describe 'the default home page' do
  let(:index) { '/var/www/public_html/index.html' }

  it 'exists' do
    expect(file index).to exist
  end

  it 'is a file' do
    expect(file index).to be_file
  end

  it 'has mode 644' do
    expect(file index).to be_mode 644
  end

  it 'is owned by web_admin' do
    expect(file index).to be_owned_by 'www_admin'
    expect(file index).to be_grouped_into 'www_admin'
  end
end

describe 'the httpd-default service' do
  it 'is enabled' do
    expect(service 'httpd-default').to be_enabled
  end
  it 'is running' do
    expect(service 'httpd-default').to be_running
  end
end

