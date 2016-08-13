#
# Cookbook Name:: pathogen
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

user    = node['user']
home    = File.join('/', 'home', user)
vim_dir = File.join(home, '.vim')
vimrc   = File.join(home, '.vimrc')

package 'git'

directory File.join(vim_dir, 'autoload') do
  recursive true
  action    :create
end

directory File.join(vim_dir, 'bundle') do
  recursive true
  action    :create
end

file vimrc

bash 'download pathogen' do 
  pathogen = File.join(vim_dir, 'autoload', 'pathogen.vim')

  code "wget -O #{pathogen} https://tpo.pe/pathogen.vim"

  not_if { File.exist?(pathogen) }
end

bash 'initialize pathogen in .vimrc' do
  code "echo 'execute pathogen#infect()' >> #{vimrc}"

  not_if do 
    contents = File.read(vimrc)
    contents.match(/execute pathogen#infect\(\)/)
  end
end
