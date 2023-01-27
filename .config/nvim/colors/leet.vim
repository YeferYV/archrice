set background=dark
hi clear
if exists('syntax_on')
  syntax reset
endif
let g:colors_name='leet'

"--  leet
hi   Boolean                               guifg=#1cff1c  guibg=none     gui=none
hi   Character                             guifg=#ff4400  guibg=none     gui=none
hi   ColorColumn                           guifg=none     guibg=none     gui=none
hi   Comment                               guifg=#5c5c5c  guibg=none     gui=none
hi   Conceal                               guifg=none     guibg=none     gui=none
hi   Conditional                           guifg=#5555ff  guibg=none     gui=none
hi   Constant                              guifg=#bbbb00  guibg=none     gui=none
hi   Cursor                                guifg=#000000  guibg=#1c1cff  gui=none
hi   CursorColumn                          guifg=none     guibg=none     gui=none
hi   CursorLine                            guifg=none     guibg=#0c0c0c  gui=none
hi   CursorLineFold                        guifg=#444444  guibg=none     gui=none
hi   CursorLineNr                          guifg=#cccccc  guibg=none     gui=none
hi   CursorLineSign                        guifg=none     guibg=none     gui=none
hi   CurSearch                             guifg=#ffff00  guibg=#5555ff  gui=none
hi   Debug                                 guifg=#ff4400  guibg=none     gui=none
hi   Define                                guifg=#1c1cff  guibg=none     gui=none
hi   Delimiter                             guifg=#7574a5  guibg=none     gui=none
hi   Directory                             guifg=#555555  guibg=none     gui=bold
hi   Error                                 guifg=#ff0000  guibg=none     gui=none
hi   ErrorMsg                              guifg=#ff0000  guibg=none     gui=none
hi   Exception                             guifg=#bb0000  guibg=none     gui=none
hi   ExtraWhitespace                       guifg=none     guibg=#ff0000  gui=none
hi   Float                                 guifg=#008888  guibg=none     gui=none
hi   FloatBorder                           guifg=#444444  guibg=none     gui=none
hi   FoldColumn                            guifg=none     guibg=none     gui=none
hi   Folded                                guifg=none     guibg=#444444  gui=none
hi   Function                              guifg=#008800  guibg=none     gui=none
hi   Identifier                            guifg=#5e81ac  guibg=none     gui=none
hi   Ignore                                guifg=none     guibg=none     gui=bold
hi   Include                               guifg=#4141ad  guibg=none     gui=bold
hi   IncSearch                             guifg=#ffff00  guibg=#5555ff  gui=none
hi   Keyword                               guifg=#5555ff  guibg=none     gui=bold
hi   Label                                 guifg=#5e81ac  guibg=none     gui=none
hi   LineNr                                guifg=#555555  guibg=none     gui=none
hi   Macro                                 guifg=#1c1cff  guibg=none     gui=none
hi   MatchParen                            guifg=#000000  guibg=#1cff1c  gui=none
hi   NonText                               guifg=#000000  guibg=none     gui=none
hi   Normal                                guifg=none     guibg=none     gui=none
hi   NormalFloat                           guifg=#888888  guibg=none     gui=none
hi   Number                                guifg=#1cff1c  guibg=none     gui=none
hi   Operator                              guifg=#5555ff  guibg=none     gui=none
hi   Pmenu                                 guifg=#444444  guibg=none     gui=none
hi   PmenuSbar                             guifg=#ff0000  guibg=none     gui=none
hi   PmenuSel                              guifg=none     guibg=#1c1c1c  gui=none
hi   PmenuThumb                            guifg=#0000ff  guibg=#1c1c1c  gui=none
hi   PreProc                               guifg=#1c1cff  guibg=none     gui=none
hi   Question                              guifg=#00ff00  guibg=none     gui=none
hi   QuickFixLine                          guifg=#00ff00  guibg=none     gui=none
hi   Repeat                                guifg=#5555ff  guibg=none     gui=none
hi   Search                                guifg=#5555ff  guibg=#ffff00  gui=none
hi   SignColumn                            guifg=none     guibg=none     gui=none
hi   Special                               guifg=#7574a5  guibg=none     gui=none
hi   SpecialChar                           guifg=#7574a5  guibg=none     gui=none
hi   SpecialKey                            guifg=#008888  guibg=none     gui=none
hi   SpecialComment                        guifg=#555555  guibg=#5555ff  gui=none
hi   Statement                             guifg=#5555ff  guibg=none     gui=bold
hi   StatusLine                            guifg=#1c1cff  guibg=none     gui=bold
hi   StatusLineNC                          guifg=#1c1cff  guibg=none     gui=none
hi   StorageClass                          guifg=#880088  guibg=none     gui=none
hi   String                                guifg=#ffff00  guibg=none     gui=none
hi   Structure                             guifg=#880088  guibg=none     gui=none
hi   Substitute                            guifg=#5555ff  guibg=#ffff00  gui=none
hi   Tag                                   guifg=#515171  guibg=none     gui=none
hi   TermCursor                            guifg=#000000  guibg=#ffffff  gui=NONE
hi   TermCursorNC                          guifg=#ffffff  guibg=#3c3c3c  gui=NONE
hi   Title                                 guifg=#5555ff  guibg=none     gui=bold
hi   Todo                                  guifg=#ff4400  guibg=none     gui=none
hi   Type                                  guifg=#880088  guibg=none     gui=none
hi   Typedef                               guifg=#5e81ac  guibg=none     gui=none
hi   Underlined                            guifg=none     guibg=none     gui=underline
hi   VertSplit                             guifg=#555555  guibg=none     gui=none
hi   visual                                guifg=none     guibg=#1c1c1c  gui=none
hi   WarningMsg                            guifg=#ff0000  guibg=none     gui=none
hi   WildMenu                              guifg=#ff0000  guibg=none     gui=none
hi   WinBar                                guifg=#495466  guibg=none     gui=none
hi   WinBarNC                              guifg=#495466  guibg=none     gui=none

"--  Treesitter
hi   link @boolean                         Boolean
hi   link @character                       Character
hi   link @character.special               SpecialChar
hi   link @comment                         Comment
hi   link @conditional                     Conditional
hi   link @constant                        Constant
hi   link @constant.builtin                TSConstBuiltin              " Special
hi   link @constant.macro                  TSConstMacro                " Define
hi   link @constructor                     TSConstructor               " Special
hi   link @debug                           Debug
hi   link @define                          Define
hi   link @exception                       Exception
hi   link @field                           TSField                     " Identifier
hi   link @float                           Float
hi   link @function                        Function
hi   link @function.builtin                TSFuncBuiltin               " Special
hi   link @function.macro                  TSFuncMacro                 " Macro
hi   link @include                         Include
hi   link @keyword                         Keyword
hi   link @keyword.function                TSKeywordFunction
hi   link @keyword.operator                TSKeywordOperator
hi   link @keyword.return                  TSKeywordReturn
hi   link @label                           Label
hi   link @macro                           Macro
hi   link @method                          TSMethod                    " Function
hi   link @namespace                       TSNamespace                 " Identifier
hi   link @number                          Number
hi   link @operator                        Operator
hi   link @parameter                       TSParameter                 " Identifier
hi   link @parameter.reference             TSParameterReference
hi   link @preproc                         Preproc
hi   link @property                        TSProperty                  " Identifier
hi   link @punctuation                     TSPunc                      " Delimiter
hi   link @punctuation.bracket             TSPunctBracket
hi   link @punctuation.delimiter           TSPunctDelimiter
hi   link @punctuation.special             TSPunctSpecial
hi   link @repeat                          Repeat
hi   link @storageclass                    StorageClass
hi   link @string                          String
hi   link @string.escape                   TSStringEscape              " SpecialChar
hi   link @string.special                  TSStringRegex               " SpecialChar
hi   link @structure                       Structure
hi   link @symbol                          TSSymbol
hi   link @tag                             Tag
hi   link @tag.attribute                   TSAttribute
hi   link @tag.delimiter                   TSTagDelimiter
hi   link @text.literal                    TSLiteral                   " Comment
hi   link @text.reference                  TSTextReference             " Identifier
hi   link @text.title                      Title
hi   link @text.todo                       Todo
hi   link @text.underline                  Underlined
hi   link @text.uri                        TSURI                       " Underined
hi   link @type                            Type
hi   link @type.builtin                    TSTypeBuiltin
hi   link @type.definition                 Typedef
hi   link @variable                        TSVariable                  " Identifier
hi   link @variable.builtin                TSVariableBuiltin

hi   TSAnnotation                          guifg=#008800  guibg=none     gui=none
hi   TSAttribute                           guifg=#87a1c5  guibg=none     gui=none
hi   TSBoolean                             guifg=#1cff1c  guibg=none     gui=none
hi   TSCharacter                           guifg=#ff4400  guibg=none     gui=none
hi   TSComment                             guifg=#555555  guibg=none     gui=none
hi   TSConditional                         guifg=#5555ff  guibg=none     gui=none
hi   TSConstBuiltin                        guifg=#1cff1c  guibg=none     gui=none
hi   TSConstMacro                          guifg=#ff4400  guibg=none     gui=none
hi   TSConstant                            guifg=#bbbb00  guibg=none     gui=none
hi   TSConstructor                         guifg=#515171  guibg=none     gui=none
hi   TSDanger                              guifg=#bb0000  guibg=none     gui=none
hi   TSEmphasis                            guifg=#888888  guibg=none     gui=none
hi   TSError                               guifg=#ff0000  guibg=none     gui=none
hi   TSException                           guifg=#bb0000  guibg=none     gui=none
hi   TSField                               guifg=#5e81ac  guibg=none     gui=none
hi   TSFloat                               guifg=#008888  guibg=none     gui=none
hi   TSFuncBuiltin                         guifg=#5c5cff  guibg=none     gui=bold
hi   TSFuncMacro                           guifg=#1c1cff  guibg=none     gui=none
hi   TSFunction                            guifg=#008800  guibg=none     gui=none
hi   TSInclude                             guifg=#4141ad  guibg=none     gui=bold
hi   TSKeyword                             guifg=#4141ad  guibg=none     gui=none
hi   TSKeywordFunction                     guifg=#5555ff  guibg=none     gui=none
hi   TSKeywordOperator                     guifg=#5555ff  guibg=none     gui=none
hi   TSKeywordReturn                       guifg=#5555ff  guibg=none     gui=none
hi   TSLabel                               guifg=#5e81ac  guibg=none     gui=none
hi   TSLiteral                             guifg=#008800  guibg=none     gui=bold
hi   TSMethod                              guifg=#7574a5  guibg=none     gui=none
hi   TSNamespace                           guifg=#5555ff  guibg=none     gui=none
hi   TSNone                                guifg=#bbbbbb  guibg=none     gui=none
hi   TSNote                                guifg=#ffff00  guibg=none     gui=none
hi   TSNumber                              guifg=#1cff1c  guibg=none     gui=none
hi   TSOperator                            guifg=#5555ff  guibg=none     gui=none
hi   TSParameter                           guifg=#bbbbbb  guibg=none     gui=none
hi   TSParameterReference                  guifg=#880088  guibg=none     gui=none
hi   TSProperty                            guifg=#87a1c5  guibg=none     gui=none
hi   TSPunc                                guifg=#e8e8e8  guibg=none     gui=none
hi   TSPunctBracket                        guifg=#515171  guibg=none     gui=none
hi   TSPunctDelimiter                      guifg=#e8e8e8  guibg=none     gui=none
hi   TSPunctSpecial                        guifg=#515171  guibg=none     gui=none
hi   TSRepeat                              guifg=#5555ff  guibg=none     gui=none
hi   TSStrike                              guifg=none     guibg=none     gui=standout
hi   TSString                              guifg=#ffff00  guibg=none     gui=none
hi   TSStringEscape                        guifg=#00ff00  guibg=none     gui=none
hi   TSStringRegex                         guifg=#008800  guibg=none     gui=none
hi   TSSymbol                              guifg=#888888  guibg=none     gui=none
hi   TSTag                                 guifg=#515171  guibg=none     gui=none
hi   TSTagDelimiter                        guifg=#515171  guibg=none     gui=none
hi   TSText                                guifg=#ff0000  guibg=none     gui=none
hi   TSTextReference                       guifg=#ffffff  guibg=none     gui=none
hi   TSTitle                               guifg=#5555ff  guibg=none     gui=bold
hi   TSType                                guifg=#880088  guibg=none     gui=none
hi   TSTypeBuiltin                         guifg=#5e81ac  guibg=none     gui=none
hi   TSURI                                 guifg=#87a1c5  guibg=none     gui=bold
hi   TSUnderline                           guifg=none     guibg=none     gui=underline
hi   TSVariable                            guifg=#bbbbbb  guibg=none     gui=none
hi   TSVariableBuiltin                     guifg=#515171  guibg=none     gui=none
hi   TSWarning                             guifg=#bbbb00  guibg=none     gui=none

"--  LSP
hi   LspReferenceText                      guifg=none     guibg=#111111  gui=none
hi   LspReferenceRead                      guifg=none     guibg=#1c1c1c  gui=none
hi   LspReferenceWrite                     guifg=none     guibg=#222222  gui=none
hi   LspDiagnosticsDefaultError            guifg=#ff0000  guibg=none     gui=none
hi   LspDiagnosticsDefaultWarning          guifg=#ff4400  guibg=none     gui=none
hi   LspDiagnosticsDefaultInformation      guifg=#ff8800  guibg=none     gui=none
hi   LspDiagnosticsDefaultHint             guifg=#bbbb00  guibg=none     gui=none
hi   LspDiagnosticsVirtualTextError        guifg=#ff0000  guibg=none     gui=none
hi   LspDiagnosticsVirtualTextWarning      guifg=#ff4400  guibg=none     gui=none
hi   LspDiagnosticsVirtualTextInformation  guifg=#ff8800  guibg=none     gui=none
hi   LspDiagnosticsVirtualTextHint         guifg=#bbbb00  guibg=none     gui=none
hi   LspDiagnosticsUnderlineError          guifg=#ff0000  guibg=none     gui=none
hi   LspDiagnosticsUnderlineWarning        guifg=#ff4400  guibg=none     gui=none
hi   LspDiagnosticsUnderlineInformation    guifg=#ff8800  guibg=none     gui=none
hi   LspDiagnosticsUnderlineHint           guifg=#bbbb00  guibg=none     gui=none
hi   LspDiagnosticsFloatingError           guifg=#ff0000  guibg=none     gui=none
hi   LspDiagnosticsFloatingWarning         guifg=#ff4400  guibg=none     gui=none
hi   LspDiagnosticsFloatingInformation     guifg=#ff8800  guibg=none     gui=none
hi   LspDiagnosticsFloatingHint            guifg=#bbbb00  guibg=none     gui=none
hi   LspDiagnosticsSignError               guifg=#ff0000  guibg=none     gui=none
hi   LspDiagnosticsSignWarning             guifg=#ff4400  guibg=none     gui=none
hi   LspDiagnosticsSignInformation         guifg=#ff8800  guibg=none     gui=none
hi   LspDiagnosticsSignHint                guifg=#bbbb00  guibg=none     gui=none

"--  Diagnostics
hi   DiagnosticError                       guifg=#ff0000  guibg=none     gui=none
hi   DiagnosticWarn                        guifg=#ff4400  guibg=none     gui=none
hi   DiagnosticHint                        guifg=#ff8800  guibg=none     gui=none
hi   DiagnosticInfo                        guifg=#bbbb00  guibg=none     gui=none
hi   DiagnosticSignError                   guifg=#ff0000  guibg=none     gui=none
hi   DiagnosticSignWarn                    guifg=#ff4400  guibg=none     gui=none
hi   DiagnosticSignHint                    guifg=#ff8800  guibg=none     gui=none
hi   DiagnosticSignInfo                    guifg=#bbbb00  guibg=none     gui=none

"--  Diff
hi   DiffAdd                               guifg=#ffffff  guibg=#00cc00  gui=none
hi   DiffChange                            guifg=#888888  guibg=none     gui=underline
hi   DiffDelete                            guifg=#ffffff  guibg=#ff0000  gui=none
hi   DiffText                              guifg=#ffffff  guibg=#0000ff  gui=none

"--  Bufferline
hi   BufferLineFill                        guifg=none     guibg=none  gui=none
hi   BufferLineBackground                  guifg=#616161  guibg=none  gui=none
hi   BufferLineBuffer                      guifg=none     guibg=none  gui=none
hi   BufferLineBufferSelected              guifg=#ffffff  guibg=none  gui=none
hi   BufferLineBufferVisible               guifg=#a1a1ad  guibg=none  gui=none
hi   BufferLineCloseButton                 guifg=#616161  guibg=none  gui=none
hi   BufferLineCloseButtonSelected         guifg=#ffffff  guibg=none  gui=none
hi   BufferLineCloseButtonVisible          guifg=#a1a1ad  guibg=none  gui=none
hi   BufferLineTab                         guifg=#616161  guibg=none  gui=none
hi   BufferLineTabClose                    guifg=#616161  guibg=none  gui=none
hi   BufferLineTabSelected                 guifg=#ffffff  guibg=none  gui=none
hi   BufferLineTabSeparator                guifg=#000000  guibg=none  gui=none
hi   BufferLineTabSeparatorSelected        guifg=#000000  guibg=none  gui=none
hi   BufferLineDupllicate                  guifg=#616161  guibg=none  gui=underline
hi   BufferLineDupllicateSelected          guifg=#ffffff  guibg=none  gui=underline
hi   BufferLineDupllicateVisible           guifg=#a1a1ad  guibg=none  gui=underline
hi   BufferLineModified                    guifg=#616161  guibg=none  gui=none
hi   BufferLineModifiedSelected            guifg=#ffffff  guibg=none  gui=none
hi   BufferLineModifiedVisible             guifg=#a1a1ad  guibg=none  gui=none
hi   BufferLineSeparator                   guifg=#5c5c5c  guibg=none  gui=none
hi   BufferLineSeparatorSelected           guifg=#5c5c5c  guibg=none  gui=none
hi   BufferLineSeparatorVisible            guifg=#5c5c5c  guibg=none  gui=none
hi   BufferLineIndicatorSelected           guifg=#ffffff  guibg=none  gui=none
hi   BufferLineIndicatorVisible            guifg=#5c5c5c  guibg=none  gui=none

"--  Borders
" hi   link TelescopeBorder                  FloatBorder  " default Normal
" hi   link DapUIFloatBorder                 FloatBorder  " default Normal
hi   link LspInfoBorder                    FloatBorder
hi   link WhichKeyBorder                   FloatBorder
hi   link SagaBorder                       FloatBorder
hi   link SagaNormal                       Normal
hi   link TerminalBorder                   FloatBorder
hi   link TerminalNormal                   Normal

"--  Cmp
hi   link CmpItemAbbr                      NormalFloat
hi   link CmpItemAbbrMatch                 WildMenu       " guifg=#4141ad
hi   link CmpItemAbbrMatchFuzzyDefault     PmenuThumb
hi   link CmpItemKind                      PmenuSbar      " guifg=#7574a5
hi   link CmpItemMenu                      Pmenu
hi   link CmpItemMenuDefault               FloatBorder

"--  git
hi   GitSignsAdd                           guifg=#005500  guibg=none     gui=none
hi   GitSignsChange                        guifg=#1c1cff  guibg=none     gui=none
hi   GitSignsDelete                        guifg=#880000  guibg=none     gui=none

"--  Illuminate
hi   def IlluminatedWordText               guifg=none     guibg=#080811  gui=none
hi   def IlluminatedWordRead               guifg=none     guibg=#080811  gui=none
hi   def IlluminatedWordWrite              guifg=none     guibg=#080811  gui=none

"--  Indentline
hi   IndentBlanklineChar                   guifg=#222222  guibg=none     gui=none
hi   IndentBlanklineSpaceChar              guifg=#b0b0b0  guibg=none     gui=none
hi   IndentBlanklineSpaceCharBlankline     guifg=#0000FF  guibg=none     gui=none
hi   IndentBlanklineContextChar            guifg=#444444  guibg=none     gui=none
hi   IndentBlanklineContextSpaceChar       guifg=#0000FF  guibg=none     gui=none
hi   IndentBlanklineContextStart           guifg=none     guibg=none     gui=none

"--  nvimtree
hi   NvimTreeCursorLine                    guifg=none     guibg=#111111  gui=none
hi   NvimTreeExecFile                      guifg=#00ff00  guibg=none     gui=bold
hi   NvimTreeFolderIcon                    guifg=#727c8c  guibg=none     gui=none
hi   NvimTreeFolderName                    guifg=#727c8c  guibg=none     gui=none
hi   NvimTreeGitNew                        guifg=#495466  guibg=none     gui=none
hi   NvimTreeIndentMarker                  guifg=#495466  guibg=none     gui=none
hi   NvimTreeImageFile                     guifg=#495499  guibg=none     gui=none
hi   NvimTreeRootFolder                    guifg=#495466  guibg=none     gui=bold
hi   NvimTreeSpecialFile                   guifg=#b2b2b2  guibg=none     gui=none
hi   NvimTreeStatusLine                    guifg=none     guibg=none     gui=none

"--  neo-tree
hi   NeoTreeBufferNumber                   guifg=#555555  guibg=none     gui=none
hi   NeoTreeCursorLine                     guifg=none     guibg=#1c1c1c  gui=none
hi   NeoTreeDimText                        guifg=#505050  guibg=none     gui=none
hi   NeoTreeDirectoryIcon                  guifg=#727c8c  guibg=none     gui=none
hi   NeoTreeDirectoryName                  guifg=#727c8c  guibg=none     gui=none
hi   NeoTreeDotfile                        guifg=#626262  guibg=none     gui=none
hi   NeoTreeFileIcon                       guifg=#b2b2b2  guibg=none     gui=none
hi   NeoTreeFileName                       guifg=#b2b2b2  guibg=none     gui=none
hi   NeoTreeFileNameOpened                 guifg=#b2b2b2  guibg=none     gui=none
hi   NeoTreeGitAdded                       guifg=#495466  guibg=none     gui=none
hi   NeoTreeGitConflict                    guifg=#495466  guibg=none     gui=none
hi   NeoTreeGitDeleted                     guifg=#495466  guibg=none     gui=none
hi   NeoTreeGitIgnored                     guifg=#495466  guibg=none     gui=none
hi   NeoTreeGitModified                    guifg=#495466  guibg=none     gui=none
hi   NeoTreeGitUnstaged                    guifg=#495466  guibg=none     gui=none
hi   NeoTreeGitUntracked                   guifg=#495466  guibg=none     gui=none
hi   NeoTreeGitStaged                      guifg=#495466  guibg=none     gui=none
hi   NeoTreeHiddenByName                   guifg=#626262  guibg=none     gui=none
hi   NeoTreeIndentMarker                   guifg=#222222  guibg=none     gui=none
hi   NeoTreeExpander                       guifg=#727c8c  guibg=none     gui=none
hi   NeoTreeRootName                       guifg=#495466  guibg=none     gui=bold
hi   NvimTreeRootFolder                    guifg=#495466  guibg=none     gui=bold
hi   NeoTreeTabInactive                    guifg=#888888  guibg=#1c1c1c  gui=none
hi   NeoTreeTabSeparatorInactive           guifg=#101010  guibg=#1c1c1c  gui=none
hi   NeoTreeTabSeparatorActive             guifg=#101010  guibg=none     gui=none
" hi link  NeoTreeNormal                   Normal
" hi link  NeoTreeNormalNC                 NormalNC
" hi link  NeoTreeSignColumn               SignColumn
" hi link  NeoTreeStatusLine               StatusLine
" hi link  NeoTreeStatusLineNC             StatusLineNC
" hi link  NeoTreeVertSplit                VertSplit
" hi link  NeoTreeWinSeparator             WinSeparator
" hi link  NeoTreeEndOfBuffer              EndOfBuffer
" hi link  NeoTreeFilterTerm               SpecialChar
" hi link  NeoTreeFloatBorder              FloatBorder
" hi link  NeoTreeFloatTitle               FloatBorder
" hi link  NeoTreeTitleBar                 FloatBorder
" hi link  NeoTreeSymbolicLinkTarget       NeoTreeFileName
" hi link  NeoTreeWindowsHidden            NeoTreeDotfile

"--  Sneak
hi   Sneak                                 guifg=#ff0000  guibg=#000000  gui=none
hi   SneakScope                            guifg=#000000  guibg=#1c1cff  gui=none

"--  Lspsaga
lua << EOF
local highlights = {
  -- code action
  LspSagaCodeActionTitle        = { fg   = '#da8548', bg = 'none',    bold = true },
  LspSagaCodeActionBorder       = { link = 'FloatBorder'                          },
  LspSagaCodeActionTrunCateLine = { link = 'SpecialKey'                           },
  LspSagaCodeActionContent      = { fg   = '#98be65', bg = 'none',    bold = true },
  -- finder
  LspSagaLspFinderBorder        = { link = 'FloatBorder'                          },
  LspSagaAutoPreview            = { fg   = '#51afef', bg = 'none',                },
  LspSagaFinderSelection        = { fg   = '#89d957', bg = 'none',    bold = true },
  TargetFileName                = { fg   = '#d1d4cf', bg = 'none',                },
  FinderParam                   = { fg   = '#CBA6F7', bg = '#392a52', bold = true },
  FinderVirtText                = { fg   = '#c95942', bg = 'none',                },
  DefinitionsIcon               = { fg   = '#e3e346', bg = 'none',                },
  Definitions                   = { fg   = '#CBA6F7', bg = 'none',    bold = true },
  DefinitionCount               = { link = 'Title'                                },
  ReferencesIcon                = { fg   = '#e3e346', bg = 'none',                },
  References                    = { fg   = '#CBA6F7', bg = 'none',    bold = true },
  ReferencesCount               = { link = 'Title'                                },
  ImplementsIcon                = { fg   = '#e3e346', bg = 'none',                },
  Implements                    = { fg   = '#CBA6F7', bg = 'none',    bold = true },
  ImplementsCount               = { link = 'Title'                                },
  -- finder spinner
  FinderSpinnerBorder           = { link = 'FloatBorder'                          },
  FinderSpinnerTitle            = { fg   = '#1c1cff', bg = 'none',    bold = true },
  FinderSpinner                 = { fg   = '#1c1cff', bg = 'none',    bold = true },
  FinderPreviewSearch           = { link = 'Search'                               },
  -- definition
  DefinitionBorder              = { link = 'FloatBorder'                          },
  DefinitionArrow               = { link = 'PmenuSel'                             },
  DefinitionSearch              = { link = 'Search'                               },
  DefinitionFile                = { link = 'PmenuSel'                             },
  -- hover
  LspSagaHoverBorder            = { link = 'FloatBorder'                          },
  LspSagaHoverTrunCateLine      = { link = 'SpecialKey'                           },
  -- rename
  LspSagaRenameBorder           = { link = 'FloatBorder'                          },
  LspSagaRenameMatch            = { link = 'Search'                               },
  -- diagnostic
  LspSagaDiagnosticSource       = { link = 'Comment'                              },
  LspSagaDiagnosticError        = { link = 'DiagnosticError'                      },
  LspSagaDiagnosticWarn         = { link = 'DiagnosticWarn'                       },
  LspSagaDiagnosticInfo         = { link = 'DiagnosticInfo'                       },
  LspSagaDiagnosticHint         = { link = 'DiagnosticHint'                       },
  LspSagaErrorTrunCateLine      = { link = 'DiagnosticError'                      },
  LspSagaWarnTrunCateLine       = { link = 'DiagnosticWarn'                       },
  LspSagaInfoTrunCateLine       = { link = 'DiagnosticInfo'                       },
  LspSagaHintTrunCateLine       = { link = 'DiagnosticHint'                       },
  LspSagaDiagnosticBorder       = { link = 'FloatBorder'                          },
  LspSagaDiagnosticHeader       = { fg   = '#afd700', bg = 'none',                },
  DiagnosticQuickFix            = { fg   = '#4dd158', bg = 'none',    bold = true },
  DiagnosticMap                 = { fg   = '#cf80ce', bg = 'none',                },
  DiagnosticLineCol             = { fg   = '#73797e', bg = 'none',                },
  LspSagaDiagnosticTruncateLine = { link = 'SpecialKey'                           },
  ColInLineDiagnostic           = { link = 'Comment', bg = 'none',                },
  -- signture help
  LspSagaSignatureHelpBorder    = { link = 'FloatBorder'                          },
  LspSagaShTrunCateLine         = { link = 'SpecialKey'                           },
  -- lightbulb
  LspSagaLightBulb              = { link = 'DiagnosticSignHint'                   },
  -- shadow
  SagaShadow                    = { link = 'FloatBorder'                          },
  -- float
  LspSagaBorderTitle            = { link = 'FloatBorder'                          },
  -- Outline
  LSOutlinePreviewBorder        = { link = 'FloatBorder'                          },
  OutlineIndentEvn              = { fg   = '#3c3c3c', bg = 'none',                },
  OutlineIndentOdd              = { fg   = '#3c3c3c', bg = 'none',                },
  OutlineFoldPrefix             = { fg   = '#1cff1c', bg = 'none',                },
  OutlineDetail                 = { fg   = '#1c1cff', bg = 'none',                },
  -- all floatwindow of lspsaga
  LspFloatWinNormal             = { link = 'Normal'                               },
  -- Winbar
  LspSagaWinbarKey = { fg = '#495466' },
  LspSagaWinbarSep = { fg = '#495466' },
  LspSagaWinbarEnum = { fg = '#495466' },
  LspSagaWinbarFile = { fg = '#495466' },
  LspSagaWinbarNull = { fg = '#495466' },
  LspSagaWinbarArray = { fg = '#495466' },
  LspSagaWinbarClass = { fg = '#495466' },
  LspSagaWinbarEvent = { fg = '#495466' },
  LspSagaWinbarField = { fg = '#495466' },
  LspSagaWinbarMacro = { fg = '#495466' },
  LspSagaWinbarMethod = { fg = '#495466' },
  LspSagaWinbarModule = { fg = '#495466' },
  LspSagaWinbarNumber = { fg = '#495466' },
  LspSagaWinbarObject = { fg = '#495466' },
  LspSagaWinbarString = { fg = '#495466' },
  LspSagaWinbarStruct = { fg = '#495466' },
  LspSagaWinbarBoolean = { fg = '#495466' },
  LspSagaWinbarPackage = { fg = '#495466' },
  LspSagaWinbarConstant = { fg = '#495466' },
  LspSagaWinbarFunction = { fg = '#495466' },
  LspSagaWinbarOperator = { fg = '#495466' },
  LspSagaWinbarProperty = { fg = '#495466' },
  LspSagaWinbarVariable = { fg = '#495466' },
  LspSagaWinbarInterface = { fg = '#495466' },
  LspSagaWinbarNamespace = { fg = '#495466' },
  LspSagaWinbarParameter = { fg = '#495466' },
  LspSagaWinbarTypeAlias = { fg = '#495466' },
  LspSagaWinbarEnumMember = { fg = '#495466' },
  LspSagaWinbarConstructor = { fg = '#495466' },
  LspSagaWinbarStaticMethod = { fg = '#495466' },
  LspSagaWinbarTypeParameter = { fg = '#495466' },
}

-- setting highlights
for group, conf in pairs(highlights) do
  vim.api.nvim_set_hl(0, group, conf)
end

-- Terminal colors
custom_terminal_colors = {
  terminal_color_0  = '#222222',
  terminal_color_1  = '#bb0000',
  terminal_color_2  = '#008800',
  terminal_color_3  = '#bbbb00',
  terminal_color_4  = '#5555cc',
  terminal_color_5  = '#8855ff',
  terminal_color_6  = '#7acaca',
  terminal_color_7  = '#ffffff',
  terminal_color_8  = '#7c7c7c',
  terminal_color_9  = '#ff0000',
  terminal_color_10 = '#00ff00',
  terminal_color_11 = '#ffff00',
  terminal_color_12 = '#1c1cff',
  terminal_color_13 = '#8844bb',
  terminal_color_14 = '#008888',
  terminal_color_15 = '#ff4400',
}

-- setting custom_terminal_colors
for group, conf in pairs(custom_terminal_colors) do
  vim.g[group] = conf
end

EOF
