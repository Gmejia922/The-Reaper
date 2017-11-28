-----------------------------------------------------------------------------------------
-- la danse macabre (music for game)
-- 
--
-----------------------------------------------------------------------------------------
local composer = require( "composer" )

local scene = composer.newScene()

function gotoGame()
	composer.gotoScene( "game" )
end

function scene:create( event )
	local sceneGroup = self.view

	local background = display.newImageRect( "1Background.png", 1500, 900 )
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	local platform = display.newImage( "1Platform.png", display.contentHeight, display.contentWidth )
	platform.x = display.contentWidth/2
	platform.y = display.contentHeight/2
	platform:scale( .5, .5 )

	local play = display.newImage( "1Play.png" )
	play.x = display.contentWidth -400
	play.y = display.contentHeight/2
	play:scale( .5, .5)

	local title = display.newImage( "1Title.png" )
	title.x = display.contentWidth -580
	title.y = display.contentHeight -380
	title:scale( .5, .5 )
 
 	local function fade( event )
		transition.to( title, {time = 1000, alpha = 0} )
		transition.to( play, {time = 1000, alpha = 0} )
	end

	play:addEventListener( "tap", fade )
	play:addEventListener( "tap", gotoGame )
end

function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then

	elseif ( phase == "did" ) then

	end
end

function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then

	elseif ( phase == "did" ) then

	end
end

function scene:destroy( event )

	local sceneGroup = self.view

end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
