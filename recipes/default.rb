#
# Cookbook Name:: pathogen
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

user    = node['user']
vim_dir = File.join('/', 'home', user, '.vim')

package 'git'

directory File.join(vim_dir, 'autoload') do
  recursive true
  action    :create
end

directory File.join(vim_dir, 'bundle') do
  recursive true
  action    :create
end

bash 'download pathogen' do 
  pathogen = File.join(vim_dir, 'autoload', 'pathogen.vim')

  code "wget -O #{pathogen} https://tpo.pe/pathogen.vim"

  not_if { File.exist?(pathogen) }
end
