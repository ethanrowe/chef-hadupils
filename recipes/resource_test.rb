#
# Cookbook Name:: hadupils
# Recipe:: resource_test
#
# Copyright 2013, Ethan Rowe
#
## Note that this recipe is strictly intended for testing
## the hadupils_script resource and not intended for use in a
## "real" chef run.

attrs = node['hadupils']['resource_test']

hadupils_script attrs['path'] do
  action  attrs['action']   if attrs['action']
  command attrs['command']  if attrs['command']
  owner   attrs['owner']    if attrs['owner']
  group   attrs['group']    if attrs['group']
  mode    attrs['mode']     if attrs['mode']
end

