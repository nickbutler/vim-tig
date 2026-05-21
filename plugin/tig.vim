if has('nvim')
  if !exists('g:tig_executable')
    let g:tig_executable = 'tig'
  endif

  if !exists('g:tig_default_command')
    let g:tig_default_command = 'status'
  endif

  if !exists('g:tig_on_exit')
    let g:tig_on_exit = 'bw!'
  endif

  if !exists('g:tig_open_command')
    let g:tig_open_command = 'enew'
  endif

  function! s:tig(bang, ...)
    let s:callback = {}
    let current = expand('%')
    let s:altfile = expand('#')

    function! s:callback.on_exit(id, status, event)
      exec g:tig_on_exit
      if !empty(s:altfile)
        let @# = s:altfile
      endif
    endfunction

    function! s:tigopen(arg)
      call termopen(g:tig_executable . ' ' . a:arg, s:callback)
    endfunction

    let arg = ''
    if a:0 > 0
      let args = a:1
      let args = substitute(args, '%', current, '')
      let args = substitute(args, '+', '+' . line('.'), '')
      let arg .= ' ' . args
    endif
    if a:bang > 0
      let arg .= ' -- ' . current
    endif
    if len(arg) == 0
      let arg = g:tig_default_command
    endif

    exec g:tig_open_command
    call s:tigopen(arg)
    setlocal nonumber
    setlocal norelativenumber
    setlocal signcolumn=no
    setlocal filetype=tig
    let s:save_mouse = &mouse
    set mouse=
    autocmd BufLeave,BufWipeout <buffer> let &mouse = s:save_mouse
    autocmd BufEnter <buffer> set mouse= | startinsert
    startinsert
  endfunction

  command! -bang -nargs=? Tig call s:tig(<bang>0, <f-args>)
endif
