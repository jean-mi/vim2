#!/usr/bin/env ruby

git_bundles = %w{  
    git://github.com/astashov/vim-ruby-debugger.git
    git://github.com/godlygeek/tabular.git
    git://github.com/pangloss/vim-javascript.git
    git://github.com/scrooloose/nerdtree.git
    git://github.com/timcharper/textile.vim.git
    git://github.com/tomtom/tcomment_vim.git
    git://github.com/tpope/vim-cucumber.git
    git://github.com/tpope/vim-endwise.git
    git://github.com/tpope/vim-fugitive.git
    git://github.com/tpope/vim-git.git
    git://github.com/tpope/vim-haml.git
    git://github.com/tpope/vim-markdown.git
    git://github.com/tpope/vim-rails.git
    git://github.com/tpope/vim-repeat.git
    git://github.com/tpope/vim-surround.git
    git://github.com/tpope/vim-vividchalk.git
    git://github.com/tsaleh/vim-matchit.git
    git://github.com/tsaleh/vim-shoulda.git
    git://github.com/tsaleh/vim-tmux.git
    git://github.com/tsaleh/vim-supertab.git
    git://github.com/vim-ruby/vim-ruby.git
    git://github.com/vim-scripts/Gist.vim.git
    git://github.com/vim-scripts/IndexedSearch.git
    git://github.com/vim-scripts/jQuery.git
    git://github.com/vim-scripts/taglist.vim.git
    git://github.com/kana/vim-textobj-user.git
    git://github.com/nelstrom/vim-textobj-rubyblock.git
    git://github.com/jgdavey/vim-blockle.git
    git://github.com/Shougo/neocomplcache.git
    git://github.com/sickill/vim-pasta.git
    git://github.com/ecomba/vim-ruby-refactoring.git
}

require 'fileutils'
require 'open-uri'

bundles_dir = File.join(File.dirname(__FILE__), "bundle")

FileUtils.rm_rf(bundles_dir)
FileUtils.mkdir(bundles_dir)
FileUtils.cd(bundles_dir)

git_bundles.each do |url|
    puts url
    `git clone -q #{url}`
end

Dir["*/.git"].each {|f| FileUtils.rm_rf(f) }

__END__


# vim_org_scripts = [
#  ["IndexedSearch", "7062",  "plugin"],
# ]

__END__

require 'fileutils'
require 'open-uri'

bundles_dir = File.join(File.dirname(__FILE__), "bundle")

FileUtils.cd(bundles_dir)

puts "Trashing everything (lookout!)"
Dir["*"].each {|d| FileUtils.rm_rf d }

git_bundles.each do |url|
  dir = url.split('/').last.sub(/\.git$/, '')
  puts "  Unpacking #{url} into #{dir}"
  `git clone #{url} #{dir}`
  FileUtils.rm_rf(File.join(dir, ".git"))
end

vim_org_scripts.each do |name, script_id, script_type|
  puts "  Downloading #{name}"
  local_file = File.join(name, script_type, "#{name}.vim")
  FileUtils.mkdir_p(File.dirname(local_file))
  File.open(local_file, "w") do |file|
    file << open("http://www.vim.org/scripts/download_script.php?src_id=#{script_id}").read
  end
end
