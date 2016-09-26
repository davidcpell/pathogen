package 'git'

plugins = node['pathogen']['plugins'] || []

plugins.each do |pair|
  pair.each do |org, plugin|
    pathogen_plugin plugin do
      github_org org
    end
  end
end
