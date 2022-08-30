set background=dark
hi clear
if exists('syntax_on')
  syntax reset
endif
let g:colors_name='leet'

"--  leet
hi   Character                             guifg=#ff4400  guibg=none      gui=none
hi   Comment                               guifg=#555555  guibg=none      gui=none
hi   Constant                              guifg=#bbbb00  guibg=none      gui=none
hi   CursorLine                            guifg=none     guibg=#111111   gui=none
hi   CursorLineNr                          guifg=#cccccc  guibg=none      gui=none
hi   Directory                             guifg=#555555  guibg=none      gui=bold
hi   Error                                 guifg=#ff0000  guibg=none      gui=none
hi   ErrorMsg                              guifg=#ff0000  guibg=none      gui=none
hi   Folded                                guifg=none     guibg=#0000ff   gui=none
hi   FoldColumn                            guifg=none     guibg=#000000   gui=none
hi   Function                              guifg=#008800  guibg=none      gui=none
hi   Identifier                            guifg=#5e81ac  guibg=none      gui=none
hi   IncSearch                             guifg=#ffff00  guibg=#5555ff   gui=none
hi   Keyword                               guifg=#5555ff  guibg=none      gui=none
hi   LineNr                                guifg=#555555  guibg=none      gui=none
hi   MatchParen                            guifg=#ff0000  guibg=#ffff00   gui=none
hi   NonText                               guifg=#000000  guibg=none      gui=none
hi   Normal                                guifg=none     guibg=none      gui=none
hi   Operator                              guifg=#5555ff  guibg=none      gui=none
hi   Pmenu                                 guifg=#888888  guibg=none      gui=none
hi   PmenuSbar                             guifg=#880000  guibg=none      gui=none
hi   PmenuSel                              guifg=none     guibg=#1c1c1c   gui=none
hi   PmenuThumb                            guifg=none     guibg=#555555   gui=none
hi   PreProc                               guifg=#1c1cff  guibg=none      gui=none
hi   Search                                guifg=#5555ff  guibg=#ffff00   gui=none
hi   SignColumn                            guifg=#000000  guibg=#000000   gui=none
hi   Special                               guifg=#ff0000  guibg=none      gui=none
hi   SpecialChar                           guifg=#880000  guibg=none      gui=none
hi   Statement                             guifg=#5555ff  guibg=none      gui=bold
hi   StatusLine                            guifg=#1c1cff  guibg=none      gui=bold
hi   StatusLineNC                          guifg=#1c1cff  guibg=none      gui=none
hi   String                                guifg=#ffff00  guibg=none      gui=none
hi   Todo                                  guifg=#ff4400  guibg=none      gui=none
hi   Type                                  guifg=#880088  guibg=none      gui=none
hi   VertSplit                             guifg=#555555  guibg=#000000   gui=none
hi   visual                                guifg=none     guibg=#1c1c1c   gui=none
hi   WarningMsg                            guifg=#ff0000  guibg=none      gui=none
hi   WildMenu                              guifg=#ff0000  guibg=none      gui=none

"--  Treesitter
hi   TSAnnotation                          guifg=#008800  guibg=none      gui=none
hi   TSAttribute                           guifg=#ff8800  guibg=none      gui=none
hi   TSBoolean                             guifg=#ff0000  guibg=none      gui=none
hi   TSCharacter                           guifg=#ff4400  guibg=none      gui=none
hi   TSComment                             guifg=#555555  guibg=none      gui=none
hi   TSNote                                guifg=#ffff00  guibg=none      gui=none
hi   TSWarning                             guifg=#bbbb00  guibg=none      gui=none
hi   TSDanger                              guifg=#bb0000  guibg=none      gui=none
hi   TSConstructor                         guifg=#bb0000  guibg=none      gui=none
hi   TSConditional                         guifg=#5555ff  guibg=none      gui=none
hi   TSConstant                            guifg=#bbbb00  guibg=none      gui=none
hi   TSConstBuiltin                        guifg=#880000  guibg=none      gui=none
hi   TSConstMacro                          guifg=#ff4400  guibg=none      gui=none
hi   TSError                               guifg=#ff0000  guibg=none      gui=none
hi   TSException                           guifg=#bb0000  guibg=none      gui=none
hi   TSField                               guifg=#5e81ac  guibg=none      gui=none
hi   TSFloat                               guifg=#008888  guibg=none      gui=none
hi   TSFunction                            guifg=#008800  guibg=none      gui=none
hi   TSFuncBuiltin                         guifg=#ff0000  guibg=none      gui=none
hi   TSFuncMacro                           guifg=#1c1cff  guibg=none      gui=none
hi   TSInclude                             guifg=#bb0000  guibg=none      gui=none
hi   TSKeyword                             guifg=#5555ff  guibg=none      gui=none
hi   TSKeywordFunction                     guifg=#5555ff  guibg=none      gui=none
hi   TSLabel                               guifg=#5e81ac  guibg=none      gui=none
hi   TSMethod                              guifg=#bbbb00  guibg=none      gui=none
hi   TSNamespace                           guifg=#5555ff  guibg=none      gui=none
hi   TSNone                                guifg=#ff4400  guibg=none      gui=none
hi   TSNumber                              guifg=#bbbb00  guibg=none      gui=none
hi   TSOperator                            guifg=#5555ff  guibg=none      gui=none
hi   TSParameter                           guifg=#5e81ac  guibg=none      gui=none
hi   TSParameterReference                  guifg=#880088  guibg=none      gui=none
hi   TSProperty                            guifg=#7acaca  guibg=none      gui=none
hi   TSPunc                                guifg=#880000  guibg=none      gui=none
hi   TSPunctDelimiter                      guifg=#880000  guibg=none      gui=none
hi   TSPunctBracket                        guifg=#ff0000  guibg=none      gui=none
hi   TSPunctSpecial                        guifg=#ff0000  guibg=none      gui=none
hi   TSRepeat                              guifg=#5555ff  guibg=none      gui=none
hi   TSString                              guifg=#ffff00  guibg=none      gui=none
hi   TSStringRegex                         guifg=#008800  guibg=none      gui=none
hi   TSStringEscape                        guifg=#00ff00  guibg=none      gui=none
hi   TSSymbol                              guifg=#888888  guibg=none      gui=none
hi   TSType                                guifg=#880088  guibg=none      gui=none
hi   TSTypeBuiltin                         guifg=#5e81ac  guibg=none      gui=none
hi   TSVariable                            guifg=#cccccc  guibg=none      gui=none
hi   TSVariableBuiltin                     guifg=#ff0000  guibg=none      gui=none
hi   TSTag                                 guifg=#1c1cff  guibg=none      gui=none
hi   TSTagDelimiter                        guifg=#5555ff  guibg=none      gui=none
hi   TSText                                guifg=#ff0000  guibg=none      gui=none
hi   TSTextReference                       guifg=#ffffff  guibg=none      gui=none
hi   TSEmphasis                            guifg=#888888  guibg=none      gui=none
hi   TSUnderline                           guifg=none     guibg=none      gui=underline
hi   TSStrike                              guifg=none     guibg=none      gui=standout
hi   TSTitle                               guifg=#5555ff  guibg=none      gui=bold
hi   TSLiteral                             guifg=#008800  guibg=none      gui=bold
hi   TSURI                                 guifg=#7acaca  guibg=none      gui=bold

"--  LSP
hi   LspReferenceText                      guifg=none     guibg=#111111   gui=none
hi   LspReferenceRead                      guifg=none     guibg=#1c1c1c   gui=none
hi   LspReferenceWrite                     guifg=none     guibg=#222222   gui=none
hi   LspDiagnosticsDefaultError            guifg=#ff0000  guibg=none      gui=none
hi   LspDiagnosticsDefaultWarning          guifg=#ff4400  guibg=none      gui=none
hi   LspDiagnosticsDefaultInformation      guifg=#ff8800  guibg=none      gui=none
hi   LspDiagnosticsDefaultHint             guifg=#bbbb00  guibg=none      gui=none
hi   LspDiagnosticsVirtualTextError        guifg=#ff0000  guibg=none      gui=none
hi   LspDiagnosticsVirtualTextWarning      guifg=#ff4400  guibg=none      gui=none
hi   LspDiagnosticsVirtualTextInformation  guifg=#ff8800  guibg=none      gui=none
hi   LspDiagnosticsVirtualTextHint         guifg=#bbbb00  guibg=none      gui=none
hi   LspDiagnosticsUnderlineError          guifg=#ff0000  guibg=none      gui=none
hi   LspDiagnosticsUnderlineWarning        guifg=#ff4400  guibg=none      gui=none
hi   LspDiagnosticsUnderlineInformation    guifg=#ff8800  guibg=none      gui=none
hi   LspDiagnosticsUnderlineHint           guifg=#bbbb00  guibg=none      gui=none
hi   LspDiagnosticsFloatingError           guifg=#ff0000  guibg=none      gui=none
hi   LspDiagnosticsFloatingWarning         guifg=#ff4400  guibg=none      gui=none
hi   LspDiagnosticsFloatingInformation     guifg=#ff8800  guibg=none      gui=none
hi   LspDiagnosticsFloatingHint            guifg=#bbbb00  guibg=none      gui=none
hi   LspDiagnosticsSignError               guifg=#ff0000  guibg=none      gui=none
hi   LspDiagnosticsSignWarning             guifg=#ff4400  guibg=none      gui=none
hi   LspDiagnosticsSignInformation         guifg=#ff8800  guibg=none      gui=none
hi   LspDiagnosticsSignHint                guifg=#bbbb00  guibg=none      gui=none

"--  Diagnostics
hi   DiagnosticError                       guifg=#ff0000   guibg=none     gui=none
hi   DiagnosticWarn                        guifg=#ff4400   guibg=none     gui=none
hi   DiagnosticHint                        guifg=#ff8800   guibg=none     gui=none
hi   DiagnosticInfo                        guifg=#bbbb00   guibg=none     gui=none
hi   DiagnosticSignError                   guifg=#ff0000   guibg=none     gui=none
hi   DiagnosticSignWarn                    guifg=#ff4400   guibg=none     gui=none
hi   DiagnosticSignHint                    guifg=#ff8800   guibg=none     gui=none
hi   DiagnosticSignInfo                    guifg=#bbbb00   guibg=none     gui=none

"--  Diff
hi   DiffAdd                                guifg=#ffffff  guibg=#0000ff  gui=none
hi   DiffChange                             guifg=#888888  guibg=none     gui=underline
hi   DiffDelete                             guifg=#ffffff  guibg=#ff0000  gui=none
hi   DiffText                               guifg=#ffffff  guibg=#444444  gui=none

"--  git
hi   GitSignsAdd                           guifg=#005500   guibg=none     gui=none
hi   GitSignsChange                        guifg=#1c1cff   guibg=none     gui=none
hi   GitSignsDelete                        guifg=#880000   guibg=none     gui=none

"--  nvimtree
hi   NvimTreeStatusLine                    guifg=black     guibg=#000000  gui=none
hi   NvimTreeStatusLineNC                  guifg=black     guibg=#000000  gui=none
hi   NvimTreeCursorLine                    guifg=#2222ff   guibg=#000000  gui=none
hi   NvimTreeIndentMarker                  guifg=#495466   guibg=#000000  gui=none
hi   NvimTreeFolderIcon                    guifg=#727c8c   guibg=#000000  gui=none
hi   NvimTreeFolderName                    guifg=#727c8c   guibg=#000000  gui=none

"--  Cmp
hi   link CmpItemAbbr Pmenu
hi   link CmpItemAbbrMatch WildMenu
hi   link CmpItemAbbrMatchFuzzyDefault PmenuSbar
hi   link CmpItemMenu Comment

"-- Indentline
hi  IndentBlanklineChar                    guifg=#222222   guibg=#000000  gui=none
hi  IndentBlanklineSpaceChar               guifg=#b0b0b0   guibg=#000000  gui=none
hi  IndentBlanklineSpaceCharBlankline      guifg=#0000FF   guibg=#000000  gui=none
hi  IndentBlanklineContextChar             guifg=#444444   guibg=#000000  gui=none
hi  IndentBlanklineContextSpaceChar        guifg=#0000FF   guibg=#000000  gui=none
hi  IndentBlanklineContextStart            guifg=none      guibg=#1c1c1c  gui=none
