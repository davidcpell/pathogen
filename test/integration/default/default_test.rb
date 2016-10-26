describe directory('/home/vagrant/.vim/autoload') do
  it { should be_directory }
end

describe directory('/home/vagrant/.vim/bundle') do
  it { should be_directory }
end

describe file('/home/vagrant/.vim/autoload/pathogen.vim') do
  it { should be_file }
end

describe file('/home/vagrant/.vimrc') do
  its('content') { should match(/execute pathogen#infect\(\)/) }
end

describe directory('/home/vagrant/.vim/bundle/ctrlp.vim') do
  it { should be_directory }
end
