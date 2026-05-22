Vim Tig
=======
Love [Tig](https://github.com/jonas/tig)? Me too!  
Love Vim? OMG we're totes the same!  
So here's a simple plugin to make calling tig in vim easy peasy.  

Requirements
------------
Neovim. This plugin uses Neovim's built in terminal; therefore it will crash
and burn on classic Vim. Classic support may be added if either

1. enough people want it
2. I go back to classic Vim
3. someone else does it :)

Installation
------------
Use your favourite plugin manager.

Usage
-----
Simply run `:Tig`  
or bind a key to it, e.g.:
```
map <C-G> :Tig<Cr>
```

Pass tig commands:
```
:Tig show
```

Show commit log of current file:
```
:Tig!
```

Configuration
-------------
Tig executable: `let g:tig_executable = 'tig'`
Tig command to run: `let g:tig_default_command = 'status'`
Vim command to run on tig exit: `let g:tig_on_exit = 'bw!'`
Floating window margin (columns/rows): `let g:tig_margin = 5`

The floating window background defaults to the `CursorLine` highlight group. Override it by defining `TigFloat` in your config:
```vim
highlight TigFloat guibg=#1e1e1e
```

Contributing
------------
1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

Credits
-------
[Nick Butler](https://www.codeindulgence.com) <nick@codeindulgence.com>

Additional thanks to [Mizuchi](https://github.com/Mizuchi) for [vim-ranger](https://github.com/Mizuchi/vim-ranger/) which was used as a reference.
