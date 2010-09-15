#!/usr/bin/env ruby

# Jacked most of this from tammer Saleh, thanks dude!
# http://tammersaleh.com/posts/the-modern-vim-config-with-pathogen

git_bundles = [
  "git://github.com/astashov/vim-ruby-debugger.git",
  "git://github.com/msanders/snipmate.vim.git",
  "git://github.com/scrooloose/nerdtree.git",
  "git://github.com/tpope/vim-fugitive",
  "git://github.com/tpope/vim-git.git",
  "git://github.com/tpope/vim-haml.git",
  "git://github.com/tpope/vim-markdown.git",
  "git://github.com/tpope/vim-rails.git",
  "git://github.com/tpope/vim-rake.git",
  "git://github.com/tpope/vim-repeat.git",
  "git://github.com/tpope/vim-surround.git",
  "git://github.com/tpope/vim-vividchalk.git",
  "git://github.com/tsaleh/vim-align.git",
  "git://github.com/tsaleh/vim-matchit.git",
  "git://github.com/tsaleh/vim-shoulda.git",
  "git://github.com/tsaleh/vim-supertab.git",
  "git://github.com/tsaleh/vim-tcomment.git",
  "git://github.com/vim-ruby/vim-ruby.git",
  "git://github.com/akitaonrails/Command-T.git",
  "git://github.com/mileszs/ack.vim.git",
  "git://github.com/mattn/gist-vim",
  "git://github.com/leshill/vim-json.git",
  "git://github.com/scrooloose/syntastic.git"
]

vim_org_scripts = [
  ["Gemfile", "12498", "syntax"],
  ["minibufexpl", "3640", "plugin"],
  ["IndexedSearch", "7062",  "plugin"],
  ["gist",          "13105", "plugin"],
  ["jquery",        "12276", "syntax"],
  ["comments", "9801", "plugin"]
]

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

#get specky
url = "http://code.martini.nu/vim-stuff/"
dir = url.split('/').last
puts "Unpacking #{url} into #{dir}"
`hg clone #{url} #{dir}`
FileUtils.mv(File.join(dir, "specky"), '.')
FileUtils.rm_rf(dir)

#make command-t
FileUtils.cd("Command-T/ruby/command-t")
`ruby extconf.rb`
`make`
