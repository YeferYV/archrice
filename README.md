<div align="center">    <img src="screenshot.png" alt="screenshot">
    <div align="left">
    <b> arch linux rice with: </b>
    <li> neovim text objects from A-Z based on <a href="https://github.com/LunarVim/Neovim-from-scratch">neovim-from-scratch</a> </li>
    <li> preview/play/open images/videos/pdf/text inside terminal/GUI using <a href="https://github.com/sxyazi/yazi">yazi</a> </li>
    <li> touchcursor-like keyboard layout using <a href="https://github.com/jtroo/kanata">kanata</a> </li>
    <li> <a href="https://github.com/baskerville/bspwm">bspwm</a> window manager </li>
    </div>

---

**[<kbd> <br> Install <br> </kbd>][Install]** 
**[<kbd> <br> Keyboard-Layout <br> </kbd>][Keyboard-Layout]** 
**[<kbd> <br> Wiki <br> </kbd>][Wiki]** 
**[<kbd> <br> Dependencies <br> </kbd>][Dependencies]**

[Install]: #installation
[Keyboard-Layout]: #touchcursor-like-keyboard-layout
[Wiki]: https://github.com/YeferYV/archrice/wiki
[Dependencies]: https://github.com/YeferYV/archrice/wiki/dependencies

</div>

---

<details><summary>Table of Contents</summary>

1. Neovim TextObjects/Motions
   - [Neovim text object that starts with a/i](#neovim-text-object-that-starts-with-ai)
   - [Neovim text object that starts with g](#neovim-text-object-that-starts-with-g)
   - [Neovim Motions and Operators](#neovim-motions-and-operators)
2. Neovim Goto
   - [Neovim Space TextObjects/Motions](#neovim-space-textobject-motions)
   - [Neovim Go to Previous / Next](#neovim-go-to-previous--next)
   - [Neovim Mini.bracketed](#neovim-minibracketed)
   - [Native neovim ctrl keys](#native-neovim-ctrl-keys)
3. Neovim keymaps.lua
   - [Neovim Editor keymaps](#neovim-editor-keymaps)
   - [Neovim Suggestion keymaps](#neovim-suggestion-keymaps)
4. Terminal
   - [wezterm terminal keymaps](#wezterm-terminal-keymaps)
   - [zsh keymaps](#zsh-keymaps)
5. [BSPWM Window Manager](#bspwm-window-manager)
6. [Touchcursor-like Keyboard Layout](#touchcursor-like-keyboard-layout)
7. Installation
   - [Dependencies Installation](#installation)
   - [Treesitter Installation (optional)](#treesitter-installation-optional)
8. [Vim Cheatsheets](#vim-cheatsheets)
9. [Related projects](#related-projects)

</details>

---

## Neovim text object that starts with `a`/`i`

<details><summary></summary>

|         text-object keymap         | repeater key | finds and autojumps? | text-object name     | description                                                                               | inner / outer                                                                 |
| :--------------------------------: | :----------: | :------------------: | :------------------- | :---------------------------------------------------------------------------------------- | :---------------------------------------------------------------------------- |
|             `ia`, `aa`             |     `.`      |         yes          | \_function_args      | whole argument/parameter of a function                                                    | outer includes braces                                                         |
|             `iA`, `aA`             |     `.`      |         yes          | @Assignment          | inner: left side of assignment without including type                                     | outer includes left and right side                                            |
|             `ib`, `ab`             |     `.`      |         yes          | \_Braces             | find the nearest inside of () [] {}                                                       | outer includes braces                                                         |
|             `iB`, `aB`             |     `.`      |         yes          | greddy_Brace         | use the current inside of {}                                                              | outer includes {}                                                             |
|             `ic`, `ac`             |     `.`      |                      | word-column          | visual block for words                                                                    | outer includes spaces                                                         |
|             `iC`, `aC`             |     `.`      |                      | WORD-column          | visual block for WORDS                                                                    | outer includes spaces                                                         |
|             `ie`, `ae`             |     `.`      |                      | line                 | from start to end of line without beginning whitespaces (line wise)                       | outer includes begining whitespaces                                           |
|             `if`, `af`             |     `.`      |         yes          | \_function_call      | like `function args` but only when a function is called                                   | outer includes the function called                                            |
|             `iF`, `aF`             |     `.`      |         yes          | @Function            | inside of a function without leading comments                                             | outer includes function declaration                                           |
|                `ag`                |     `.`      |         yes          | @Comment             | inline comment                                                                            | outer many times same as inner                                                |
|             `iG`, `aG`             |     `.`      |         yes          | @Conditional         | inside conditional without blanklines                                                     | outer includes the start of a condition                                       |
|             `ih`, `ah`             |     `.`      |         yes          | \_htmlAttribute      | attribute in html/xml like `href="foobar.com"`                                            | inner is only the value inside the quotes trailing comma and space            |
|             `ii`, `ai`             |     `.`      |                      | indentation_noblanks | surrounding lines with same or higher indentation delimited by blanklines                 | outer includes line above                                                     |
|             `iI`, `aI`             |     `.`      |                      | indentation          | surrounding lines with same or higher indentation                                         | outer includes line above and below                                           |
|             `ik`, `ak`             |     `.`      |         yes          | \_key                | key of key-value pair, or left side of a assignment                                       | outer includes spaces                                                         |
|             `iK`, `aK`             |     `.`      |                      | @Block               | code block (inside of a function, loop, ...)                                              | outer includes line above                                                     |
|             `il`, `al`             |     `.`      |         yes          | +Last                | go to last mini.ai text-object (which start with @ or \_)                                 | requires `i`/`a` example `vilk`                                               |
|             `iL`, `aL`             |     `.`      |         yes          | @Loop                | inside `while` or `for` clauses                                                           | outer includes blankline + comments + line above                              |
|             `in`, `an`             |     `.`      |         yes          | +Next                | go to Next mini.ai text-object (which start with @ or \_)                                 | requires `i`/`a` example `viNk`                                               |
|             `iN`, `aN`             |     `.`      |         yes          | \_number             | numbers, similar to `<C-a>`                                                               | inner: only pure digits, outer: number including minus sign and decimal point |
|             `io`, `ao`             |     `.`      |         yes          | \_whitespaces        | whitespace beetween characters                                                            | outer includes surroundings                                                   |
|             `ip`, `ap`             |     `.`      |                      | paragraph            | blanklines can also be treat as paragraphs when focused on a blankline                    | outer includes below lines                                                    |
|             `iP`, `aP`             |     `.`      |         yes          | @Parameter           | parameters of a function (`>,` or `<,` to interchange)                                    | outer includes commas + spaces                                                |
|             `iq`, `aq`             |     `.`      |         yes          | @Call                | like `function call` but treesitter aware                                                 | outer includes the function called                                            |
|             `iQ`, `aQ`             |     `.`      |         yes          | @Class               | inside of a class                                                                         | outer includes class declaration                                              |
|             `iR`, `aR`             |     `.`      |         yes          | @Return              | inside of a Return clause                                                                 | outer includes the `return                                                    |
|             `is`, `as`             |     `.`      |                      | sentence             | sentence delimited by dots of blanklines                                                  | outer includes spaces                                                         |
|             `iS`, `aS`             |     `.`      |                      | subword              | like `iw`, but treating `-`, `_`, and `.` as word delimiters _and_ only part of camelCase | outer includes trailing `_`,`-`, or space                                     |
|             `it`, `at`             |     `.`      |         yes          | \_tag                | inside of a html/jsx tag                                                                  | outer includes openning and closing tags                                      |
|             `iu`, `au`             |     `.`      |         yes          | \_quotes             | inside of `` '' ""                                                                        | outer includes openning and closing quotes                                    |
|             `iv`, `av`             |     `.`      |         yes          | \_value              | value of key-value pair, or right side of a assignment                                    | outer includes trailing commas or semicolons or spaces                        |
|             `iw`, `aw`             |     `.`      |                      | word                 | from cursor to end of word (delimited by punctuation or space)                            | outer includes start of word                                                  |
|             `iW`, `aW`             |     `.`      |                      | WORD                 | from cursor to end of WORD (includes punctuation)                                         | outer includes start of word                                                  |
|             `ix`, `ax`             |     `.`      |         yes          | \_Hex                | hexadecimal number or color                                                               | outer includes hash `#`                                                       |
|             `iy`, `ay`             |     `.`      |                      | same_indent          | surrounding lines with only same indentation (delimited by blankspaces)                   | outer includes blankspaces                                                    |
|             `iz`, `az`             |     `.`      |                      | @fold                | inside folds without line above neither below (supported only inside neovim)              | outer includes line above andd below                                          |
|             `i=`, `a=`             |     `.`      |         yes          | @Assignment.rhs-lhs  | assignmentt right and left without type keyword neither semicolons                        | inner: left assignment, outer: right assignment                               |
|             `i#`, `a#`             |     `.`      |         yes          | @Number              | like `_number` but treesitter aware                                                       | inner and outer are the same (only pure digits)                               |
|             `i?`, `a?`             |     `.`      |         yes          | \_Prompt             | will ask you for enter the delimiters of a text object (useful for dot repeteability)     | outer includes surroundings                                                   |
|       `i(`, `i)`, `a(`, `a)`       |     `.`      |         yes          | `(` or `)`           | inside `()`                                                                               | outer includes surroundings                                                   |
|       `i[`, `i]`, `a[`, `a]`       |     `.`      |         yes          | `[` or `]`           | inside `[]`                                                                               | outer includes surroundings                                                   |
|       `i{`, `i}`, `a{`, `a}`       |     `.`      |         yes          | `{` or `}`           | inside `{}`                                                                               | outer includes surroundings                                                   |
|       `i<`, `i>`, `a<`, `a>`       |     `.`      |         yes          | `<` or `>`           | inside `<>`                                                                               | outer includes surroundings                                                   |
|         `` i` ``, `` a` ``         |     `.`      |         yes          | apostrophe           | inside `` ` ` ``                                                                          | outer includes surroundings                                                   |
| `i<punctuation>`, `a<punctuation>` |     `.`      |         yes          | `<punctuation>`      | inside `<punctuation><punctuation>`                                                       | outer includes surroundings                                                   |

</details>

## Neovim text object that starts with `g`

<details><summary></summary>

| text-object keymap |  mode   | repeater key | text-object description                                       | normal mode                              | operating-pending mode | visual mode                  | examples in normal mode                                                          |
| :----------------: | :-----: | :----------: | :------------------------------------------------------------ | :--------------------------------------- | :--------------------- | :--------------------------- | :------------------------------------------------------------------------------- |
|    `g[` or `g]`    | `o`,`x` |              | +cursor to Left/right Around (only textobj with `@`,`_`)      |                                          | followed by textobject | uses selected region         | `vg]u` will select until quotation                                               |
|        `g>`        | `o`,`x` |     `.`      | Next find                                                     |                                          | will find and jump     | uses selection               | `cgf???` will replace last search with `???` forwardly                           |
|        `g<`        | `o`,`x` |     `.`      | Prev find                                                     |                                          | will find and jump     | uses selection               | `cgF???` will replace last search with `???` backwardly                          |
|        `g.`        | `o`,`x` |              | Jump toLastChange                                             |                                          | won't jump             | uses selection               | `vg.` will select from cursor position until last change                         |
|        `ga`        | `n`,`x` |              | align                                                         | followed by textobject/motion            |                        | uses selected region         | `vipga=` will align a paragraph by `=`                                           |
|        `gA`        | `n`,`x` |              | preview align (`escape` to cancel, `enter` to accept)         | followed by textobject/motion            |                        | uses selected region         | `vipgA=` will align a paraghaph by `=`                                           |
|        `gb`        | `n`,`x` |     `.`      | Blackhole register                                            | followed by textobject/motion            |                        | deletes selection            | `vipgb` will delete a paragraph without copying                                  |
|        `gB`        | `n`,`x` |     `.`      | Blackhole linewise                                            | textobject not required                  |                        | deletes line                 | `gB.` will delete two lines without saving it in the register                    |
|        `gc`        | `o`,`x` |     `.`      | comment (`vgc` in normal mode will select a block comment)    |                                          | won't jump             | uses selection               | `vipgc` will comment a paragraph                                                 |
|        `gC`        | `o`,`x` |     `.`      | Block comment (supports selection `vgC`)                      |                                          | won't jump             | reselects                    | `vgC` will select current block of comment                                       |
|        `gd`        | `o`,`x` |     `.`      | Diagnostic (requires LSP so only works inside neovim)         |                                          | will find and jump     | will find and jump           | `vgd` will select the error                                                      |
|        `ge`        | `o`,`x` |              | Previous end of word                                          |                                          | uses cursor position   | uses selection               | `vge` will select from cursor position until previous end of word                |
|        `gE`        | `o`,`x` |              | Previous end of WORD ('WORD' omits punctuation )              |                                          | uses cursor position   | uses selection               | `vge` will select from cursor position until previous end of WORD                |
|        `gg`        | `o`,`x` |     `.`      | First line                                                    |                                          | uses cursor position   | uses selection               | `vgg` will select until first line                                               |
|        `gH`        |   `x`   |     `.`      | Git hunk                                                      |                                          | won't jump             | relesects                    | `vgh` will select modified code                                                  |
|        `gi`        | `n`,`x` |              | Last position of cursor in insert mode                        | will find and jump                       |                        | uses selection               | `vgi` will select until last insertion                                           |
|        `gj`        | `o`,`x` |     `.`      | Go down when wrapped                                          |                                          | uses cursor position   | uses selection               | `vgj` will select one line down                                                  |
|        `gk`        | `o`,`x` |     `.`      | Go up when wrapped                                            |                                          | uses cursor position   | uses selection               | `vgj` will select one line up                                                    |
|        `gm`        | `n`,`x` |              | +Multiply (duplicate text) Operator                           |                                          | won't jump             | uses selection               | `vapgm` will duplicate paragraph without replacing clipboard                     |
|        `gn`        | `o`,`x` |     `.`      | +next (only textobj with `@`,`_`)                             |                                          | followed by textobject | uses selection               | `vgniu` will select from cursor position until next quotation                    |
|        `gp`        | `o`,`x` |     `.`      | +previous (only textobj with `@`,`_`)                         |                                          | followed by textobject | uses selection               | `vgpiu` will select from cursor position until previous quotation                |
|        `gq`        | `n`,`x` |     `.`      | +Format Selection/comments 80chars 80chars (LSP overrides it) | requires a textobject                    |                        | applies to selection         | `vipgq` will format a paragraph                                                  |
|        `gr`        | `n`,`x` |     `.`      | +Replace (with register) Operator                             | followed by textobject/motion            |                        | applies to selection         | `viwgr` will replace word with register (yanked text)                            |
|        `gs`        | `n`,`x` |     `.`      | +Sort Operator                                                | followed by textobject/motion            |                        | uses selection               | `vipgs` will sort paragraph                                                      |
|        `gS`        | `n`,`x` |     `.`      | Join/Split lines inside braces                                | will toggle inside `{}`,`[]`,`()`        |                        | followed by operator         | `vipgS` will join selected lines in one line                                     |
|        `gt`        | `n`,`x` |     `.`      | +go to end of textobj                                         | followed by textobject                   |                        | selects form cursor position | `vgliu` will select until start of quotation                                     |
|        `gT`        | `n`,`x` |     `.`      | +go to start of textobj                                       | followed by textobject                   |                        | selects from cursor position | `vghiu` will select until end of quotation                                       |
|        `gu`        | `n`,`x` |     `.`      | +tolowercase                                                  | requires a textobject                    |                        | applies to selection         | `vipgu` will lowercase a paragraph                                               |
|        `gU`        | `n`,`x` |     `.`      | +toUppercase                                                  | requires a textobject                    |                        | applies to selection         | `vipgU` will uppercase a paragraph                                               |
|        `gv`        | `n`,`x` |              | last selected                                                 | will find and jump                       |                        | reselects                    | `vgv` will select last selection                                                 |
|        `gw`        | `n`,`x` |     `.`      | Split/Join comments/lines 80chars (preserves cursor position) | requires a textobject                    |                        | applies to selection         | `vipgw` will split/join a paragraph limited by 80 characters                     |
|        `gx`        | `n`,`x` |     `.`      | +Exchange (text) Operator                                     | followed by textobject/motion            |                        | uses selection               | `viwgx` will exchange word with another `viwgY`                                  |
|        `gz`        | `n`,`x` |     `.`      | +Surround (followed by a=add, d=delete, r=replace)            | followed by textobject/motion (only add) |                        | uses selection (only add)    | `viwgza"` will add `"` to word, `gzd"` will delete `"`, `gzr"'` will replace `"` |
|        `g+`        | `n`,`x` |     `.`      | Increment number                                              | selects number under cursor              |                        | uses selected number         | `3g+` will increment by 3                                                        |
|        `g-`        | `n`,`x` |     `.`      | Decrement number                                              | selects number under cursor              |                        | uses selected number         | `g-..` will decrement by 3                                                       |
|      `g<Up>`       | `n`,`x` |              | Numbers ascending                                             | selects number under cursor              |                        | uses selected number         | `g<Up>` will increase selected numbers ascendingly                               |
|     `g<Down>`      | `n`,`x` |              | Numbers descending                                            | selects number under cursor              |                        | uses selected number         | `g<Down>` will decrease selected numbers descendingly                            |
|        `=`         | `n`,`x` |     `.`      | autoindent                                                    | followed by text-object                  |                        | uses selection               | `==` autoindents line                                                            |
|        `>`         | `n`,`x` |     `.`      | indent right                                                  | followed by text-object                  |                        | uses selection               | `>>` indents to right a line                                                     |
|        `<`         | `n`,`x` |     `.`      | indent left                                                   | followed by text-object                  |                        | uses selection               | `<<` indents to left a line                                                      |
|        `$`         |   `o`   |     `.`      | End of line                                                   |                                          |                        |                              | `d$j.` deletes two end-of-lines                                                  |
|        `%`         |   `o`   |              | Matching character: '()', '{}', '[]'                          | won't jump                               |                        | won't jump                   | `d%` deletes until bracket                                                       |
|        `0`         |   `o`   |     `.`      | Start of line                                                 |                                          |                        |                              | `d0` deletes until column 0                                                      |
|        `^`         |   `o`   |     `.`      | Start of line (non-blank)                                     |                                          |                        |                              | `d^` deletes until start of line (after whitespace)                              |
|        `(`         |   `o`   |     `.`      | Previous sentence                                             |                                          |                        |                              | `d(.` deletes until start of sentence (two times)                                |
|        `)`         |   `o`   |     `.`      | Next sentence                                                 |                                          |                        |                              | `d).` deletes until end of sentence (two times)                                  |
|        `{`         |   `o`   |     `.`      | Previous empty line (before a paragraph)                      |                                          |                        |                              | `d{.` deletes until next empty line (two times)                                  |
|        `}`         |   `o`   |     `.`      | Next empty line (after a paragraph)                           |                                          |                        |                              | `d}.` deletes until previous empty line (two times)                              |
|        `[[`        |   `o`   |     `.`      | Previous section                                              |                                          |                        |                              | `d[[` deletes until start of section                                             |
|        `]]`        |   `o`   |     `.`      | Next section                                                  |                                          |                        |                              | `d]]` deletes until end of section                                               |
|       `<CR>`       |   `o`   |     `.`      | Continue Last Flash search                                    |                                          |                        |                              | `d<CR><CR>` deletes until next searched text                                     |
|        `b`         |   `o`   |     `.`      | Previous word                                                 |                                          |                        |                              | `db` deletes until start of word                                                 |
|        `e`         |   `o`   |     `.`      | Next end of word                                              |                                          |                        |                              | `de` deletes until end of word                                                   |
|        `f`         |   `o`   |     `.`      | Move to next char                                             |                                          |                        |                              | `df,` deletes until a next `,`                                                   |
|        `F`         |   `o`   |     `.`      | Move to previous char                                         |                                          |                        |                              | `dF,` deletes until a previous `,`                                               |
|        `G`         |   `o`   |     `.`      | Last line                                                     |                                          |                        |                              | `dG` deletes until last line                                                     |
|        `R`         |   `o`   |     `.`      | Treesitter Flash Search                                       |                                          |                        |                              | `dR,<CR>` deletes next treesitter region that contains `,`                       |
|        `s`         |   `o`   |     `.`      | Flash (search with labels in current window)                  |                                          |                        |                              | `ds,<CR>` deletes until next `,`                                                 |
|        `S`         |   `o`   |     `.`      | Flash Treesitter                                              |                                          |                        |                              | `dS<CR>` deletes treesitter region under cursor position                         |
|        `t`         |   `o`   |     `.`      | Move before next char                                         |                                          |                        |                              | `dt` deletes before next `,`                                                     |
|        `T`         |   `o`   |     `.`      | Move before previous char                                     |                                          |                        |                              | `dT` deletes before previous `,`                                                 |
|        `w`         |   `o`   |     `.`      | Next word                                                     |                                          |                        |                              | `dw.` deletes 2 words                                                            |
|        `W`         |   `o`   |     `.`      | Next WORD                                                     |                                          |                        |                              | `dW.` deletes 2 WORDS                                                            |

</details>

## Neovim Motions and Operators

<details><summary></summary>

| Motion/Operator keymap |  Mode   |      repeater key      | Description                                              | requires textobject/motion keymap? (operators requires textobjects/motion) | example when in normal mode                              |
| :--------------------: | :-----: | :--------------------: | :------------------------------------------------------- | :------------------------------------------------------------------------: | :------------------------------------------------------- |
|          `g[`          | `n`,`x` |                        | +Cursor to Left Around (only textobj with `@`,`_`)       |                                    yes                                     | `g]u` go to end to quotation                             |
|          `g]`          | `n`,`x` |                        | +Cursor to Rigth Around (only textobj with `@`,`_`)      |                                    yes                                     | `g[u` go to start of quotation                           |
|          `g.`          | `n`,`x` |                        | go to last change                                        |                                                                            |                                                          |
|          `g,`          |   `n`   |                        | go forward in `:changes`                                 |                                                                            |                                                          |
|          `g;`          |   `n`   |                        | go backward in `:changes`                                |                                                                            |                                                          |
|          `ga`          | `n`,`x` |          `.`           | +align                                                   |                                    yes                                     | `gaip=` will align a paragraph by `=`                    |
|          `gA`          | `n`,`x` |          `.`           | +preview align (escape to cancel, enter to accept)       |                                    yes                                     | `gAip=` will align a paragraph by `=`                    |
|          `gb`          | `n`,`x` |          `.`           | +Blackhole register                                      |                                    yes                                     | `gbip` delete a paragraph without copying                |
|          `gB`          | `n`,`x` |          `.`           | Blackhole linewise                                       |                                    yes                                     | `gB` delete line                                         |
|          `gc`          | `n`,`x` |          `.`           | +comment                                                 |                                    yes                                     | `gcip` comment a paragraph                               |
|          `gd`          |   `n`   |                        | go to definition                                         |                                                                            |                                                          |
|          `ge`          | `n`,`x` |                        | go to previous endOfWord                                 |                                                                            |                                                          |
|          `gE`          | `n`,`x` |                        | go to previous endOfWord                                 |                                                                            |                                                          |
|          `gf`          |   `n`   |                        | go to file under cursor                                  |                                                                            |                                                          |
|          `gg`          | `n`,`x` |                        | go to first line                                         |                                                                            |                                                          |
|          `gh`          | `n`,`x` |          `.`           | +go to start of textobj                                  |                                    yes                                     | `ghiu` go to start of quotation                          |
|          `gi`          | `n`,`x` |                        | Last position of cursor in insert mode                   |                                                                            |                                                          |
|          `gj`          | `n`,`x` |                        | go to Down (when wrapped)                                |                                                                            |                                                          |
|          `gJ`          | `n`,`x` |          `.`           | Join below Line                                          |                                                                            |                                                          |
|          `gk`          | `n`,`x` |                        | go to Up (when wrapped)                                  |                                                                            |                                                          |
|          `gl`          | `n`,`x` |          `.`           | +go to end of textobj                                    |                                    yes                                     | `gliu` go to end of quotation                            |
|          `gm`          | `n`,`x` |                        | +Multiply (duplicate text) Operator                      |                                                                            | `gmap` duplicate paragraph withoug modifying clipboard   |
|          `gM`          | `n`,`x` |                        | go to mid line                                           |                                                                            |                                                          |
|          `gn`          | `n`,`x` | `;`forward `,`backward | +next (only textobj with `@`,`_`)                        |                                    yes                                     | `gniu` go to next quotation                              |
|          `gp`          | `n`,`x` | `;`forward `,`backward | +previous (only textobj with `@`,`_`)                    |                                    yes                                     | `gpiu` go to previous quotation                          |
|          `gq`          | `n`,`x` |          `.`           | +Format selection/comments                               |                                    yes                                     | `gqip` format a paragraph                                |
|          `gr`          | `n`,`x` |          `.`           | +Replace (with register) Operator                        |                                    yes                                     | `griw` replace word with register (yanked text)          |
|          `gs`          | `n`,`x` |          `.`           | +Sort Operator                                           |                                    yes                                     | `gsip` sort paragraph                                    |
|          `gS`          | `n`,`x` |          `.`           | SplitJoin args                                           |                                                                            |                                                          |
|          `gt`          |   `n`   |                        | go to next tab                                           |                                                                            |                                                          |
|          `gT`          |   `n`   |                        | go to prev tab                                           |                                                                            |                                                          |
|          `gu`          | `n`,`x` |          `.`           | +toLowercase                                             |                                    yes                                     | `guip` lowercase a paragraph                             |
|          `gU`          | `n`,`x` |          `.`           | +toUppercase                                             |                                    yes                                     | `gUip` uppercase a paragraph                             |
|          `gv`          | `n`,`x` |                        | last selected                                            |                                                                            |                                                          |
|          `gw`          | `n`,`x` |          `.`           | +SplitJoin coments/lines 80chars (keeps cursor position) |                                    yes                                     | `gwip` split/join a paragraph by 80 characters           |
|          `gx`          | `n`,`x` |          `.`           | +Exchange (text) Operator                                |                                    yes                                     | `gxiw` exchange word with another `gxiw`                 |
|          `gy`          |   `n`   |          `.`           | Redo register (dot to paste forward)                     |                                                                            |                                                          |
|          `gY`          |   `n`   |          `.`           | Redo register (dot to paste backward)                    |                                                                            |                                                          |
|          `gz`          | `n`,`x` |          `.`           | +Surround (followed by a=add, d=delete, r=replace)       |                                    yes                                     | `gzaiw"` add `"`, `gzd"` delete `"`, `gzr"'` replace `"` |
|          `g+`          | `n`,`x` |          `.`           | Increment number                                         |                                    yes                                     | `10g+` increment by 10                                   |
|          `g-`          | `n`,`x` |          `.`           | Decrement number                                         |                                    yes                                     | `g-` decrement by 1                                      |
|          `=`           | `n`,`x` |          `.`           | +autoindent                                              |                                    yes                                     | `=ip` autoindents paragraph                              |
|          `>`           | `n`,`x` |          `.`           | +indent right                                            |                                    yes                                     | `>ip` indents to right a paragraph                       |
|          `<`           | `n`,`x` |          `.`           | +indent left                                             |                                    yes                                     | `<ip` indents to left a paragraph                        |
|          `$`           | `n`,`x` |                        | End of line                                              |                                                                            |                                                          |
|          `%`           | `n`,`x` |                        | Matching character: '()', '{}', '[]'                     |                                                                            |                                                          |
|          `0`           | `n`,`x` |                        | Start of line                                            |                                                                            |                                                          |
|          `^`           | `n`,`x` |                        | Start of line (non-blank)                                |                                                                            |                                                          |
|          `(`           | `n`,`x` |                        | Previous sentence                                        |                                                                            |                                                          |
|          `)`           | `n`,`x` |                        | Next sentence                                            |                                                                            |                                                          |
|          `{`           | `n`,`x` |                        | Previous empty line (paragraph)                          |                                                                            |                                                          |
|          `}`           | `n`,`x` |                        | Next empty line (paragraph)                              |                                                                            |                                                          |
|          `[[`          | `n`,`x` |                        | Previous section                                         |                                                                            |                                                          |
|          `]]`          | `n`,`x` |                        | Next section                                             |                                                                            |                                                          |
|         `<CR>`         | `n`,`x` |                        | Continue Last Flash search                               |                                                                            |                                                          |
|          `b`           | `n`,`x` |                        | Previous word                                            |                                                                            |                                                          |
|          `e`           | `n`,`x` |                        | Next end of word                                         |                                                                            |                                                          |
|          `f`           | `n`,`x` |          `f`           | Move to next char                                        |                                                                            |                                                          |
|          `F`           | `n`,`x` |          `F`           | Move to previous char                                    |                                                                            |                                                          |
|          `G`           | `n`,`x` |                        | Last line                                                |                                                                            |                                                          |
|          `R`           |   `x`   |                        | Treesitter Flash Search                                  |                                                                            |                                                          |
|          `s`           | `n`,`x` |         `<CR>`         | Flash (search with labels in current window)             |                                                                            |                                                          |
|          `S`           | `n`,`x` |                        | Flash Treesitter                                         |                                                                            |                                                          |
|          `t`           | `n`,`x` |          `t`           | Move before next char                                    |                                                                            |                                                          |
|          `T`           | `n`,`x` |          `T`           | Move before previous char                                |                                                                            |                                                          |
|          `U`           |   `n`   |                        | repeat `:normal <keys>` or `:<commands>`                 |                                                                            |                                                          |
|          `w`           | `n`,`x` |                        | Next word                                                |                                                                            |                                                          |
|          `W`           | `n`,`x` |                        | Next WORD                                                |                                                                            |                                                          |
|          `Y`           | `n`,`x` |                        | Yank until end of line                                   |                                                                            |                                                          |

</details>

## Neovim Space TextObjects/Motions

<details><summary></summary>

|      Keymap       |    Mode     |      repeater key      | Description                                |
| :---------------: | :---------: | :--------------------: | :----------------------------------------- |
| `<space><space>p` |   `n`,`x`   |          `.`           | Paste after (secondary clipboard)          |
| `<space><space>P` |   `n`,`x`   |          `.`           | Paste before (secondary clipboard)         |
| `<space><space>y` |   `n`,`x`   |                        | Yank (secondary clipboard)                 |
| `<space><space>Y` |   `n`,`x`   |                        | Yank until EndOfLine (secondary clipboard) |
| `<space><space>j` | `n`,`x`,`o` | `;`forward `,`backward | prev ColumnMove                            |
| `<space><space>k` | `n`,`x`,`o` | `;`forward `,`backward | next ColumnMove                            |

</details>

## Neovim Go to Previous / Next

<details><summary></summary>

|     Keymap      |    Mode     |      repeater key      | Description                            |
| :-------------: | :---------: | :--------------------: | :------------------------------------- |
|  `gpc` / `gnc`  | `n`,`o`,`x` | `;`forward `,`backward | previous/next comment                  |
|  `gpd` / `gnd`  | `n`,`o`,`x` | `;`forward `,`backward | previous/next diagnostic               |
|  `gph` / `gnh`  | `n`,`o`,`x` | `;`forward `,`backward | previous/next git hunk                 |
|  `gpI` / `gnI`  | `n`,`o`,`x` | `;`forward `,`backward | previous/next Indent different leve    |
|  `gpy` / `gny`  | `n`,`o`,`x` | `;`forward `,`backward | previous/next Indent same level        |
| `gpaK` / `gnaK` | `n`,`o`,`x` | `;`forward `,`backward | previous/next of outer @block          |
| `gpaq` / `gnaq` | `n`,`o`,`x` | `;`forward `,`backward | previous/next of outer @call           |
| `gpaQ` / `gnaQ` | `n`,`o`,`x` | `;`forward `,`backward | previous/next of outer @class          |
| `gpag` / `gnag` | `n`,`o`,`x` | `;`forward `,`backward | previous/next of outer @comment        |
| `gpaG` / `gnaG` | `n`,`o`,`x` | `;`forward `,`backward | previous/next of outer @conditional    |
| `gpaF` / `gnaF` | `n`,`o`,`x` | `;`forward `,`backward | previous/next of outer @function       |
| `gpaL` / `gnaL` | `n`,`o`,`x` | `;`forward `,`backward | previous/next of outer @loop           |
| `gpaP` / `gnaP` | `n`,`o`,`x` | `;`forward `,`backward | previous/next of outer @parameter      |
| `gpaR` / `gnaR` | `n`,`o`,`x` | `;`forward `,`backward | previous/next of outer @return         |
| `gpaA` / `gnaA` | `n`,`o`,`x` | `;`forward `,`backward | previous/next of outer @assignment     |
| `gpa=` / `gna=` | `n`,`o`,`x` | `;`forward `,`backward | previous/next of outer @assignment.lhs |
| `gpa#` / `gna#` | `n`,`o`,`x` | `;`forward `,`backward | previous/next of outer @number         |
| `gpaf` / `gnaf` | `n`,`o`,`x` | `;`forward `,`backward | previous/next of outer \_function      |
| `gpah` / `gnah` | `n`,`o`,`x` | `;`forward `,`backward | previous/next of outer \_htmlAttribute |
| `gpak` / `gnak` | `n`,`o`,`x` | `;`forward `,`backward | previous/next of outer \_key           |
| `gpaN` / `gnaN` | `n`,`o`,`x` | `;`forward `,`backward | previous/next of outer \_number        |
| `gpau` / `gnau` | `n`,`o`,`x` | `;`forward `,`backward | previous/next of outer \_quote         |
| `gpax` / `gnax` | `n`,`o`,`x` | `;`forward `,`backward | previous/next of outer \_Hex           |
| `gpik` / `gnik` | `n`,`o`,`x` | `;`forward `,`backward | previous/next of inner @block          |
| `gpiq` / `gniq` | `n`,`o`,`x` | `;`forward `,`backward | previous/next of inner @call           |
| `gpiQ` / `gniQ` | `n`,`o`,`x` | `;`forward `,`backward | previous/next of inner @class          |
| `gpig` / `gnig` | `n`,`o`,`x` | `;`forward `,`backward | previous/next of inner @comment        |
| `gpiG` / `gniG` | `n`,`o`,`x` | `;`forward `,`backward | previous/next of inner @conditional    |
| `gpiF` / `gniF` | `n`,`o`,`x` | `;`forward `,`backward | previous/next of inner @function       |
| `gpiL` / `gniL` | `n`,`o`,`x` | `;`forward `,`backward | previous/next of inner @loop           |
| `gpiP` / `gniP` | `n`,`o`,`x` | `;`forward `,`backward | previous/next of inner @parameter      |
| `gpiR` / `gniR` | `n`,`o`,`x` | `;`forward `,`backward | previous/next of inner @return         |
| `gpiA` / `gniA` | `n`,`o`,`x` | `;`forward `,`backward | previous/next of inner @assignment     |
| `gpi=` / `gni=` | `n`,`o`,`x` | `;`forward `,`backward | previous/next of inner @assignment.rhs |
| `gpi#` / `gni#` | `n`,`o`,`x` | `;`forward `,`backward | previous/next of inner @number         |
| `gpif` / `gnif` | `n`,`o`,`x` | `;`forward `,`backward | previous/next of inner \_function      |
| `gpih` / `gnih` | `n`,`o`,`x` | `;`forward `,`backward | previous/next of inner \_htmlAttribute |
| `gpik` / `gnik` | `n`,`o`,`x` | `;`forward `,`backward | previous/next of inner \_key           |
| `gpin` / `gnin` | `n`,`o`,`x` | `;`forward `,`backward | previous/next of inner \_number        |
| `gpiu` / `gniu` | `n`,`o`,`x` | `;`forward `,`backward | previous/next of inner \_quote         |
| `gpix` / `gnix` | `n`,`o`,`x` | `;`forward `,`backward | previous/next of inner \_Hex           |

</details>

## Neovim Mini.bracketed

<details><summary></summary>

|       keymap        |    mode     | description                                          |
| :-----------------: | :---------: | :--------------------------------------------------- |
| `[b`/`]b`/`[B`/`]B` | `n`,`o`,`x` | prev/next/first/last buffer                          |
| `[c`/`]c`/`[C`/`]C` | `n`,`o`,`x` | prev/next/first/last comment                         |
| `[x`/`]x`/`[X`/`]X` | `n`,`o`,`x` | prev/next/first/last conflict (only inside neovim)   |
| `[d`/`]d`/`[D`/`]D` | `n`,`o`,`x` | prev/next/first/last diagnostic (only inside neovim) |
| `[f`/`]f`/`[F`/`]F` | `n`,`o`,`x` | prev/next/first/last file                            |
| `[i`/`]i`/`[I`/`]I` | `n`,`o`,`x` | prev/next/first/last indent                          |
| `[j`/`]j`/`[J`/`]J` | `n`,`o`,`x` | prev/next/first/last jump                            |
| `[l`/`]l`/`[L`/`]L` | `n`,`o`,`x` | prev/next/first/last location (only inside neovim)   |
| `[o`/`]o`/`[O`/`]O` | `n`,`o`,`x` | prev/next/first/last oldfile                         |
| `[q`/`]q`/`[Q`/`]Q` | `n`,`o`,`x` | prev/next/first/last quickfix (only inside neovim)   |
| `[t`/`]t`/`[T`/`]T` | `n`,`o`,`x` | prev/next/first/last treesitter                      |
| `[w`/`]w`/`[W`/`]W` | `n`,`o`,`x` | prev/next/first/last window (only inside neovim)     |
| `[y`/`]y`/`[Y`/`]Y` | `n`,`o`,`x` | prev/next/first/last yank                            |

</details>

## Neovim native ctrl keys

<details><summary></summary>

| Key Combination |  mode   | Description                                                                     |
| :-------------: | :-----: | :------------------------------------------------------------------------------ |
|    `ctrl+a`     | `n`,`v` | increase number under cursor                                                    |
|    `ctrl+b`     | `n`,`v` | scroll down by page                                                             |
|    `ctrl+e`     | `n`,`v` | scroll down by line                                                             |
|    `ctrl+d`     | `n`,`v` | scroll down by half page                                                        |
|    `ctrl+f`     | `n`,`v` | scroll up by page                                                               |
|    `ctrl+i`     |   `n`   | jump to next in `:jumps`                                                        |
|    `ctrl+o`     |   `n`   | jump to previous in `:jumps`                                                    |
|    `ctrl+r`     |   `n`   | redo (`u` to undo)                                                              |
|    `ctrl+s`     | `n`,`v` | replace text (using `sed` syntax)(only replaces selected region on visual mode) |
|    `ctrl+u`     | `n`,`v` | scroll up by half page                                                          |
|    `ctrl+v`     | `n`,`v` | visual block mode                                                               |
|    `ctrl+x`     | `n`,`v` | decrease number under cursor                                                    |
|    `ctrl+y`     | `n`,`v` | scroll up by line                                                               |

</details>

## Neovim Editor keymaps

<details><summary></summary>

|     Key Combination      |  mode   | Description                                               |
| :----------------------: | :-----: | :-------------------------------------------------------- |
|         `ctrl+\`         |   `n`   | Toggle (terminal) visibility                              |
|         `<esc>`          |   `n`   | clear search highlight                                    |
|       `<esc><esc>`       |   `t`   | terminal normal-mode (when inside neovim's terminal)      |
|           `i`            |   `t`   | terminal exit normal-mode (when inside neovim's terminal) |
|        `<space>`         |   `n`   | Show whichkey menu                                        |
|       `<space>e?`        |   `n`   | open file explorer (Snacks.explorer) and show keybindings |
|           `jk`           |   `i`   | send Escape                                               |
|         `alt+h`          | `i`,`x` | Send Escape                                               |
|        `shift+h`         |   `n`   | Type `10h`                                                |
|        `shift+j`         |   `n`   | Type `10gj`                                               |
|        `shift+k`         |   `n`   | Type `10gk`                                               |
|        `shift+l`         |   `n`   | Type `10l`                                                |
|          `left`          |   `n`   | Go to previous editor                                     |
|         `right`          |   `n`   | Go to next editor                                         |
| `alt+left` or `alt+down` |   `n`   | Decrease view size                                        |
| `alt+right` or `alt+up`  |   `n`   | Increase view size                                        |
|         `ctrl+h`         |   `n`   | Navigate to left window                                   |
|         `ctrl+j`         |   `n`   | Navigate to down window                                   |
|         `ctrl+k`         |   `n`   | Navigate to up window                                     |
|         `ctrl+l`         |   `n`   | Navigate to right window                                  |
|        `shift+q`         |   `n`   | Close active editor                                       |
|        `shift+r`         |   `n`   | Format and save                                           |

</details>

## Neovim Suggestion keymaps

<details><summary></summary>

|     Key Combination      | mode | Description                                |
| :----------------------: | :--: | :----------------------------------------- |
|       `ctrl+space`       | `i`  | open suggestion menu                       |
|         `alt+j`          | `i`  | inline suggestion accept next word         |
|         `alt+k`          | `i`  | inline suggestion accept next line         |
|         `alt+l`          | `i`  | Commit inline suggestion                   |
|   `tab` or `downarrow`   | `i`  | go to next snippet stop or next suggestion |
| `shift+tab` or `uparrow` | `i`  | go to prev snippet stop or prev suggestion |
|         `alt+;`          | `i`  | expand or next snippet stop                |
|         `alt+,`          | `i`  | previous snippet stop                      |
|         `ctrl+c`         | `i`  | exit snippet session                       |

</details>

---

## Wezterm Terminal keymaps

<details><summary></summary>

|         Key Combination          | Description                                  |
| :------------------------------: | :------------------------------------------- |
|       `<show all keymaps>`       | run `wezterm --show-keys`                    |
| `shift+space` or `ctrl+shift+x`  | enter vim mode (`/` to search,`v` to select) |
|          `alt+shift+f`           | enter search mode (`n`,`p` like vim mode)    |
|    `alt+c` or `ctrl+shift+c`     | copy selection in terminal                   |
|    `alt+v` or `ctrl+shift+v`     | paste in terminal                            |
|             `alt+e`              | scroll terminal up by line                   |
|             `alt+d`              | scroll terminal down by line                 |
|             `alt+q`              | scroll terminal up by page                   |
|             `alt+a`              | scroll terminal down by page                 |
|             `alt+t`              | scroll terminal to top                       |
|             `alt+g`              | scroll terminal to bottom                    |
|   `alt+s` or `ctrl+shift+tab`    | go to previous tab                           |
|      `alt+f` or `ctrl+tab`       | go to next tab                               |
|         `alt+ctrl+left`          | resize terminal pane left                    |
|         `alt+ctrl+right`         | resize terminal pane right                   |
|         `alt+ctrl+down`          | resize terminal pane down                    |
|          `alt+ctrl+up`           | resize terminal pane up                      |
|        `alt+ctrl+shift+r`        | rotate panes (clockwise)                     |
|           `alt+ctrl+r`           | rotate panes (counter clockwise)             |
|          `alt+shift+s`           | move to previous tab                         |
|          `alt+shift+f`           | move to next tab                             |
|          `alt + <1..9>`          | go to tab <1..9>                             |
|     `ctrl + shift + <1..8>`      | go to tab <1..8>                             |
|            `alt + 0`             | go to last tab                               |
|        `ctrl + shift + 9`        | go to last tab                               |
|             `alt+;`              | go to recent tab                             |
|             `ctrl+0`             | reset font size                              |
|             `ctrl+=`             | increase font size                           |
|             `ctrl+-`             | decrease font size                           |
|            `ctr+left`            | go to left pane                              |
|           `ctrl+down`            | go to down pane                              |
|            `ctrl+up`             | go to up pane                                |
|           `ctr+right`            | go to right pane                             |
|         `ctrl+a ctrl+a`          | Send `ctrl+a`                                |
|            `ctrl+a [`            | open_in_vim                                  |
|            `ctrl+a ]`            | move_pane_to_new_tab                         |
|            `ctrl+a !`            | `wezterm cli move-pane-to-new-tab`           |
|        `ctrl+shift+space`        | quick select                                 |
|         `ctrl+alt+space`         | quick select and open in browser             |
|    `ctrl+a v` or `alt+ctrl+h`    | split vertical                               |
| `ctrl+a shift+v` or `alt+ctrl+v` | split horizontal                             |
|          `ctrl+shift+f`          | search (case insensitive)                    |
|          `ctrl+shift+k`          | clear scrollback                             |
|          `ctrl+shift+n`          | new window                                   |
|          `ctrl+shift+p`          | command palette                              |
|          `ctrl+shift+u`          | select unicode                               |
|    `ctrl+t` or `ctrl+shift+t`    | new tab (with current working directory)     |
|    `ctrl+w` or `ctrl+shift+w`    | close current tab                            |
|          `ctrl+shift+z`          | toggle pane zoom state                       |

</details>

---

## zsh keymaps

<details><summary></summary>

|    keymap    | description                                                |
| :----------: | :--------------------------------------------------------- |
|   `<tab>`    | show (dash/path) options or complete path                  |
| `<tab><tab>` | enter completion menu                                      |
| `<esc><esc>` | tmux-copy-mode-like / normal-mode (inside neovim terminal) |
| `vi<enter>`  | open retronvim's neovim                                    |
|  `y<enter>`  | open yazi (changes directory on exit)                      |
|   `alt+o`    | open yazi (even while writing commands)                    |
|   `alt+h`    | enter vim mode                                             |
|   `alt+j`    | previous history and enter vim-mode                        |
|   `alt+k`    | next history and enter vim-mode                            |
|   `alt+l`    | complete suggestion and enter vim-mode                     |
|   `ctrl+r`   | search history with fzf                                    |
|   `ctrl+l`   | clear screen                                               |
| `ctrl+alt+l` | clear screen (inside neovim terminal)                      |

</details>

---

## BSPWM Window Manager

<details><summary></summary>

| Keymap                                         | Description                                                |
| ---------------------------------------------- | ---------------------------------------------------------- |
| `super + Return`                               | Open wezterm                                               |
| `super + {_, shift} + Escape`                  | Dunst close/reopen notification                            |
| `super + Escape`                               | Stop cronbat                                               |
| `super + shift + Escape`                       | Reload sxhkd configuration                                 |
| `super + {_, shift} + x`                       | Close/kill window                                          |
| `super + control + f; m`                       | Alternate between tiled and monocle layout                 |
| `super + control + f; {q,r}`                   | Quit/restart bspwm                                         |
| `super + control + f; {t,p,f,shift + f}`       | Set window state {tiled,pseudo-tiled,floating,fullscreen}  |
| `super + control + f; {shift + m,l,s,p,h}`     | Set node flags {marked,locked,sticky,private,hidden}       |
| `super + control + f; {plus}`                  | Show hidden nodes one by one                               |
| `alt + Tab`                                    | Rofi alt-tab                                               |
| `super + control + r; d`                       | Rofi drun (dmenu for .desktop apps)                        |
| `super + control + r; {e, shift + e}`          | Rofi emoji                                                 |
| `super + {_,shift} + {1-9,0,minus,equal}`      | Focus or send to the given desktop                         |
| `super + {semicolon,grave}`                    | Focus the last node/desktop                                |
| `super + shift + {semicolon,grave}`            | Swap the last node/desktop                                 |
| `super + {_,shift} + c`                        | Focus the next/previous window in the current desktop      |
| `super + {h,j,k,l}`                            | Focus node in given direction                              |
| `super + shift + {h,j,k,l}`                    | Swap focused window in given direction                     |
| `super + {s,f}`                                | Focus the next/previous desktop in the current monitor     |
| `super + shift + {s,f}`                        | Swap the next/previous desktop in the current monitor      |
| `super + control + s; shift + b`               | Swap current node and biggest window                       |
| `super + control + s; {p,b,f,s}`               | focus the {parent,brother,first,second} node               |
| `super + control + s; {minus,plus}`            | Increase/decrease gap size by 1                            |
| `super + control + s; {o,n}`                   | Focus the older or newer node in the focus history         |
| `super + control + s; {r, shift + r}`          | Rotate focused tree CCW/CW                                 |
| `super + control + s; {Right, Left}`           | Rotate the current nodes parent                            |
| `super + control + s; {Down, Up}`              | Rotate the current node focused                            |
| `super + control + t; space`                   | Toggle polybar                                             |
| `super + control + t; n`                       | Toggle node border (width 1)                               |
| `super + control + t; shift + n`               | Toggle node border (width 2)                               |
| `super + control + t; d`                       | Toggle desktop border (width 1)                            |
| `super + control + t; shift + d`               | Toggle desktop border (width 2)                            |
| `super + control + t; s`                       | Toggle singleton border                                    |
| `super + control + t; g`                       | Toggle gaps (no border)                                    |
| `super + control + t; 1`                       | Toggle gaps (border_width 1)                               |
| `super + control + t; 2`                       | Toggle gaps (border_width 2)                               |
| `super + control + w; b`                       | Balance desktop's nodes                                    |
| `super + control + w; {minus,plus}`            | Increase/decrease window size                              |
| `super + control + w; {h,j,k,l}`               | Hover window to left/down/up/right                         |
| `super + control + w; shift + {h,j,k,l}`       | Move floating window by 10px                               |
| `super + control + w; {Left, Down, Up, Right}` | Hover window to corner                                     |
| `super + control + w; {s,m}`                   | Xdo resize (small/medium)                                  |
| `super + control + w; {f, shift + f}`          | Xdo fixedscreen 1366x768 (fullscreen no visible borders)   |
| `super + control + w; {m, shift + m}`          | Xdo fixedscreen 1366x768 (min-max window)                  |
| `super + {Left,Down,Up,Right}`                 | Smart resize (Will always grow for floating nodes)         |
| `super + shift + {Left,Down,Up,Right}`         | Smart resize (Will always shrink for floating nodes)       |
| `super + XF86Audio{Raise,Lower}Volume`         | Increase/Decrease volume by 5%                             |
| `XF86Audio{Raise,Lower}Volume`                 | Increase/Decrease volume by 2%                             |
| `XF86AudioMute`                                | (Un)mute audio                                             |
| `XF86AudioMicMute`                             | (Un)mute microphone                                        |
| `XF86MonBrightness{Down,Up}`                   | Increase/Decrease backlight by 0.1                         |
| `super + XF86MonBrightness{Down,Up}`           | Increase/Decrease backlight by 2                           |
| `shift + XF86MonBrightness{Down,Up}`           | Dimmer (requires xcalib)                                   |
| `super + {F11,F12}`                            | Dmenu (u)mount android (requires simple-mtpfs)             |
| `super + KP_{Right,Begin,Left}`                | Chromium {next,play-pause,previous}                        |
| `alt + KP_{Right,Begin,Left}`                  | Mpv {next,play-pause,previous}                             |
| `alt + KP_{Down,Up}`                           | Mpv volume {Down, Up}                                      |
| `KP_{Right,Begin,Left,Down,Up}`                | Mpc {next,toggle,prev,volume -2,volume +2}                 |
| `{Print, super + Print}`                       | Screenshot {fullscreen, menu}                              |
| `super + control + c; w`                       | Compositor wallpaper background                            |
| `super + control + c; b`                       | Compositor blur background                                 |
| `super + control + c; k`                       | Compositor keep background                                 |
| `super + control + c; s`                       | Compositor no shadow                                       |
| `super + control + c; {minus,plus}`            | Compositor decrease/increase transparency                  |
| `super + control + r; {1,2,3,4,5}`             | Nighlight temperature                                      |
| `super + control + p; t`                       | Toggle terminal background between #0c0c0c #000000         |
| `super + control + p; o`                       | Set a offline wallpaper (requires pywal)                   |
| `super + control + p; {w,r}`                   | Set a online {wallhaven,reddit} wallpaper (requires pywal) |
| `super + {_,shift} + p`                        | Dmenu {launcher, launch inside wezterm}                    |
| `super + {_,shift} + w`                        | Open/close google-chrome                                   |

</details>

---

## Touchcursor-like Keyboard Layout

<details><summary></summary>

**layer qwerty**

```
@grl 1    2    3    4    5    6    7    8    9    0    -    =    bspc
tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
@cap a    s    d    f    g    h    j    k    l    ;    '    ret
lsft z    x    c    v    b    n    m    ,    .    /    rsft
lctl lmet @alt           @spc           @sft rmet rctl
```

**layer touchcursor** (press and hold space to enter the layer)

```
_    f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12  _
_    @¿   _    _    _    @m🡠  @M↓  @m↓  @m↑  @M↑  @m🡪  _    _    _
_    del  spc  bspc @clr _    @🡠   @↓   @↑   @🡪   @yaz _    _
_    @ñ   _    caps _    _    pgup home end  pgdn _    _
_    _    _              _              _    _    _
```

| key  | description                                                                               |          example / keymap          |
| :--: | :---------------------------------------------------------------------------------------- | :--------------------------------: |
| @grl | tap: backtick/grave, hold and press `1` = qwerty layer, hold and press `2` = dvorak layer |         `` `+2 = dvorak ``         |
| @cap | tap for escape, hold for LeftCtrl                                                         |          `cap+l = ctrl+l`          |
| @sft | tap for backspace, hold for LeftShift                                                     |         `RAlt+l = shift+l`         |
| @alt | tap for middle click, hold for LeftAlt                                                    |         `LAlt+l = LAlt+l`          |
| @spc | tap for space, hold for touchcursor layer, release for qwerty layer                       | `space+jj = DownArrow + DownArrow` |
| @yaz | open yazi_cd on any shell                                                                 |     `space+f l = jump to file`     |
| @clr | clear screen on any shell                                                                 |             `space+f`              |
|  @¿  | unicode ¿                                                                                 |             `space+q`              |
|  @ñ  | unicode ñ                                                                                 |             `space+;`              |
| @m🡠  | mouse scrolling left                                                                      |             `space+t`              |
| @m🡪  | mouse scrolling right                                                                     |             `space+p`              |
| @m↑  | mouse scrolling up                                                                        |             `space+i`              |
| @m↓  | mouse scrolling down                                                                      |             `space+u`              |
| @M↑  | mouse fast scrolling up                                                                   |             `space+y`              |
| @M↓  | mouse fast scrolling down                                                                 |             `space+p`              |
| spc  | space key                                                                                 |             `space+s`              |
| bspc | backspace key                                                                             |             `space+d`              |
| home | home key                                                                                  |             `space+s`              |
| end  | end key                                                                                   |             `space+d`              |
| pgup | pageup key                                                                                |             `space+s`              |
| pgdn | pagedown key                                                                              |             `space+d`              |
|  @🡠  | left arrow key                                                                            |             `space+h`              |
|  @↓  | down arrow key                                                                            |             `space+j`              |
|  @↑  | up arrow key                                                                              |             `space+k`              |
|  @🡪  | right arrow key                                                                           |             `space+l`              |
| caps | toggles capslock                                                                          |             `space+c`              |

</details>

---

## Installation

<details open><summary></summary>

```bash
archintalll                                   # see https://www.youtube.com/watch?v=y9nKjTfDHLA
git clone --recursive https://github.com/yeferyv/archrice
cd archrice/.local/bin
./ResetArch                                   # to install all dependencies
sudo ARCH_USER=user ./RiceArch                # to configure arch linux (change ARCH_USER to your $USER if you don't want to create a new user, ARCH_USER and root password is "toor")
```

</details>

## Treesitter Installation (optional)

<details open><summary></summary>

- Text objects that has a `@` prefix requires a treesitter parser, neovim version `0.10` or newer comes with treesitter parsers for
  `c`, `lua`, `markdown`.
  Install treesitter parser for your programming language with `:TSInstall <your programming language>`

- Example: in normal mode type `:` to open vim-command-line then type `TSInstall cpp`

- Tip: to make a clean tressitter parser installation remove the folder.

</details>

## Vim Cheatsheets

<details open><summary></summary>

- [devhints.io/vim](https://devhints.io/vim) most used vim keys
- [viemu.com](http://www.viemu.com/a_vi_vim_graphical_cheat_sheet_tutorial.html) vim keys from A-Z
- [vscode with embedded neovim](https://www.youtube.com/watch?v=g4dXZ0RQWdw) youtube tutorial most of the keybindings are similar to archrice's neovim
- [treesitter text-objects demo](https://www.youtube.com/watch?v=FuYQ7M73bC0) youtube tutorial the keybindings are similar to archrice's neovim
- [treesitter text-objects extended](https://www.youtube.com/watch?v=CEMPq_r8UYQ) youtube tutorial the keybindings are similar to archrice's neovim
- [text-objects from A-Z](https://www.youtube.com/watch?v=JnD9Uro_oqc) youtube tutorial the keybindings are similar to archrice's neovim
- [motion-operators from A-Z](https://www.youtube.com/watch?v=HhZJ1kbzkj0) youtube tutorial the keybindings are the same as to archrice's neovim

</details>

## Related projects

<details open><summary></summary>

- [yeferyv/retronvim](https://github.com/yeferyv/retronvim) (minimal archrice for vscode) vscode extension with neovim text objects from A-Z + LSP whichkey + touchcursor keyboard layout
- [yeferyv/sixelrice](https://github.com/yeferyv/sixelrice) (minimal archrice for terminal/text interface) neovim text object from A-Z, based on [lazyvim](https://github.com/LazyVim/LazyVim)
- [yeferyv/dotfiles](https://github.com/yeferyv/dotfiles) (minimal archrice + keybindings for managing windows in any desktop environment) my dotfiles with archlinux, debian and windows support/installer
- [LukeSmithxyz/voidrice](https://github.com/LukeSmithxyz/voidrice) arch linux rice with dwm + lf [see dependencies](https://github.com/LukeSmithxyz/LARBS/blob/master/static/progs.csv)

</details>
