function! s:function(name) abort
  return function(substitute(a:name,'^s:',matchstr(expand('<sfile>'), '<SNR>\d\+_'),''))
endfunction

function! s:IsUsingTmux()
  call system('[ "$TERM" = "screen" ] && [ -n "$TMUX" ]')
  return !v:shell_error
endfunction

function! s:SwitchPane(direction)
  if a:direction ==# 'j'
    let fn = "s:DownCmp"
    let dr = 'D'
  elseif a:direction ==# 'k'
    let fn = "s:UpCmp"
    let dr = 'U'
  elseif a:direction ==# 'l'
    let fn = "s:RightCmp"
    let dr = 'R'
  elseif a:direction ==# 'h'
    let fn = "s:LeftCmp"
    let dr = 'L'
  endif
  if exists("fn") && s:IsUsingTmux() && s:IsEdge(s:function(fn))
    call system( 'tmux select-pane -'.dr )
  else
    execute "normal \<c-w>".a:direction
  endif
endfunction

function! s:IsEdge(fn)
  let tabnr = tabpagenr()
  let this_win = a:fn(winnr())
  for w in getwininfo()
    if w["tabnr"] != tabnr
      continue
    endif
    if a:fn(w["winnr"]) > this_win
      return 0
    endif
  endfor
  return 1
endfunction

function! s:DownCmp(winnr)
  return winheight(a:winnr) + win_screenpos(a:winnr)[0]
endfunction

function! s:UpCmp(winnr)
  return 0 - win_screenpos(a:winnr)[0]
endfunction

function! s:RightCmp(winnr)
  return winwidth(a:winnr) + win_screenpos(a:winnr)[1]
endfunction

function! s:LeftCmp(winnr)
  return 0 - win_screenpos(a:winnr)[1]
endfunction

nnoremap <silent> <c-j> :call <SID>SwitchPane('j')<cr>
nnoremap <silent> <c-h> :call <SID>SwitchPane('h')<cr>
nnoremap <silent> <c-k> :call <SID>SwitchPane('k')<cr>
nnoremap <silent> <c-l> :call <SID>SwitchPane('l')<cr>
