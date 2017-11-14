-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
local background = display.newImageRect( "background.png", 768, 1024)
background.x = display.contentCenterX
background.y = display.contentCenterY

local play = display.newImage ( "playbutton.png")
play.x = display.contentWidth - 250
play.y = display.contentHeight - 70
play:scale( .2, .2 )

local title = display.newImage( "title.png")
title.x = display.contentWidth -500
title.y = display.contentHeight - 400
title:scale( .4, .4 )

local function fade( event )
	transition.to( title, {time = 1000, alpha = 0})
	transition.to(play, {time = 1000, alpha = 0})
end

play:addEventListener( "tap", fade )
