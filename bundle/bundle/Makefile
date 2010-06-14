PLUGIN = specky

SOURCE =  syntax/rdoc.vim
SOURCE += syntax/specrun.vim
SOURCE += syntax/rspec.vim
SOURCE += ftdetect/rspec.vim
SOURCE += ftplugin/rspec.vim
SOURCE += doc/specky.txt
SOURCE += plugin/specky.vim
SOURCE += snippets/rspec.snippets

${PLUGIN}.vba: ${SOURCE}
	- vim --cmd 'let g:plugin_name="${PLUGIN}"' -S build.vim -cq\!
	gzip ${PLUGIN}.vba

install:
	rsync -Rv ${SOURCE} ${HOME}/.vim/

clean:
	rm ${PLUGIN}.vba.gz
