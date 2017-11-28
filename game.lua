--Load the composer library which is used for creating scenes/menus
local composer = require( "composer" )
local scene = composer.newScene()

--Load the physics library
local physics = require( "physics" )

local options = 
{
	frames = 
	{
		--Frame 1 (Reaper1-1)
		{
			x = 0,
			y = 0,
			width = 160,
			height = 160,
		},
		--Frame 2 (Reaper1-2)
		{
			x = 160,
			y = 0,
			width = 160,
			height = 160,
		},
		--Frame 3 (Reaper1-3)
		{
			x = 320,
			y = 0,
			width = 160,
			height = 160,
		},
		--Frame 4 (Reaper1-4)
		{
			x = 480,
			y = 0,
			width = 160,
			height = 160,
		},
		--Frame 5 (Reaper2-1)
		{
			x = 640,
			y = 0,
			width = 160,
			height = 160,
		},
		--Frame 6 (Reaper2-2)
		{
			x = 800,
			y = 0,
			width = 160,
			height = 160,
		},
		--Frame 7 (Reaper2-3)
		{
			x = 0,
			y = 160,
			width = 160,
			height = 160,
		},
		--Frame 8 (Reaper2-4)
		{
			x = 160,
			y = 160,
			width = 160,
			height = 160,
		},
		--Frame 9 (Reaper3-1)
		{
			x = 320,
			y = 160,
			width = 168,
			height = 162,
		},
		--Frame 10 (Reaper3-2)
		{
			x = 0,
			y = 358,
			width = 168,
			height = 168,
		},
		--Frame 11 (Reaper3-3)
		{
			x = 168,
			y = 358,
			width = 168,
			height = 180,
		},
		--Frame 12 (Reaper3-4)
		{
			x = 336,
			y = 358,
			width = 168,
			height = 198,
		},
		--Frame 13 (Reaper3-5)
		{
			x = 504,
			y = 358,
			width = 168,
			height = 226,
		},
		--Frame 14 (Reaper3-6)
		{
			x = 672,
			y = 358,
			width = 168,
			height = 226,
		},
		--Frame 15 (Reaper3-7)
		{
			x = 840,
			y = 358,
			width = 168,
			height = 226,
		},
		--Frame 16 (Reaper3-8)
		{
			x = 0,
			y = 584,
			width = 168,
			height = 226,
		},
		--Frame 17 (Reaper3-9)
		{
			x = 168,
			y = 584,
			width = 168,
			height = 226,
		},
		--Frame 18 (Reaper3-10)
		{
			x = 488,
			y = 160,
			width = 168,
			height = 198,
		},
		--Frame 19 (Reaper3-11)
		{
			x = 656,
			y = 160,
			width = 180,
			height = 187,
		},
		--Frame 20 (Reaper3-12)
		{
			x = 836,
			y = 160,
			width = 168,
			height = 162,
		}
	},
	sheetContentWidth = 1024,
	sheetContentHeight = 1024
}
--Set physics and gravity
physics.start()
physics.setGravity( 0, 100 )

--Seed the random number generator
math.randomseed( os.time() )

local player = graphics.newImageSheet( "reaper.png", options )
local sequence_runningReaper = 
{
	{
		name = "running",
		start = 1,
		count = 4,
		time = 1000,
		loopCount = 0,
		loopDirection = "forward"
	},

	{
		name = "jump",
		frames = { 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20 },
		time = 1000,
		loopCount = 0,
		loopDirection = "forward"
	}
}

function scene:create( event )
	local sceneGroup = self.view
	
	--Load the main parts of the display
		local floorCollisonFilter = { categoryBits = 1, maskBits = 6}
		local redCollisionFilter = { categoryBits = 2, maskBits = 3}
		local blueCollisionFilter = { categoryBits = 4, maskBits = 5}

		local background = display.newImageRect( "1Background.png", 1500, 900 )
		background.x = display.contentCenterX
		background.y = display.contentCenterY

		local platform = display.newImage( "4Platform.png", display.contentWidth, display.contentHeight )
		platform:scale( .6, .6 )
		--platform:setFillColor( 150,0,0 )
		platform.x = display.contentWidth -900
		platform.y = display.contentHeight -150
		platform.myName = "platform"

		local platform3 = display.newImage( "4Platform.png", display.contentWidth, display.contentHeight )
		platform3:scale( .6, .6 )
		platform3.x = display.contentWidth -500
		platform3.y = display.contentHeight -150

		local platform2 = display.newImage( "platform1.png", display.contentWidth, display.contentHeight )
		platform2:scale( .06, .8 )
		platform2.x = display.contentWidth +900
		platform2.y = display.contentHeight -700
		platform2.y = 50

		local reaper = display.newSprite( player, sequence_runningReaper )
		--reaper.gravity = -6
		--reaper.accel = 0
		reaper:play( )
		reaper.x = display.contentWidth -1000
		reaper.y = display.contentHeight -300
		reaper.myName = "reaper"

		local collisionDetector = display.newRect( reaper.x + 80, reaper.y - 28, 5, 130 )
		collisionDetector:setFillColor( 1, 0, 1 )
		collisionDetector.alpha = 1.0

		local collisionDetector2 = display.newRect( reaper.x + 1, reaper.y + 50, 100, 2.5 )
		collisionDetector2:setFillColor( 1, 0, 1 )
		collisionDetector2.alpha = 1.0

		local speed = 1
		--local reaperr = reaper.y

	--Start with Math calculations
		local function update( event )
			speed = speed + 0.5
			--update background
			updateBackgrounds()
		end

		function updateBackgrounds()

			platform.x = platform.x -(4)
			platform3.x = platform3.x - (4)
			if ( platform.x < -500 ) then
				platform.x = 1400
			end
			if ( platform3.x < -500 ) then
				platform3.x = 1400
			end
			--This line of code controls platform movement 
			--Change the number inside parenthesis to change speed higher number mean faster
			--The minus sign makes the object move to the left
			
			platform2.x = platform2.x - (speed/55)
			--if platform is at top then it moves to bottom
			if( platform2.x < -500 ) then
				platform2.x = 1200
				platform2.y = platform2.y + 50
				--if platform is at the top then it moves to the bottom
				if ( platform2.y == 700 ) then
					platform2.y = 50
				end
			end


			physics.addBody( platform, "static", {bounce = 0} )
			physics.addBody( reaper, "dynamic", { radius=0, bounce=0} )
			physics.addBody( platform3, "static", {bounce = 0} )

			--print( platform.y )
			--print (reaperr)
			--Onground = false
			--fnction checkCollisions()
				
				
				--This will check the collisionDetector if it has collided with anything so we know if the player lost
				--for a = 1, platform, 1 do
					--if (collisionDetector.y -10 > platform.y - 170 and platform.x < reaper.x + 60 and platform.x > reaper.x - 60) then
						--reaper.y = platform.y - 171
						--Onground = true
						--speed = 0
					--end
				--end
				
				--This will check if reaper has already jumped if so we  will use this for a later bit of code to limit to single jumping
				--for a = 1, platform, 1 do
					--if (reaper.y <= platform.y + reaperr) then
						--OnGround = true
						--if (Onground)then
							--print( "1" )
						--end
						--break
					--end
				--end
			--end
			--fnction updateReaper( event )
				--if ( event.phase == "begen" ) then
					--reaper:setSequence( "running" )
					--reaper:play()
				--else
					--reaper:setSequence( "jump" )
					--reaper:play()
				--end
				--if (reaper.accel > 0) then
					--reaper.accel = reaper.accel - 1
				--end
				--reaper.y = reaper.y - reaper.accel
				--reaper.y = reaper.y - reaper.gravity
				
			--end
		
			function onLocalCollision( event )
				--if (event == "began") then
					--local obj1 = event.object2
					--local obj2 = event.object2
						--if ( obj1 == obj2 ) then
					--if(OnGround) then
						reaper:setLinearVelocity( 0, -1000 )
						--reaper.accel = reaper.accel + 20
						--end
				--elseif ( event.phase == "ended") then
				
				--end
			end
			collisionDetector.y = reaper.y
			collisionDetector2.y = reaper.y + 83
			--reaper.collision = onLocalCollision
			--reaper:addEventListener( "collision" )
			--platform.collision = onLocalCollision
			--platform:addEventListener( "collision" )
			Runtime:addEventListener( "tap", onLocalCollision, -1 )
		end

		--This calls the update function
		timer.performWithDelay( 1, update, -1 )
	
	
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