local tonumber = tonumber
local random   = require "resty.random".bytes
local var      = ngx.var

local defaults = {
    length = 6,
    header_name = var.session_header_uid
}

return function(session)
    -- local config = session or defaults
    -- local length = tonumber(config.length, 10) or defaults.length
    local length = defaults.length
    -- local uid = ngx.req.get_headers()[defaults.header_name] or ''
    local uid = ''
    if session.data and session.data.user then
        uid = session.data.user.email
    end
    local pad = random(length, true) or random(length)
    ngx.log(ngx.STDERR, "uid: " .. uid .. " pad: " .. pad)


    -- return uid if avalible with padding
    return (uid .. pad)
end
