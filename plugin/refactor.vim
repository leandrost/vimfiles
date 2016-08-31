""
" Break line after commas
function! BreakLineCommas()
  let current_line = line('.')
  execute ':s/,/,\r/g'
  execute 'normal! v$'.current_line.'gg=='
endfunction

function! ExecShouldClean()
  execute ':!should_clean -d %'
endfunction

command! BreakLineCommas call BreakLineCommas()
command! ShouldClean call ExecShouldClean()

