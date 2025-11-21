return {
    "echasnovski/mini.nvim",
    version = "*",

    config = function()
        require("mini.completion").setup {}

        require("mini.move").setup {
            mappings = {
                left = "<A-left>";
                right = "<A-right>";
                up = "<A-up>";
                down = "<A-down>";

                line_left = "<A-left>";
                line_right = "<A-right>";
                line_up = "<A-up>";
                line_down = "<A-down>";
            }
        }

        require("mini.statusline").setup {
            use_icons = false;
        }

        require("mini.comment").setup {
            mappings = {
                comment = "<Leader>/";
                comment_line = "<Leader>//";
                comment_visual = "<Leader>/";
                textobject = "<Leader>/";
            }
        }
    end
}
