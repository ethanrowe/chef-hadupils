#
# Cookbook Name:: hadupils
# Recipe:: default
#
# Copyright 2013, Ethan Rowe
#

installs = node['hadupils']['installs']

if installs['gem']
  gem_package 'hadupils' do
    action :install
  end
end

if installs['chef_gem']
  chef_gem 'hadupils' do
    action :install
  end
end
