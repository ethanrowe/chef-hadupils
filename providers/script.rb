#
# Cookbook Name:: hadupils
# Provider:: script
#
# Copyright 2013, Ethan Rowe
#

def whyrun_supported?
  true
end

action :create do
  converge_by "create hadupils_script at #{new_resource.path}" do
    template new_resource.path do
      source 'script.erb'
      cookbook 'hadupils'
      owner new_resource.owner if new_resource.owner
      group new_resource.group if new_resource.group
      mode  new_resource.mode if new_resource.mode
      variables :command => new_resource.hadupils_subcommand
      action :create
    end
  end
end

action :delete do
  # We don't bother checking for existence, we completely delegate
  # to the file resource.
  converge_by "delete hadupils_script at #{new_resource.path}" do
    file new_resource.path do
      action :delete
    end
  end
end

def load_current_resource
  @current_resource = Chef::Resource::HadupilsScript.new(new_resource.path)
end

