let g:vimball_home="."
e Makefile
%!grep ^SOURCE
%s/^SOURCE\s\++\?=\s\+//
execute '%MkVimball!' . g:plugin_name
