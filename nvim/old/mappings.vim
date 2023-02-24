" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" Open window in vertical split
nnoremap <leader>v :vsplit<cr>
" Open window in horizontal split
nnoremap <leader>h :split<cr>


" Use alt + hjkl to resize windows
nnoremap <S-j>    :resize -2<CR>
nnoremap <S-k>    :resize +2<CR>
nnoremap <S-l>    :vertical resize -2<CR>
nnoremap <S-h>    :vertical resize +2<CR>

" TAB in general mode will move to text buffer
nnoremap <TAB> :bnext<CR>
" SHIFT-TAB will go back
nnoremap <S-TAB> :bprevious<CR>

"close buffer without closing current window
nnoremap <leader>q :Bdelete<cr> 
"buffer next
nnoremap <leader>bn :bn<cr>
"new tab
nnoremap <leader>t :tabnew<cr>
"next tab
nnoremap <leader>n gt
"close tab
nnoremap <leader>c :tabclose<cr>

" un-highlight when esc is pressed
nnoremap <silent> <c-c> <Cmd>noh<cr>

" Alternate way to save
nnoremap <C-s> :w<CR>
" Alternate way to quit
nnoremap <C-Q> :wq!<CR>
" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Easy CAPS
inoremap <c-u> <ESC>viwUi
nnoremap <c-u> viwU<Esc>

" edit vimrc with f5 and source it with f6
nnoremap <silent> <leader>i :vsplit $MYVIMRC<CR>
nnoremap <silent> <leader><CR> :source $MYVIMRC<CR>
