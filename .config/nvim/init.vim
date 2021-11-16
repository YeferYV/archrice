"    ____      _ __        _
"   /  _/___  (_) /__   __(_)___ ___
"   / // __ \/ / __/ | / / / __ `__ \
" _/ // / / / / /__| |/ / / / / / / /
"/___/_/ /_/_/\__(_)___/_/_/ /_/ /_/


" if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
"   echo "Downloading junegunn/vim-plug to manage plugins..."
"   silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
"   silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
"   autocmd VimEnter * PlugInstall
" endif

 " source $HOME/.config/nvim/general/functions.vim
source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/keys/mappings.vim
source $HOME/.config/nvim/vim-plug/plugins.vim

if exists('g:vscode')
  " VS Code extension
  source $HOME/.config/nvim/vscode/settings.vim
  source $HOME/.config/nvim/vim-config/easymotion.vim
  source $HOME/.config/nvim/vim-config/highlightyank.vim
else

  "" Lua
  " luafile $HOME/.config/nvim/lua/lsp/bash-lsp.lua
  " luafile $HOME/.config/nvim/lua/lsp/efm-lsp.lua
  " luafile $HOME/.config/nvim/lua/lsp/efmlangserver.lua
  " luafile $HOME/.config/nvim/lua/lsp/eslint-lsp.lua
  " luafile $HOME/.config/nvim/lua/lsp/general-lsp.lua
  " luafile $HOME/.config/nvim/lua/lsp/javascript-lsp.lua
  " luafile $HOME/.config/nvim/lua/lsp/lua-lsp.lua
  " luafile $HOME/.config/nvim/lua/lsp/python-lsp.lua
  " luafile $HOME/.config/nvim/lua/lsp/tsserver-lsp.lua
  luafile $HOME/.config/nvim/lua/barbar-conf.lua
  luafile $HOME/.config/nvim/lua/cmp-conf.lua
  " luafile $HOME/.config/nvim/lua/cmp-ultisnip.lua
  luafile $HOME/.config/nvim/lua/cmptabnine.lua
  " luafile $HOME/.config/nvim/lua/completion.lua
  luafile $HOME/.config/nvim/lua/lsp.lua
  luafile $HOME/.config/nvim/lua/lspinstaller.lua
  luafile $HOME/.config/nvim/lua/lspkind-conf.lua
  luafile $HOME/.config/nvim/lua/lspsaga-conf.lua
  luafile $HOME/.config/nvim/lua/lunarvimline.lua
  luafile $HOME/.config/nvim/lua/nvimcolorizer.lua
  luafile $HOME/.config/nvim/lua/nvimtree.lua
  " luafile $HOME/.config/nvim/lua/plugins.lua
  luafile $HOME/.config/nvim/lua/tree.lua
  luafile $HOME/.config/nvim/lua/treesitter-playground.lua
  luafile $HOME/.config/nvim/lua/treesitter.lua

  "" Themes
  " source $HOME/.config/nvim/themes/gruvbox.vim
  " source $HOME/.config/nvim/themes/leet.vim
  " source $HOME/.config/nvim/themes/leetsmyck.vim
  " source $HOME/.config/nvim/themes/lunar.vim
  source $HOME/.config/nvim/themes/lunar2-generated.vim
  source $HOME/.config/nvim/themes/lunar2.vim
  " source $HOME/.config/nvim/themes/nord.vim
  " source $HOME/.config/nvim/themes/onedark.vim

  "" Vim-config
  source $HOME/.config/nvim/vim-config/floaterm.vim
  source $HOME/.config/nvim/vim-config/lsp-config.vim
  " source $HOME/.config/nvim/vim-config/signify.vim
  source $HOME/.config/nvim/vim-config/telescope.vim
  " source $HOME/.config/nvim/vim-config/ultisnips.vim

endif

