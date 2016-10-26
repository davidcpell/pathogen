#
# Cookbook Name:: pathogen
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'pathogen::plugins' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
      node.normal['pathogen']['plugins'] = { 'org' => 'plug' }
    end.converge(described_recipe)
  end

  before do
    allow(::File).to receive(:read).and_call_original
    allow(::File).to receive(:read).with('/root/.vimrc').and_return('')
  end

  it 'installs each plugin in the list' do
    expect(chef_run).to install_pathogen_plugin('plug')
  end
end
