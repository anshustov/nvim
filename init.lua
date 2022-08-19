-- сокращения переменных
local cmd = vim.cmd											-- для выполнения команд
local fn = vim.fn    										-- для вызова функций
local g = vim.g      										-- глобальные переменные
local opt = vim.opt  										-- настройки


--vim.opt.guifont = { "Hack:h12" }			-- шрифт Hack
vim.opt.guifont = { "MesloLGS NF:h12" }	-- шрифт MesloLGS
opt.mouse = "nvi"												-- поддержка мыши в режимах normal, visual, insert
opt.autoread = true											-- отслеживание изменений
opt.cursorline = true										-- подсветка строки с курсором
opt.encoding = "utf-8"									-- кодировка по умолчанию UTF8
opt.scrolloff = 5												-- при скролинке держать курсор в 5 строках от края
opt.ignorecase = true										-- поиск без учета регистра
opt.smartcase = true										-- если в поиске первая буква заглавная, то с учетом регистра
opt.splitbelow = true										-- новое окно снизу при разделении (:split или :sp или ctrl+w s)
opt.splitright = true										-- новое окно справа при разделении (:vsplit или :vs или ctrl+w v)
-- отступы
opt.autoindent = true										-- добавлять такой же отступ как в предыдущей строке
opt.smartindent = true									-- автоматически рааставляет отсупы
opt.smarttab = true											-- использует shiftwidth для отступов в начале строки
opt.tabstop = 2													-- ширина таба
opt.expandtab = false										-- при вставке заменяет табы пробелами
opt.shiftround = true										-- при сдвиге строки округляет отступ используя shiftwidth
opt.shiftwidth = 4											-- ширина сдвига строки

opt.termguicolors = true
--opt.background = 'dark'
--opt.hidden = true											-- разрешить скрытые буферы
opt.number = true												-- нумерация строк

-- комбинации для копирования вставки стандартными клавишами
vim.api.nvim_set_keymap("n", "<c-c>", '"*y :let @+=@*<CR>', {noremap=true, silent=true})
vim.api.nvim_set_keymap("n", "<c-v>", '"+p', {noremap=true, silent=true})

-- пакетный менеджер
cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
			
			-- Packer can manage itself
			use 'wbthomason/packer.nvim'
			
			-- плагины
			
			--тема srcery
			use {'srcery-colors/srcery-vim', as = 'srcery'}
			cmd 'let g:srcery_black="#000000"' 		-- черный фон
			cmd 'colorscheme srcery'
			
			-- иконки для разных плагинов
			use "kyazdani42/nvim-web-devicons"
			
			-- строка состояния lualine
			use {
				 'nvim-lualine/lualine.nvim',
				 requires = { 'kyazdani42/nvim-web-devicons', opt = true },

				 -- цвета строки состояния
				 config = function()
						-- цвета используе
						local colors = {
							 black        = '#000000',
							 white        = '#fce8c3',
							 red          = '#ef2f27',
							 green        = '#519f50',
							 blue         = '#2c78bf',
							 yellow       = '#fbb829',
						}
						
						-- определение локальной темы для строки состояния
						local theme = {
							 normal = {
									a = {bg = colors.green, fg = colors.black, gui = 'bold'},
									b = {bg = colors.black, fg = colors.white},
									c = {bg = colors.black, fg = colors.white}
							 },
							 insert = {
									a = {bg = colors.red, fg = colors.black, gui = 'bold'},
									b = {bg = colors.black, fg = colors.white},
									c = {bg = colors.black, fg = colors.white}
							 },
							 visual = {
									a = {bg = colors.blue, fg = colors.black, gui = 'bold'},
									b = {bg = colors.black, fg = colors.white},
									c = {bg = colors.black, fg = colors.white}
							 },
							 replace = {
									a = {bg = colors.yellow, fg = colors.black, gui = 'bold'},
									b = {bg = colors.black, fg = colors.white},
									c = {bg = colors.black, fg = colors.white}
							 },
							 command = {
									a = {bg = colors.yellow, fg = colors.black, gui = 'bold'},
									b = {bg = colors.black, fg = colors.white},
									c = {bg = colors.black, fg = colors.white}
							 },
							 inactive = {
									a = {bg = colors.yellow, fg = colors.black, gui = 'bold'},
									b = {bg = colors.black, fg = colors.white},
									c = {bg = colors.black, fg = colors.white}
							 }
						}
						
						require('lualine').setup
						{
							 options = {
									icons_enabled = true,
									theme = theme,
									component_separators = { left = '', right = ''},
									section_separators = { left = '', right = ''},
									disabled_filetypes = {
										 statusline = {},
										 winbar = {},
									},
									ignore_focus = {},
									always_divide_middle = true,
									globalstatus = false,
									refresh = {
										 statusline = 1000,
										 tabline = 1000,
										 winbar = 1000,
									}
							 },
							 sections = {
									lualine_a = {'mode'},
									lualine_b = {'branch', 'diff', 'diagnostics'},
									lualine_c = {'filename'},
									lualine_x = {'encoding', 'fileformat', 'filetype'},
									lualine_y = {'progress'},
									lualine_z = {'location'}
							 },
							 inactive_sections = {
									lualine_a = {},
									lualine_b = {},
									lualine_c = {'filename'},
									lualine_x = {'location'},
									lualine_y = {},
									lualine_z = {}
							 },
							 tabline = {},
							 winbar = {},
							 inactive_winbar = {},
							 extensions = {}
						}
				 end
			}

			-- подсветка кода
			use {
				 "nvim-treesitter/nvim-treesitter",
				 config = function()
						require("nvim-treesitter.configs").setup {
							 ensure_installed = "all",
							 highlight = {
									enable = true,
							 },
						}
				 end
			}

			-- библиотека для других плагинов
			use "nvim-lua/plenary.nvim"

			-- поиск в модальном окне
			use { "nvim-telescope/telescope.nvim",
						requires = { {"nvim-lua/plenary.nvim"} },
			}

			-- вывод подсказок комбинаций клавиш
			use {
				 "folke/which-key.nvim",
				 config = function()
						require("which-key").setup {}
				 end
			}

			-- панель каталога
			vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
			use {
				 "nvim-neo-tree/neo-tree.nvim",
				 branch = "v2.x",
				 requires = { 
						"nvim-lua/plenary.nvim",
						"kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
						"MunifTanjim/nui.nvim",
				 }
			}

			-- визуализация отступов линиями
			use "lukas-reineke/indent-blankline.nvim"

			-- автоматическое закрывание скобок
			use {
				 "windwp/nvim-autopairs",
				 config = function() require("nvim-autopairs").setup {} end
			}

			-- быстре коментированеи
			use {
				 'numToStr/Comment.nvim',
				 config = function()
						require('Comment').setup()
				 end
			}
end)

