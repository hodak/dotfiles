-- vim-colorschemes
vim.cmd [[
  if has('termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
  endif
  set background=dark

  let g:everforest_background='hard'
  let g:everforest_better_performance=1
  let g:everforest_transparent_background=0
  let g:everforest_colors_override = {'bg0': ['#242424', '234']}

  " colorscheme everforest

  colorscheme Tomorrow-Night " dark
  " colorscheme github " light (outdoor)
]]
