function! RunRspec(args)
  let args = ''
  if a:args != ''
    let args .= ':'.a:args
  end
  if a:args == '-'
    let cmd = g:last_rspec
  else
    let cmd = "rspec ".expand("%").args
  end
  execute 'silent execute "!echo ".cmd." > /dev/pts/2" | redraw!'
  execute 'silent execute "!".cmd." > /dev/pts/2" | redraw!'
  let g:last_rspec = cmd
endfunction

function! GetSpecPath()
  let s = expand('%')

  if stridx(s, 'app/') >= 0
    let s = substitute(s, 'app/', 'spec/', '')
    let s = substitute(s, '.rb', '_spec.rb', '')
  endif

  return s
endfunction

function! GetJsSpecPath()
  let s = expand('%')
  return s
endfunction

