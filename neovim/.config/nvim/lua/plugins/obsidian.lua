return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
	},

	opts = {
		workspaces = {
			{
				name = "default",
				path = "~/Dropbox/notes/notes/",
			},
		},
		notes_subdir = "Notes",

		-- Optional, set the log level for obsidian.nvim. This is an integer corresponding to one of the log
		-- levels defined by "vim.log.levels.*".
		-- log_level = vim.log.levels.INFO,

		daily_notes = {
			-- Optional, if you keep daily notes in a separate directory.
			folder = "Daily Notes",
			-- Optional, if you want to change the date format for the ID of daily notes.
			date_format = "%Y-%m-%d",
			-- Optional, if you want to change the date format of the default alias of daily notes.
			-- alias_format = "%B %-d, %Y",
			-- Optional, default tags to add to each new daily note created.
			-- default_tags = { "daily-notes" },
			-- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
			template = "daily_notes_template",
		},

		-- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
		completion = {
			-- Set to false to disable completion.
			nvim_cmp = true,
			-- Trigger completion at 2 chars.
			min_chars = 2,
		},

		templates = {
			folder = "/home/sinisa/Dropbox/notes/notes/Templates/",
			date_format = "%Y-%m-%d",
			time_format = "%H:%M",
			-- A map for custom variables, the key should be the variable and the value a function
			substitutions = {},
		},

		mappings = {
			-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
			["gf"] = {
				action = function()
					return require("obsidian").util.gf_passthrough()
				end,
				opts = { noremap = false, expr = true, buffer = true },
			},
			-- 		-- Toggle check-boxes.
			-- 		["<leader>ch"] = {
			-- 			action = function()
			-- 				return require("obsidian").util.toggle_checkbox()
			-- 			end,
			-- 			opts = { buffer = true },
			-- 		},
			-- Smart action depending on context, either follow link or toggle checkbox.
			["<cr>"] = {
				action = function()
					return require("obsidian").util.smart_action()
				end,
				opts = { buffer = true, expr = true },
			},
		},

		new_notes_location = "notes_subdir",

		-- Optional, customize how wiki links are formatted. You can set this to one of:
		--  * "use_alias_only", e.g. '[[Foo Bar]]'
		--  * "prepend_note_id", e.g. '[[foo-bar|Foo Bar]]'
		--  * "prepend_note_path", e.g. '[[foo-bar.md|Foo Bar]]'
		--  * "use_path_only", e.g. '[[foo-bar.md]]'
		-- Or you can set it to a function that takes a table of options and returns a string, like this:
		wiki_link_func = function(opts)
			return require("obsidian.util").wiki_link_id_prefix(opts)
		end,

		-- Optional, customize how markdown links are formatted.
		markdown_link_func = function(opts)
			return require("obsidian.util").markdown_link(opts)
		end,

		-- Either 'wiki' or 'markdown'.
		preferred_link_style = "wiki",

		disable_frontmatter = true,

		-- Optional, customize how note IDs are generated given an optional title.
		---@param title string|?
		---@return string
		note_id_func = function(title)
			-- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
			-- In this case a note with the title 'My new note' will be given an ID that looks
			-- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
			local suffix = ""
			if title == nil then
				suffix = "untitled"
			else
				suffix = title
			end
			-- if title ~= nil then
			-- 	-- If title is given, transform it into valid file name.
			-- 	suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
			-- else
			-- 	-- If title is nil, just add 4 random uppercase letters to the suffix.
			-- 	for _ = 1, 4 do
			-- 		suffix = suffix .. string.char(math.random(65, 90))
			-- 	end
			-- end
			-- return tostring(os.time()) .. "-" .. suffix
			return suffix
		end,

		picker = {
			-- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
			name = "telescope.nvim",
			-- Optional, configure key mappings for the picker. These are the defaults.
			-- Not all pickers support all mappings.
			note_mappings = {
				-- Create a new note from your query.
				new = "<C-x>",
				-- Insert a link to the selected note.
				insert_link = "<C-l>",
			},
			tag_mappings = {
				-- Add tag(s) to current note.
				tag_note = "<C-x>",
				-- Insert a tag at the current location.
				insert_tag = "<C-l>",
			},
		},
		-- Optional, configure additional syntax highlighting / extmarks.
		-- This requires you have `conceallevel` set to 1 or 2. See `:help conceallevel` for more details.
		ui = {
			enable = false, -- set to false to disable all additional syntax features
			checkboxes = {},
			bullets = {},
		},

		-- Specify how to handle attachments.
		attachments = {
			-- The default folder to place images in via `:ObsidianPasteImg`.
			-- If this is a relative path it will be interpreted as relative to the vault root.
			-- You can always override this per image by passing a full path to the command instead of just a filename.
			img_folder = "Notes/Attachments", -- This is the default
		},
	},

	config = function(_, opts)
		require("obsidian").setup(opts)
		vim.keymap.set("n", "<leader>nf", ":ObsidianQuickSwitch<CR>", { desc = "[N]otes [F]ind" })
		vim.keymap.set("n", "<leader>ns", ":ObsidianSearch<CR>", { desc = "[N]otes [S]earch" })
		vim.keymap.set("n", "<leader>nt", ":ObsidianToday<CR>", { desc = "[N]ote [T]oday" })
		vim.keymap.set("n", "<leader>nn", ":ObsidianNew ", { desc = "[N]ote [N]ew note" })
	end,
}
