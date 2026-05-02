return {
    "ahmedkhalf/project.nvim",
    init = function()
        -- Zakladni nastaveni spravce projektu
        require("project_nvim").setup {
            -- Detekce projektu podle pritomnosti .git slozky nebo Makefile atd.
            detection_methods = { "lsp", "pattern" },
            patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
        }

        local history = require("project_nvim.utils.history")
        local project = require("project_nvim.project")

        -- Vytvoreni vlastniho prikazu pro FZF hledani v projektech
        vim.api.nvim_create_user_command("ProjectFzf", function()
            local projects = history.get_recent_projects()

            require("fzf-lua").fzf_exec(projects, {
                prompt = "Projekty> ",
                actions = {
                    ["default"] = function(selected)
                        if selected and #selected > 0 then
                            local project_path = selected[1]
                            -- Prepnuti do slozky projektu a otevreni hledani souboru
                            if project.set_pwd(project_path, "fzf-lua") then
                                require("fzf-lua").files()
                            end
                        end
                    end
                }
            })
        end, {})
    end,
    -- Zkratka primo v definici pluginu (leader + fp)
    keys = {
        {
            "<leader>fp", "<cmd>ProjectFzf<CR>", desc = "Hledat v nedavnych projektech"
        }
    }
}
