local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

local previewers = require("telescope.previewers")
local putils = require("telescope.previewers.utils")
local pfiletype = require("plenary.filetype")
local actions = require("telescope.actions")

local _bad = { ".*%.ex" }
local bad_files = function(filepath)
	for _, v in ipairs(_bad) do
		if filepath:match(v) then
			return false
		end
	end

	return true
end

local ignore_file_maker = function(filepath, bufnr, opts)
	opts = opts or {}
	if opts.use_ft_detect == nil then opts.use_ft_detect = true end
	opts.use_ft_detect = opts.use_ft_detect == false and false or bad_files(filepath)
	previewers.buffer_previewer_maker(filepath, bufnr, opts)
end

local regex_maker = function(filepath, bufnr, opts)
  opts = opts or {}
  if opts.use_ft_detect == nil then
    local ft = pfiletype.detect(filepath)
    -- Here for example you can say: if ft == "xyz" then this_regex_highlighing else nothing end
		if ft == "elixir" then
			opts.use_ft_detect = false
			putils.regex_highlighter(bufnr, ft)
		end
  end
  previewers.buffer_previewer_maker(filepath, bufnr, opts)
end

telescope.setup({
	defaults = {

		prompt_prefix = " ",
		selection_caret = " ",
		path_display = { "smart" },
		file_ignore_patterns = { "node_modules" },
		-- buffer_previewer_maker = regex_maker,
		preview = {
			treesitter = {
				elixir = false,
				heex = false
			}
		},

		mappings = {
			i = {
				["<C-n>"] = actions.cycle_history_next,
				["<C-p>"] = actions.cycle_history_prev,

				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,

				["<C-c>"] = actions.close,

				["<Down>"] = actions.move_selection_next,
				["<Up>"] = actions.move_selection_previous,

				["<CR>"] = actions.select_default,
				["<C-x>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,
				["<C-t>"] = actions.select_tab,

				["<C-u>"] = actions.preview_scrolling_up,
				["<C-d>"] = actions.preview_scrolling_down,

				["<PageUp>"] = actions.results_scrolling_up,
				["<PageDown>"] = actions.results_scrolling_down,

				["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
				["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
				["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
				["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
				["<C-l>"] = actions.complete_tag,
				["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
			},

			n = {
				["<esc>"] = actions.close,
				["<CR>"] = actions.select_default,
				["<C-x>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,
				["<C-t>"] = actions.select_tab,

				["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
				["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
				["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
				["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

				["j"] = actions.move_selection_next,
				["k"] = actions.move_selection_previous,
				["H"] = actions.move_to_top,
				["M"] = actions.move_to_middle,
				["L"] = actions.move_to_bottom,

				["<Down>"] = actions.move_selection_next,
				["<Up>"] = actions.move_selection_previous,
				["gg"] = actions.move_to_top,
				["G"] = actions.move_to_bottom,

				["<C-u>"] = actions.preview_scrolling_up,
				["<C-d>"] = actions.preview_scrolling_down,

				["<PageUp>"] = actions.results_scrolling_up,
				["<PageDown>"] = actions.results_scrolling_down,

				["?"] = actions.which_key,
			},
		},
	},
	pickers = {
		-- Default configuration for builtin pickers goes here:
		-- picker_name = {
		--   picker_config_key = value,
		--   ...
		-- }
		-- Now the picker_config_key will be applied every time you call this
		-- builtin picker
	},
	extensions = {
		-- Your extension configuration goes here:
		-- extension_name = {
		--   extension_config_key = value,
		-- }
		-- please take a look at the readme of the extension you want to configure
		media_files = {
			-- filetypes whitelist
			filetypes = { "png", "webp", "jpg", "jpeg" },
			find_cmd = "rg",
		},
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
		},
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
	},
})

telescope.load_extension("ui-select")
telescope.load_extension("fzf")
telescope.load_extension("media_files")
