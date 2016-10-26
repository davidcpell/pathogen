#
# Cookbook Name:: pathogen
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'pathogen_test::default' do
  before do
    allow(::File).to receive(:read).and_call_original
    allow(::File).to receive(:read).with('/home/vagrant/.vimrc').and_return('')
    allow(Dir).to receive(:home).with('vagrant').and_return('/home/vagrant')
  end

  let(:chef_run_ubuntu_1404) do
    ChefSpec::SoloRunner.new(
      platform: 'ubuntu',
      version: '14.04',
      step_into: ['pathogen_base']).converge(described_recipe)
  end

  let(:chef_run_ubuntu_1604) do
    ChefSpec::SoloRunner.new(
      platform: 'ubuntu',
      version: '16.04',
      step_into: ['pathogen_base']).converge(described_recipe)
  end

  it 'creates the install dir' do
    expect(chef_run_ubuntu_1404).to create_directory('/home/vagrant/.vim')
    expect(chef_run_ubuntu_1604).to create_directory('/home/vagrant/.vim')
  end

  it 'creates the autoload dir' do
    expect(chef_run_ubuntu_1404).to create_directory('/home/vagrant/.vim/autoload')
    expect(chef_run_ubuntu_1604).to create_directory('/home/vagrant/.vim/autoload')
  end

  it 'creates the bundle dir' do
    expect(chef_run_ubuntu_1404).to create_directory('/home/vagrant/.vim/bundle')
    expect(chef_run_ubuntu_1604).to create_directory('/home/vagrant/.vim/bundle')
  end

  it 'creates pathogen.vim from a remote file' do
    expect(chef_run_ubuntu_1404).to create_remote_file('/home/vagrant/.vim/autoload/pathogen.vim')
    expect(chef_run_ubuntu_1604).to create_remote_file('/home/vagrant/.vim/autoload/pathogen.vim')
  end

  it 'creates .vimrc if it does not exist' do
    expect(chef_run_ubuntu_1404).to create_file_if_missing('/home/vagrant/.vimrc')
    expect(chef_run_ubuntu_1604).to create_file_if_missing('/home/vagrant/.vimrc')
  end

  it 'adds pathogen init to .vimrc' do
    expect(chef_run_ubuntu_1404).to run_bash('add pathogen to .vimrc')
    expect(chef_run_ubuntu_1604).to run_bash('add pathogen to .vimrc')
  end

  context 'when .vimrc already contains pathogen init' do
    it 'does not add pathogen init to .vimrc' do
      allow(::File).to receive(:read).with('/home/vagrant/.vimrc').and_return('/execute pathogen#infect()')

      expect(chef_run_ubuntu_1404).not_to run_bash('add pathogen to .vimrc')
      expect(chef_run_ubuntu_1604).not_to run_bash('add pathogen to .vimrc')
    end
  end
end
