resource_name :pathogen_plugin

default_action :install

property :name, String, required: true, name_property: true
property :github_org,  String, required: true

action :install do
  git name do
    repository "https://github.com/#{github_org}/#{name}.git"
    revision   'master'
    destination ::File.join(node['pathogen']['install_path'], 'bundle', name)
  end
end
