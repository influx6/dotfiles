This is supported in multicursor.nvim and is called disabling/enabling cursors. You can disable cursors, add new ones, delete the new ones, and enable the old ones. So it behaves like another layer of cursors.

There are the actions mc.disableCursors and mc.enableCursors.

I prefer using mc.toggleCursor instead of mc.disableCursors, since it will disable cursors if they are enabled but add/remove a disabled cursor if cursors are disabled.

Here is an example of how you would set it up:

-- press <c-q> at any time to disable cursors
-- if cursors are disabled, press <c-q> to add/remove a cursor.
set({"n", "v"}, "<c-q>", mc.toggleCursor)

set("n", "<esc>", function()
    if not mc.cursorsEnabled() then
        -- press escape to enable cursors again
        mc.enableCursors()
    elseif mc.hasCursors() then
        mc.clearCursors()
    else
        -- Default <esc> handler.
    end
end)
