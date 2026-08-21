return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			local function apply_palette()
				local palette_path = vim.fn.stdpath("config") .. "/lua/dms-palette.lua"
				local ok, palette = pcall(dofile, palette_path)
				if not ok or type(palette) ~= "table" then
					palette = {
						base00 = "#0f1417",
						base01 = "#1b2024",
						base02 = "#262b2f",
						base03 = "#8a9198",
						base04 = "#c0c7cd",
						base05 = "#dfe3e7",
						base06 = "#edf1f6",
						base07 = "#ffffff",
						base08 = "#ff729f",
						base09 = "#ffaf9f",
						base0A = "#fff672",
						base0B = "#78f186",
						base0C = "#8dcff1",
						base0D = "#72bee4",
						base0E = "#1a526f",
						base0F = "#8dcff1",
					}
				end

				require("base16-colorscheme").setup(palette)

				vim.api.nvim_set_hl(0, "Visual", { bg = palette.base02, fg = palette.base07, bold = true })
				vim.api.nvim_set_hl(0, "Statusline", { bg = palette.base0D, fg = palette.base00 })
				vim.api.nvim_set_hl(0, "LineNr", { fg = palette.base03 })
				vim.api.nvim_set_hl(0, "CursorLineNr", { fg = palette.base0C, bold = true })

				vim.api.nvim_set_hl(0, "Statement", { fg = palette.base0E, bold = true })
				vim.api.nvim_set_hl(0, "Keyword", { link = "Statement" })
				vim.api.nvim_set_hl(0, "Repeat", { link = "Statement" })
				vim.api.nvim_set_hl(0, "Conditional", { link = "Statement" })

				vim.api.nvim_set_hl(0, "Function", { fg = palette.base0D, bold = true })
				vim.api.nvim_set_hl(0, "Macro", { fg = palette.base0D, italic = true })
				vim.api.nvim_set_hl(0, "@function.macro", { link = "Macro" })

				vim.api.nvim_set_hl(0, "Type", { fg = palette.base0C, bold = true, italic = true })
				vim.api.nvim_set_hl(0, "Structure", { link = "Type" })

				vim.api.nvim_set_hl(0, "String", { fg = palette.base0B, italic = true })
				vim.api.nvim_set_hl(0, "Operator", { fg = palette.base05 })
				vim.api.nvim_set_hl(0, "Delimiter", { fg = palette.base05 })
				vim.api.nvim_set_hl(0, "@punctuation.bracket", { link = "Delimiter" })
				vim.api.nvim_set_hl(0, "@punctuation.delimiter", { link = "Delimiter" })

				vim.api.nvim_set_hl(0, "Comment", { fg = palette.base03, italic = true })
			end

			apply_palette()

			-- Live file watcher for hot-reloading Neovim theme on wallpaper change
			local palette_file = vim.fn.stdpath("config") .. "/lua/dms-palette.lua"
			if not _G._dms_palette_watcher then
				local uv = vim.uv or vim.loop
				_G._dms_palette_watcher = uv.new_fs_event()
				_G._dms_palette_watcher:start(
					palette_file,
					{},
					vim.schedule_wrap(function()
						apply_palette()
					end)
				)
			end
		end,
	},
}
