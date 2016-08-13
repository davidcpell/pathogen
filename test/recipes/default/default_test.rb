home     = File.join('/', 'home', 'vagrant')
vim_path = File.join(home, '.vim')

describe directory(File.join(vim_path, 'autoload')) do 
  it { should be_directory }
end

describe directory(File.join(vim_path, 'bundle')) do 
  it { should be_directory }
end

describe file(File.join(vim_path, 'autoload', 'pathogen.vim')) do 
  it { should be_file }
end

describe file(File.join(home, '.vimrc')) do 
  its('content') { should match /execute pathogen#infect\(\)/ }
end
