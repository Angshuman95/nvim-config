local leap_status_ok, leap = pcall(require, 'leap')
if not leap_status_ok then
    return
end

leap.add_default_mappings()

local flit_status_ok, flit = pcall(require, 'flit')
if not flit_status_ok then
    return
end

flit.setup({
    keys = { f = 'f', F = 'F', t = 't', T = 'T' },
    -- A string like "nv", "nvo", "o", etc.
    labeled_modes = 'v',
    multiline = true,
    -- Like `leap`s similar argument (call-specific overrides).
    -- E.g.: opts = { equivalence_classes = {} }
    opts = {},
})
