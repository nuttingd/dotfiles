" Source externally organized settings
source ~/.vim/plugins.vim

"             _      _    
"  __ _ _   _(_) ___| | __
" / _` | | | | |/ __| |/ /
"| (_| | |_| | | (__|   < 
" \__, |\__,_|_|\___|_|\_\
"    |_|                  

" Theme
set termguicolors

let ui_theme = system('get-ui-theme')
colorscheme seoul256
let g:airline_theme = 'seoul256'
" seoul256 can be controled by set background=light|dark; no need to use seoul256-light directly
let &background = ui_theme 

" Prefer multi-line command and search (with history)
let g:multiline_command = 1

"  __                  _   _                 
" / _|_   _ _ __   ___| |_(_) ___  _ __  ___ 
"| |_| | | | '_ \ / __| __| |/ _ \| '_ \/ __|
"|  _| |_| | | | | (__| |_| | (_) | | | \__ \
"|_|  \__,_|_| |_|\___|\__|_|\___/|_| |_|___/
"That must be defined before they're referenced                                            
function! SetMultilineCommand()
   if g:multiline_command
      echo "MultilineCommand on."
      nnoremap : q:i
      nnoremap / q/i
      nnoremap ? q?i
   else
      echo "MultilineCommand off."
      nunmap :
      nunmap /
      nunmap ?
   endif
endfunction

" Toggle whether command and search mode uses the multiline / INSERT mode workspace
function! ToggleMultilineCommand()
   let g:multiline_command = (get(g:, 'multiline_command', 0) + 1) % 2
   call SetMultilineCommand()
endfunction

" Add checkbox to current line
function! AddCheckbox()
   let save_pos = getpos(".")
   normal! ^i- [ ] 
   echo save_pos
   call setpos(".", save_pos[0:1] + [ save_pos[2]+6 ] + save_pos[3:3] )
endfunction

" Add hyphen bullet to current line
function! AddHyphenBullet()
   let save_pos = getpos(".")
   normal! ^i- 
   echo save_pos
   call setpos(".", save_pos[0:1] + [ save_pos[2]+6 ] + save_pos[3:3] )
endfunction

" _     _           _ _
"| |__ (_)_ __   __| (_)_ __   __ _ ___
"| '_ \| | '_ \ / _` | | '_ \ / _` / __|
"| |_) | | | | | (_| | | | | | (_| \__ \
"|_.__/|_|_| |_|\__,_|_|_| |_|\__, |___/
"                             |___/

let g:mapleader = "\<Space>"
let g:maplocalleader = ','

inoremap jk <Esc>
"inoremap kj <Esc>

" Snippets ----------------------------------------------------------------------------
" Insert current timestamp 
" Ex: 2020-10-30 05:50:05 PM
nnoremap <silent><leader>id "=strftime("%Y-%m-%d %I:%M:%S %p")<cr>P
nnoremap <silent><leader>ad "=strftime("%Y-%m-%d %I:%M:%S %p")<cr>p

" Insert GUID
nnoremap <silent><leader>ig "=system('python -c "import uuid; print(uuid.uuid4(), end=\"\");"')<cr>P 
nnoremap <silent><leader>ag "=system('python -c "import uuid; print(uuid.uuid4(), end=\"\");"')<cr>p 

nnoremap <silent><leader>ic :call AddCheckbox()<cr>
nnoremap <silent><leader>ib :call AddHyphenBullet()<cr>

" remove highlights
nnoremap <Leader><Esc> :noh<cr>

" open terminal in current buffer
nnoremap <leader>T :term<cr>

" Create a blank line above/below current line
nnoremap <localleader>o o<ESC>k
nnoremap <localleader>O O<ESC>j

" Move to the first/last non-blank character on this line
map H ^
map L $

" Move up/down one line, moving to wrapped lines if applicable
nnoremap j gj
nnoremap k gk

" Move the current line or block up and down
" source: https://vim.fandom.com/wiki/Moving_lines_up_or_down
" this requires iTerm2 to map one or both of the Alts to Esc+
nnoremap <A-j> :m .+1<cr>==
nnoremap <A-k> :m .-2<cr>==
inoremap <A-j> <Esc>:m .+1<cr>==gi
inoremap <A-k> <Esc>:m .-2<cr>==gi
vnoremap <A-j> :m '>+1<cr>gv=gv
vnoremap <A-k> :m '<-2<cr>gv=gv

" Edit and sourcing helpers
nmap <silent> <leader>evr :e $HOME/.vimrc<cr>
nmap <silent> <leader>evp :e $HOME/.vim/plugins.vim<cr>
nmap <silent> <leader>rv :so $HOME/.vimrc<cr>
nmap <silent> <leader>edzr :e $HOME/.dotfiles/.zshrc<cr>
nmap <silent> <leader>edzp :e $HOME/.dotfiles/.zprofile<cr>
nmap <silent> <leader>edbr :e $HOME/.dotfiles/.bashrc<cr>
nmap <silent> <leader>edbp :e $HOME/.dotfiles/.bash_profile<cr>
nmap <silent> <leader>edsr :e $HOME/.dotfiles/.environment<cr>
nmap <silent> <leader>edsp :e $HOME/.dotfiles/.profile<cr>
nmap <silent> <localleader>ev :e $MYVIMRC<cr>
nmap <silent> <localleader>rv :so $MYVIMRC<cr>

" Settings toggles --------------------------------------------------------------------
nnoremap <Leader>sw :set wrap!<cr> 
nnoremap <Leader>sl :set number!<cr>
nnoremap <Leader>sr :set relativenumber!<cr>
nnoremap <Leader>sa :AutoSaveToggle<cr>
nnoremap <Leader>s: :call ToggleMultilineCommand()<cr>

" Git ---------------------------------------------------------------------------------
" I'm definitely not using vim-fugitive as intended. Need to spend some more
" time learning it.
nnoremap <Leader>gd :Gdiffsplit<cr>
nnoremap <Leader>gf :GFiles<cr>
nnoremap <Leader>gb :Git blame<cr>
nnoremap <Leader>gl :Gclog<cr>
nnoremap <Leader>gs :Git<cr>
nnoremap <Leader>gc :Commits<cr>

" Windows -----------------------------------------------------------------------------
nnoremap <Leader>w :Windows<cr>
" override default C-w q so trying to close the last window won't exit vim
" this doesn't work and seems to make calling command :close also :quit!
map <C-w>q :close<cr>
" ... unless you use Q
map <C-w>Q :quit<cr>

" Buffers -----------------------------------------------------------------------------
nnoremap <Leader>bl :Buffers<cr>

" https://github.com/qpkorr/vim-bufkill
nnoremap <Leader>bu :BUN<cr>
nnoremap <Leader>bd :BD<cr>
nnoremap <Leader>bw :BW<cr>

nnoremap <Leader>bb :BB<cr>
nnoremap <Leader>bf :BF<cr>

nnoremap <Leader>ba :BA<cr>

" constraining to normal mode only; map interferes with multiline_command
nnoremap <C-c> :BD<cr>

" These are supeceded by vim-bufkill
" Close buffer without closing window
" credit: https://stackoverflow.com/questions/1444322/how-can-i-close-a-buffer-without-closing-the-window
" alt 1:
" map <leader>q :bp<bar>bd #<cr>
" map <leader>Q :bp<bar>bd! #<cr>
" alt 2
" map <leader>q :bp<bar>sp<bar>bn<bar>bd<cr>
" map <leader>Q :bp<bar>sp<bar>bn<bar>bd!<cr>

" FZF others --------------------------------------------------------------------------
nnoremap <C-p> :Files<cr>
" tragic flaw: :Ag doesn't search .hidden files, and overridding the default is 
" non-trivial. I already spent hours investigating a solution
nnoremap <Leader><Leader> :Ag<cr>
nnoremap <Leader>m :Maps<cr>
nnoremap <Leader>c :Commands<cr>
nnoremap <Leader>t :Tags<cr>
" select language for file, e.g. python
nnoremap <Leader>l :Filetypes<cr>

" Mapping selecting mappings, similar to WhichKey
" Normal mode
nmap <leader><tab> <plug>(fzf-maps-n)
" Visual/Select mode
xmap <leader><tab> <plug>(fzf-maps-x)
" Operator pending mode
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

" actions for file-based popups
let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-s': 'split',
            \ 'ctrl-v': 'vsplit'
            \}

" COC --------------------------------------------------------------------------------- 
" Open CocConfig
nnoremap <silent><nowait> <localleader>ec :<C-u>CocConfig<cr>
" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <localleader>z  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <localleader>x  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <localleader>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
" TODO: is there a better FZF version of this?
nnoremap <silent><nowait> <localleader>d  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <localleader>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <localleader>j  :<C-u>CocNext<cr>
" Do default action for previous item.
nnoremap <silent><nowait> <localleader>k  :<C-u>CocPrev<cr>
" Resume latest coc list.
nnoremap <silent><nowait> <localleader>p  :<C-u>CocListResume<cr>
" Symbol renaming.
nmap <localleader>rn <Plug>(coc-rename)
" Refactoring
nmap <localleader>rf <Plug>(coc-refactor)

" Formatting selected code.
xmap <localleader>f  <Plug>(coc-format-selected)
nmap <localleader>f  <Plug>(coc-format-selected)
nmap <localleader>fc <Plug>(coc-format)

" Applying codeAction to the selected region.
" Example: `<localleader>aap` for current paragraph
xmap <localleader>,  <Plug>(coc-codeaction-selected)
nmap <localleader>,  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <localleader>a  <Plug>(coc-codeaction)

" Apply AutoFix to problem on the current line.
nmap <localleader>qf  <Plug>(coc-fix-current)

" easymotion --------------------------------------------------------------------------
let g:EasyMotion_do_mapping = 0 " Disable default mappings
" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap <Leader>f <Plug>(easymotion-overwin-f)
" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" markdown-preview --------------------------------------------------------------------
let vim_markdown_preview_hotkey='<Leader>m'
let vim_markdown_preview_browser='Firefox'

" NERDTree ----------------------------------------------------------------------------
" " Map to open current file in NERDTree and set size
nnoremap <leader>o :NERDTreeFind<bar><cr>
nmap <silent> <C-O> :NERDTreeToggle<cr>

" WhichKey ----------------------------------------------------------------------------
nnoremap <silent> <leader> :WhichKey '<Space>'<cr>
nnoremap <silent> <localleader> :WhichKey ','<cr>

"          _   _   _
" ___  ___| |_| |_(_)_ __   __ _ ___
"/ __|/ _ \ __| __| | '_ \ / _` / __|
"\__ \  __/ |_| |_| | | | | (_| \__ \
"|___/\___|\__|\__|_|_| |_|\__, |___/
"                          |___/

syntax on
syntax enable

set number
"set relativenumber
set hidden
set mouse=a
set noshowmode
set noshowmatch
set nolazyredraw

" I think I prefer wrapping
"set nowrap

" initialize g:multiline_commmand
call SetMultilineCommand()

set cmdheight=3
set shortmess=ac

set modeline
set modelines=5

" Autosave on
let g:auto_save = 1

" Autoread from disk when files change (only affects unchanged buffers)
set autoread

augroup AutoReadAutocmds
au!
" refresh after {updatetime} seconds
" CursorHold still fires in the q: command window, causing error messages.
" Checking for existance of "[Command Line]" buffer should suffice.
" Alternatively, I could set a buffer local variable (let b:var =...) and set
" it on BufNewFile,BufRead, but this seems less complicated.
"autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if !bufexists("[Command Line]") | checktime | endif
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
  \ if mode() == 'n' && getcmdwintype() == '' | checktime | endif
" warn if a file changed for a changed buffer (all buffers, really)
au FileChangedShell * echo "Warning: File changed on disk"
augroup END

" snappier updates (default: 4000)
set updatetime=1000

" FZF
" use the_silver_searcher for FZF
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" Clipboard support
set clipboard=unnamed

" Turn off backup
set nobackup
set noswapfile
set nowritebackup

" Search configuration
set ignorecase                    " ignore case when searching
set smartcase                     " turn on smartcase

" Tab and Indent configuration
set expandtab
set tabstop=4
" figure out a clean way to change this based on file (vim-sleuth is an option, 
" but I didn't like the OOTB settings)
set shiftwidth=2 

" Ignored files
set wildignore+=*.pyc,*.o,*.obj,*.svn,*.swp,*.class,*.hg,*.DS_Store,*.min.*

" Column line
set colorcolumn=81

" UI theme
let g:airline_left_sep  = ''
let g:airline_right_sep = ''
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" NERDTree
let g:NERDTreeWinSize=30
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeDirArrows = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1 " hide helper
let g:NERDTreeHighlightFolders = 1
let g:NERDTreeHighlightFoldersFullName = 1
let g:NERDTreeShowBookmarks=1

let g:NERDTreeIgnore = [
            \ '^node_modules$', 
            \ '^\.git$', 
            \ '^\.mypy_cache',
            \ '^\.pytest_cache$',
            \ '^__pycache__$',
            \ '^Icon\r$'
            \ ]
"let g:NERDTreeStatusline = '' " set to empty to use lightline
let NERDTreeRespectWildIgnore=1

" Close window if NERDTree is the last one
" I don't like how this interferes with my <C-w>q override
"autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" NERDTree Git Plugin
let g:NERDTreeGitStatusIndicatorMapCustom = {
            \ "Modified"  : "✹",
            \ "Staged"    : "✚",
            \ "Untracked" : "✭",
            \ "Renamed"   : "➜",
            \ "Unmerged"  : "═",
            \ "Deleted"   : "✖",
            \ "Dirty"     : "✗",
            \ "Clean"     : "✔︎",
            \ 'Ignored'   : '☒',
            \ "Unknown"   : "?"
            \ }

" COC ---------------------
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Extensions to auto install
let g:coc_global_extensions=[
      \'coc-git',
      \'coc-go',
      \'coc-highlight',
      \'coc-markdownlint',
      \'coc-omnisharp',
      \'coc-tsserver',
      \'coc-powershell',
      \'coc-html',
      \'coc-css',
      \'coc-prettier',
      \'coc-python',
      \'coc-jest', 
      \'coc-java', 
      \'coc-yank', 
      \'coc-eslint', 
      \'coc-json', 
      \'coc-yaml',
      \]

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <cr> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
" I don't like this very much. Commenting out
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
"                              \: "\<C-g>u\<cr>\<c-r>=coc#on_enter()\<cr>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<cr>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end


" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
" Note coc#float#scroll works on neovim >= 0.4.3 or vim >= 8.2.0750
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}


"     _             _               
" ___| |_ __ _ _ __| |_ _   _ _ __  
"/ __| __/ _` | '__| __| | | | '_ \ 
"\__ \ || (_| | |  | |_| |_| | |_) |
"|___/\__\__,_|_|   \__|\__,_| .__/ 
"                            |_|    

function! StartUp()
    " Start NERDTree if vim is started with a directory or no arguments
    if !argc() && !exists("s:std_in")
        NERDTree
    end
    if argc() && isdirectory(argv()[0]) && !exists("s:std_in")
        exe 'NERDTree' argv()[0]
        wincmd p
        ene
    end
endfunction

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * call StartUp()

