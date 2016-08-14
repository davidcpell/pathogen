resource_name :pathogen_plugin

default_action :install

property :name, String, required: true, name_property: true
property :org,  String, required: true
property :user, String, required: true

action :install do
  git name do
    repository "https://github.com/#{org}/#{name}.git"
    revision   'master'
    user node['user']
    destination "/home/#{node['user']}/.vim/bundle/#{name}"
  end
end
