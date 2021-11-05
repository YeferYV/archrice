require'cmp'.setup {
 sources = {
	{ name = 'cmp_tabnine' },
 },
}

local tabnine = require('cmp_tabnine.config')
tabnine:setup({
        max_lines = 1000;
        max_num_results = 20;
        sort = true;
	run_on_every_keystroke = true;
	snippet_placeholder = '..';
})