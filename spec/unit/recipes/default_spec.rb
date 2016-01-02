#
# Cookbook Name:: chef_website_example
# Spec:: default
#
# Copyright (c) 2016 Kevin Runde, All Rights Reserved.

require 'spec_helper'

describe 'chef_website_example::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'creates user' do
      expect(chef_run).to create_user 'www_admin'
    end

    it 'creates Apache Service' do
      expect(chef_run).to create_httpd_service 'default'
    end

    it 'create Apache Config' do
      expect(chef_run).to create_httpd_config 'default'
    end

    it 'creates www root' do
      expect(chef_run).to create_directory('/var/www/public_html').with(
        recursive: true
      )
    end

    it "creates template['/var/www/public_html/index.html']" do
      expect(chef_run).to create_template('/var/www/public_html/index.html')
        .with(
          mode: '0644',
          owner: 'www_admin',
          group: 'www_admin'
        )
    end
  end
end
