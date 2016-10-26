if node.platform == 'ubuntu' && node.platform_version == '16.04'
  execute 'apt-get update'
end

package %w(vim git)

pathogen_base 'install pathogen' do
  users ['vagrant']
end

pathogen_plugin 'ctrlp.vim' do
  github_org 'ctrlpvim'
  users      ['vagrant']
end
