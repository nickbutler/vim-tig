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

  if !exists('g:tig_margin')
    let g:tig_margin = 5
  endif

  highlight default link TigFloat CursorLine
  highlight default link TigFloatBorder TigFloat

  function! s:tig_win_config()
    let hmargin = g:tig_margin
    let vmargin = g:tig_margin / 2
    return {
      \ 'relative': 'editor',
      \ 'width':    &columns - hmargin * 2,
      \ 'height':   &lines   - vmargin * 2,
      \ 'col':      hmargin,
      \ 'row':      vmargin,
      \ 'style':    'minimal',
      \ 'border':   'rounded',
      \ }
  endfunction

  function! s:tig_resize()
    if nvim_win_is_valid(s:tig_win)
      call nvim_win_set_config(s:tig_win, s:tig_win_config())
    endif
  endfunction

  function! s:tig(bang, ...)
    let s:callback = {}
    let current = expand('%')
    let s:altfile = expand('#')

    function! s:callback.on_exit(id, status, event)
      augroup TigResize
        autocmd!
      augroup END
      exec g:tig_on_exit
      if !empty(s:altfile)
        let @# = s:altfile
      endif
    endfunction

    function! s:tigopen(arg)
      call termopen(g:tig_executable . ' ' . a:arg, s:callback)
    endfunction

    let buf = nvim_create_buf(v:false, v:true)
    let s:tig_win = nvim_open_win(buf, v:true, s:tig_win_config())
    setlocal winhighlight=Normal:TigFloat,NormalFloat:TigFloat,FloatBorder:TigFloatBorder

    augroup TigResize
      autocmd!
      autocmd VimResized * call s:tig_resize()
    augroup END

    if a:bang > 0
      call s:tigopen(current)
    elseif a:0 > 0
      call s:tigopen(a:1)
    else
      call s:tigopen(g:tig_default_command)
    endif
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
