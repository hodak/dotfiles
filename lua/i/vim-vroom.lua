-- vim-vroom
vim.cmd [[
  let g:vroom_use_vimux = 1
  let g:VimuxOrientation = "v"
  let g:VimuxHeight = "40"
  if filereadable("bin/rspec")
    let g:vroom_spec_command = './bin/rspec --format=documentation'
  else
    let g:vroom_spec_command = 'rspec --format=documentation'
  endif
  let g:vroom_mix_test_command = 'elixir --sname mixtest -S mix test --color'
  let g:vroom_map_keys = 0
  map <leader>e :w\|:VroomRunNearestTest<cr>
  map <leader>r :w\|:VroomRunTestFile<cr>
]]
