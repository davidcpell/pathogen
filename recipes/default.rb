#
# Cookbook Name:: pathogen
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

user    = node['user']
home    = File.join('/', 'home', user)
vim_dir = File.join(home, '.vim')
vimrc   = File.join(home, '.vimrc')
permissions = '0744'

directory vim_dir do
  user  user
  group 'root'
  mode  permissions
end

directory File.join(vim_dir, 'autoload') do
  user      user
  group     'root'
  mode      permissions
end

directory File.join(vim_dir, 'bundle') do
  user  user
  group 'root'
  mode  permissions
end

file vimrc do
  user  user
  group 'root'
  mode  permissions
end

remote_file File.join(vim_dir, 'autoload', 'pathogen.vim') do
  source 'https://tpo.pe/pathogen.vim'
  user   user
  group  'root'
  mode   permissions
end

bash 'initialize pathogen in .vimrc' do
  code "echo 'execute pathogen#infect()' >> #{vimrc}"

  not_if do
    contents = File.read(vimrc)
    contents.match(/execute pathogen#infect\(\)/)
  end
end
