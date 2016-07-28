""
" Break line after commas
function! BreakLineCommas()
  let current_line = line('.')
  execute ':s/,/,\r/g'
  execute 'normal! v$'.current_line.'gg=='
endfunction

command! BreakLineCommas call BreakLineCommas()

