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
 " source $HOME/.config/nvim/plug-config/polyglot.vim
source $HOME/.config/nvim/vim-plug/plugins.vim
source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/keys/mappings.vim

if exists('g:vscode')
  " VS Code extension
  source $HOME/.config/nvim/vscode/settings.vim
  source $HOME/.config/nvim/plug-config/easymotion.vim
  source $HOME/.config/nvim/plug-config/highlightyank.vim
else

  "" Themes
  "source $HOME/.config/nvim/themes/onedark.vim
  "source $HOME/.config/nvim/themes/lunar.vim
  "source $HOME/.config/nvim/themes/nord.vim
  "source $HOME/.config/nvim/themes/colors-wal.vim
  "source $HOME/.config/nvim/themes/gruvbox.vim
  "source $HOME/.config/nvim/themes/airline.vim
  "source $HOME/.config/nvim/colors/leet.vim
  "source $HOME/.config/nvim/colors/leetsmyck.vim
  "source $HOME/.config/nvim/plug-config/treesitter.vim
  "source $HOME/.config/nvim/plug-config/barbar.vim
  source $HOME/.config/nvim/themes/lunar2.vim
  "luafile $HOME/.config/nvim/lua/barbar.lua
  "luafile $HOME/.config/nvim/lua/nvcodeline.lua
  luafile $HOME/.config/nvim/lua/lunarvimline.lua
  luafile $HOME/.config/nvim/lua/treesitter.lua
  luafile $HOME/.config/nvim/lua/tree.lua

  "" Plugins
  " source $HOME/.config/nvim/plug-config/fzf.vim
  " source $HOME/.config/nvim/plug-config/nvim-tree-config.vim
  source $HOME/.config/nvim/plug-config/floaterm.vim
  source $HOME/.config/nvim/plug-config/lsp-config.vim
  " source $HOME/.config/nvim/plug-config/cmp-config.vim
  " source $HOME/.config/nvim/plug-config/competabnine.vim
  " luafile $HOME/.config/nvim/lua/lsp/python-lsp.lua
  " luafile $HOME/.config/nvim/lua/lsp/bash-lsp.lua
  " luafile $HOME/.config/nvim/lua/lsp/lua-lsp.lua
  " luafile $HOME/.config/nvim/lua/lsp/javascript-lsp.lua
  " luafile $HOME/.config/nvim/lua/lsp/tsserver-lsp.lua
  " luafile $HOME/.config/nvim/lua/lsp/efm-lsp.lua
  " luafile $HOME/.config/nvim/lua/lsp/general-lsp.lua
  " luafile $HOME/.config/nvim/lua/competabnine.lua
  " luafile $HOME/.config/nvim/lua/compe-config.lua
  " luafile $HOME/.config/nvim/lua/lsp/eslint-lsp.lua
  " luafile $HOME/.config/nvim/lua/efmlangserver.lua
  luafile $HOME/.config/nvim/lua/cmp-config.lua
  luafile $HOME/.config/nvim/lua/cmptabnine.lua
  luafile $HOME/.config/nvim/lua/plug-colorizer.lua
  luafile $HOME/.config/nvim/lua/nvimlspinstaller.lua
endif

" lua require'lspconfig'.tsserver.setup{}
" lua require'lspconfig'.eslint.setup{}

