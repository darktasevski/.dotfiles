## VIM config
#### Requirements: VIM 7.4+, CURL
#### Installation

Run vim, press enter.

Whait till plugins install, enjoy.

### Some useful VIM tips and tricks

##### Find and process
+ Delete all lines containing 'pattern':

    `:g/pattern/d`

+ Delete all lines that do not contain a 'pattern':

    `:g!/pattern/d`

+ Multiple [search patterns](http://vim.wikia.com/wiki/Search_patterns), TLDR: `\|` - OR, `\&*.` - AND

    Delete all lines that do not contain 'pattern1' or 'pattern2:

    `:g!/pattern1\|p   attern2/d`

+ Find and replace in file:

    `:%s/search/replace/g`

    `gI` - case sensetive,

    `gc` - confirm every instance before replacing.

+ Find and replace for specific lines:

    `:6,10s/search/replace/g`

##### Working with window splits

+ Make all horizontal splits vertical.

    `:windo wincmd K`

+ Make all vertical splits horizontal.

    `:windo wincmd H`

##### Quick editing

+ Edit string inside '' ((), {}, ..., etc.)

    `ci'`

+ Write file [with sudo](https://stackoverflow.com/questions/2600783/how-does-the-vim-write-with-sudo-trick-work).

    `:w !sudo tee %`

+ Delete up to (not including) <char>

    `dt<char>` or `dT<char>` for backward direction.

+ Copy up to (not including) <char>

    `yt<char>`

+ Copy number of characters on line in VISUAL mode.

    `y*select*y`

+ The * key will highlight all occurrences of the word that is under the cursor.
