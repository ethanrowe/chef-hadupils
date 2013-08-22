#
# Cookbook Name:: hadupils
# Resource:: script
#
# Copyright 2013, Ethan Rowe
#

actions :create, :delete
default_action :create

attribute :path, :name_attribute => true, :kind_of => String, :required => true
attribute :command, :kind_of => String
attribute :owner, :kind_of => String
attribute :group, :kind_of => String
attribute :mode, :kind_of => String, :default => '0555', :regex => /^\d?[0-7]{3,3}$/

def hadupils_subcommand
  if command.nil? or command == ''
    ::File.basename path
  else
    command
  end
end
