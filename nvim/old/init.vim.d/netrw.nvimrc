" We need to start with the command `:Vexplore` by default, to avoid some
" disagrement with the display of files
augroup FileTree
	autocmd!
augroup END

command! Oexplore exe 'Vexplore' getcwd()
nnoremap <leader>fb :Oexplore<cr>

" display list of marked files
nnoremap <leader>ml :echo netrw#Expose("netrwmarkfilelist")<cr>
" keep the current directory and browser synced
let g:netrw_keepdir = 0

" change the size of the net window when on a split (in %)
let g:netrw_winsize = 20

" hide the banner (use I to show it)
let g:netrw_banner = 0

" enable recursive copy of dir
let g:netrw_localcopydircmd = 'cp -r'

" use style with pipes
let g:netrw_liststyle = 3

" highlights matched files
hi! link netrwMarkFile Search

let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
