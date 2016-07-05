let g:sessions_dir = $HOME."/.vim/sessions/"
let g:default_session = "default"
let g:myfinance_session = "myfinance"

function! MakeSession(session_name)
  execute "mksession! ".g:sessions_dir.a:session_name.".vim"
endfunction

function! RecoverSession(session_name)
  let session_file = g:sessions_dir.a:session_name.".vim"
  if filereadable(session_file)
    execute "source ".session_file
    call HideBackground()
  end
endfunction

function! SaveSession()
  if !isdirectory(g:sessions_dir)
    call mkdir(g:sessions_dir)
  endif
  if getcwd() == $HOME."/projects/myfinance/src"
    call MakeSession(g:myfinance_session)
  else
    call MakeSession(g:default_session)
  endif
endfunction

function! LoadSession()
  if argc() == 0
    let myfinance_path = $HOME."/projects/myfinance/src"
    let session_name = getcwd() == myfinance_path ? g:myfinance_session : g:default_session
    call RecoverSession(session_name)
  endif
endfunction

autocmd VimLeave * nested call SaveSession()
autocmd VimEnter * nested call LoadSession()

command! -nargs=1 SaveSession call MakeSession(<f-args>)
command! -nargs=1 LoadSession call RecoverSession(<f-args>)
