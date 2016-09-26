#
# Cookbook Name:: pathogen
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'pathogen::default' do
  before do 
    allow(::File).to receive(:read).and_call_original
    allow(::File).to receive(:read).with('/root/.vimrc').and_return('')
  end

  let(:chef_run) do
    runner = ChefSpec::ServerRunner.converge(described_recipe)
  end

  it 'creates the install dir' do 
    expect(chef_run).to create_directory('/root/.vim')
  end

  it 'creates the autoload dir' do 
    expect(chef_run).to create_directory('/root/.vim/autoload')
  end

  it 'creates the bundle dir' do 
    expect(chef_run).to create_directory('/root/.vim/bundle')
  end

  it 'creates pathogen.vim from a remote file' do 
    expect(chef_run).to create_remote_file('/root/.vim/autoload/pathogen.vim')
  end

  it 'creates .vimrc if it does not exist' do 
    expect(chef_run).to create_file_if_missing('/root/.vimrc')
  end

  it 'adds pathogen init to .vimrc' do 
    expect(chef_run).to run_bash('initialize pathogen in .vimrc')
  end

  context 'when .vimrc already contains pathogen init' do 
    it 'does not add pathogen init to .vimrc' do 
      allow(::File).to receive(:read).with('/root/.vimrc').and_return('/execute pathogen#infect()')

      expect(chef_run).not_to run_bash('initialize pathogen in .vimrc')
    end
  end
end
