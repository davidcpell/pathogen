#
# Cookbook Name:: pathogen
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

install_path = node['pathogen']['install_path']
vimrc_path   = node['pathogen']['vimrc_path']

directory install_path do
  mode '0777'
end

directory File.join(install_path, 'autoload') do
  mode '0777'
end

directory File.join(install_path, 'bundle') do
  mode '0777'
end

remote_file File.join(install_path, 'autoload', 'pathogen.vim') do
  source 'https://tpo.pe/pathogen.vim'
  mode   '0755'
end

file vimrc_path do 
  action :create_if_missing
end

bash 'initialize pathogen in .vimrc' do
  code "echo 'execute pathogen#infect()' >> #{vimrc_path}"

  not_if do
    contents = File.read(vimrc_path)
    contents.match(/execute pathogen#infect\(\)/)
  end
end
