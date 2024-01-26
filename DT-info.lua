-- Define constants for font properties
local FONT_NAME = "Consolas"
local FONT_SIZE = 17
local FONT_WEIGHT = 500

-- Create font using defined constants
local font = draw.CreateFont(FONT_NAME, FONT_SIZE, FONT_WEIGHT)

-- Calculate screen dimensions and text position
local screen_width, screen_height = draw.GetScreenSize()
local text_x, text_y = screen_width / 2, screen_height / 2 + 50

-- Function to draw shifted ticks
local function drawShiftedTicks()
    -- Set the font
    draw.SetFont(font)

    -- Get the current shifted ticks and the maximum shifted ticks
    local curr_shifted = warp.GetChargedTicks()
    local max_shifted = 23

    -- Format the text to display current and maximum shifted ticks
    local text = string.format("%d/%d", curr_shifted, max_shifted)
    local text_width = draw.GetTextSize(text)

    -- Draw the text in the center of the screen
    draw.Color(255, 255, 255, 255)
    draw.Text(text_x - (text_width / 2), text_y, text)
end

-- Function to check if double tap is active
local function isDoubleTapActive()
    local dt_mode = gui.GetValue("double tap")

    return dt_mode ~= "none"
end

-- Callback function for drawing
local function onDraw()
    local local_player = entities.GetLocalPlayer()
    if not local_player or not local_player:IsAlive() then
        return
    end
    if engine.IsGameUIVisible() or not isDoubleTapActive() then
        return
    end
    drawShiftedTicks()
end

-- Register the callback for drawing
callbacks.Register("Draw", "DrawShiftedTicks", onDraw)
