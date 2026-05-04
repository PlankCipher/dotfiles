return {
    'brenton-leighton/multiple-cursors.nvim',
    keys = {
        -- { '<C-p>',      'viw<Cmd>MultipleCursorsAddJumpPrevMatch<CR>', mode = 'n' },
        -- { '<C-n>',      'viw<Cmd>MultipleCursorsAddJumpNextMatch<CR>', mode = 'n' },
        { '<C-p>',      '<Cmd>MultipleCursorsAddJumpPrevMatch<CR>',    mode = { 'n', 'v' } },
        { '<C-n>',      '<Cmd>MultipleCursorsAddJumpNextMatch<CR>',    mode = { 'n', 'v' } },

        { '<C-k>',      '<Cmd>MultipleCursorsAddUp<CR>',               mode = 'n'          },
        { '<C-j>',      '<Cmd>MultipleCursorsAddDown<CR>',             mode = 'n'          },

        { '<leader>mc', '<Cmd>MultipleCursorsAddVisualArea<CR>',       mode = 'v'          },
    },
    opts = function()
        local mc = require('multiple-cursors')
        local vc = require('multiple-cursors.virtual_cursors')
        local search = require('multiple-cursors.search')
        local visual_mode_escape = require('multiple-cursors.visual_mode.escape')

        local add_cursor_and_move = function(move_fn)
            for _ = 1, vim.v.count1 do
                local pos = vim.fn.getcurpos()
                vc.add(pos[2], pos[3], pos[5], true)
                move_fn()
            end
        end

        local add_cursor_up = function()
            add_cursor_and_move(function() vim.cmd('normal! k') end)
        end

        local add_cursor_down = function()
            add_cursor_and_move(function() vim.cmd('normal! j') end)
        end

        local add_cursors_to_all_matches = function()
            local orig_get_matches_and_move_cursor = search.get_matches_and_move_cursor

            search.get_matches_and_move_cursor = function(p, _, u)
                return orig_get_matches_and_move_cursor(p, false, u)
            end

            mc.add_cursors_to_matches()

            search.get_matches_and_move_cursor = orig_get_matches_and_move_cursor
        end

        local get_vcs = function()
            local cursors = {}
            vc.visit_all_ignore_lock(function(c, _) table.insert(cursors, c) end)

            table.sort(cursors, function(a, b)
                return (a.lnum == b.lnum and a.col < b.col) or a.lnum < b.lnum
            end)

            return cursors
        end

        local is_cur_a_vc = function(cursors)
            if #cursors < 1 then return true end

            local cur_lnum = vim.fn.line('.')
            local cur_col  = vim.fn.col('.')
            for _, c in ipairs(cursors) do
                if c.lnum == cur_lnum and c.col == cur_col then
                    return true
                end
            end
            return false
        end

        local get_prev_vc = function()
            local cursors = get_vcs()
            local cur_lnum = vim.fn.line('.')
            local cur_col  = vim.fn.col('.')

            for i = #cursors, 1, -1 do
                local c = cursors[i]
                if (c.lnum == cur_lnum and c.col < cur_col) or c.lnum < cur_lnum then
                    return c
                end
            end

            return cursors[#cursors]
        end

        local get_next_vc = function()
            local cursors = get_vcs()
            local cur_lnum = vim.fn.line('.')
            local cur_col  = vim.fn.col('.')

            for _, c in ipairs(cursors) do
                if (c.lnum == cur_lnum and c.col > cur_col) or c.lnum > cur_lnum then
                    return c
                end
            end

            return cursors[1]
        end

        local jump_through_vcs = function(add_fn, jump_fn)
            local cursors = get_vcs()
            if add_fn then add_fn() end
            while not is_cur_a_vc(cursors) do jump_fn() end
        end

        local jump_to_prev_vc = function()
            jump_through_vcs(
                mc.add_cursor_and_jump_to_previous_match,
                mc.jump_to_previous_match
            )
        end

        local jump_to_next_vc = function()
            jump_through_vcs(
                mc.add_cursor_and_jump_to_next_match,
                mc.jump_to_next_match
            )
        end

        local jump_to_prev_vc_n = function()
            add_cursor_and_move(function()
                get_prev_vc():set_cursor_position()
            end)
        end

        local jump_to_next_vc_n = function()
            add_cursor_and_move(function()
                get_next_vc():set_cursor_position()
            end)
        end

        local skip_to_prev_vc = function()
            jump_through_vcs(nil, mc.jump_to_previous_match)
        end

        local skip_to_next_vc = function()
            jump_through_vcs(nil, mc.jump_to_next_match)
        end

        local skip_to_prev_vc_n = function()
            vc.remove_by_pos(vim.fn.line('.'), vim.fn.col('.'))
            get_prev_vc():set_cursor_position()
        end

        local skip_to_next_vc_n = function()
            vc.remove_by_pos(vim.fn.line('.'), vim.fn.col('.'))
            get_next_vc():set_cursor_position()
        end

        local skip_up = function()
            vc.remove_by_pos(vim.fn.line('.'), vim.fn.col('.'))
            vim.cmd('normal! k')
        end

        local skip_down = function()
            vc.remove_by_pos(vim.fn.line('.'), vim.fn.col('.'))
            vim.cmd('normal! j')
        end

        local align_v = function()
            local scol = vim.fn.col('v')
            local ecol = vim.fn.col('.')
            vim.cmd.normal({ string.format('%dh', ecol - scol) })

            visual_mode_escape.escape()

            vim.fn.feedkeys('=', 't')
        end

        return {
            remove_in_opposite_direction = false,
            enable_split_paste = true,
            match_visible_only = false,
            custom_key_maps = {
                { 'v', '<C-p>',   function() mc.add_cursor_and_jump_to_previous_match() end, 'nowrap' },
                { 'v', '<C-n>',   function() mc.add_cursor_and_jump_to_next_match()     end, 'nowrap' },
                { 'n', '<C-k>',   function() add_cursor_up()                            end, 'nowrap' },
                { 'n', '<C-j>',   function() add_cursor_down()                          end, 'nowrap' },
                { 'v', '<C-a>',   function() add_cursors_to_all_matches()               end, 'nowrap' },
                { 'v', '<C-[>',   function() jump_to_prev_vc()                          end, 'nowrap' },
                { 'v', '<C-]>',   function() jump_to_next_vc()                          end, 'nowrap' },
                { 'n', '<C-[>',   function() jump_to_prev_vc_n()                        end, 'nowrap' },
                { 'n', '<C-]>',   function() jump_to_next_vc_n()                        end, 'nowrap' },
                { 'v', '<C-{>',   function() skip_to_prev_vc()                          end, 'nowrap' },
                { 'v', '<C-}>',   function() skip_to_next_vc()                          end, 'nowrap' },
                { 'n', '<C-{>',   function() skip_to_prev_vc_n()                        end, 'nowrap' },
                { 'n', '<C-}>',   function() skip_to_next_vc_n()                        end, 'nowrap' },
                { 'v', '<C-S-q>', function() mc.jump_to_previous_match()                end, 'nowrap' },
                { 'v', '<C-q>',   function() mc.jump_to_next_match()                    end, 'nowrap' },
                { 'n', '<C-S-q>', function() skip_up()                                  end, 'nowrap' },
                { 'n', '<C-q>',   function() skip_down()                                end, 'nowrap' },
                { 'n', '=',       function() mc.align()                                 end           },
                { 'v', '=',       function() align_v()                                  end, 'nowrap' },
            },
        }
    end,
}
