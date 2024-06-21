-- ctrlp.vim
vim.cmd [[
  let g:ctrlp_user_command    = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_use_caching     = 0
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }
  let g:ctrlp_map = '<leader>p'
  let g:ctrlp_cmd = 'CtrlP'
]]
