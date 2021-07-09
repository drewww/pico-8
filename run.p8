pico-8 cartridge // http://www.pico-8.com
version 32
__lua__


function _init()
	player = {}
	player.x = 3
	player.y = 3

	player.facing_x = 0
	player.facing_y = 0
	player.speed = 1

 -- stores the movement sets. nested, first layer is player speed
 -- second layer is button index

	mov = {
		{{x=-1,y=0, facing_x=-1, facing_y=0, key=0, speed=2},
			{x=1,y=0, facing_x=1, facing_y=0, key=1, speed=2},
			{x=0,y=-1, facing_x=0, facing_y=-1, key=2, speed=2},
 		{x=0,y=1, facing_x=0, facing_y=1, key=3, speed=2}},

		{{x=-1,y=1, facing_x=-1, facing_y=0, key=0, speed=2},
			{x=1,y=1, facing_x=1, facing_y=0, key=1, speed=2},
			{x=0,y=1, facing_x=0, facing_y=1, key=2, speed=1},
			{x=0,y=2, facing_x=0, facing_y=1, key=3, speed=3}}
			,

		{{x=-1,y=2, facing_x=0, facing_y=1, key=0, speed=2},
			{x=1,y=2, facing_x=0, facing_y=1, key=1, speed=2},
			{x=0,y=3, facing_x=0, facing_y=1, key=2, speed=3},
			{x=0,y=2, facing_x=0, facing_y=1, key=3, speed=2}}
		}

end


function _update()

	local x=0
	local y=0
	local speed=1
	-- move based on current move set matrix

	for i=0,3,1 do
		if (btnp(i)) then
			x+=mov[player.speed][i+1].x
			y+=mov[player.speed][i+1].y

			speed=mov[player.speed][i+1].speed
		end
	end

	if(x != 0 or y !=0) then
		move(x,y,speed)
	end
end

function move(x,y,speed)
	-- apply move
	-- test passability of target
	-- in future, will need to test passability of
	-- all intermediate tiles
	target={}
	target.x=player.x + x
	target.y=player.y + y

	passable = not fget(mget(target.x,target.y),0)

	if (passable) then
		player.facing_x = x
		player.facing_y = y

		player.x+=x
		player.y+=y

		player.speed = speed
	end
end


function _draw()
	cls()
	map(0,0,0,0,16,16)
	spr(1,player.x*8,player.y*8) -- don't love the magic 8

	local facing_spr=0
	if(player.facing_x == 1) then facing_spr = 1 end
	if(player.facing_x == -1) then facing_spr = 2 end
	if(player.facing_y == 1) then facing_spr = 3 end
	if(player.facing_y == -1) then facing_spr = 4 end


	if(facing_spr!=0) then
		spr(1+facing_spr,player.x*8,player.y*8)
	end
	-- speed indicator show here


 -- draw movement keypad
	for i=1, #mov[player.speed], 1 do
		if(i!=5 and mov[player.speed][i].key != nil) then
			 spr(mov[player.speed][i].key+6,(player.x+mov[player.speed][i].x)*8,(player.y+mov[player.speed][i].y)*8)
		end
	end
	-- debug vis

	print(player.x,0,0)
	print(player.y,16,0)
	print(player.speed, 32,0)
end
__gfx__
00000000007007000000008000000080000000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000777777000000008000008000000080800000808000b00000000b000000bb000000bb000000000000000000000000000000000000000000000000000
00700700070770700000008000000080000000800000000000bb00000000bb0000bbbb00000bb000000000000000000000000000000000000000000000000000
0007700007777770000000000000000000000000000000000bbbbbb00bbbbbb00bbbbbb0000bb000000000000000000000000000000000000000000000000000
0007700000666600000000000000000000000000000000000bbbbbb00bbbbbb0055bb5500bbbbbb0000000000000000000000000000000000000000000000000
00700700006666000000000000000000000000000000000005bb55500555bb50000bb00005bbbb50000000000000000000000000000000000000000000000000
000000000060060000000000000000000000000000000000005b00000000b500000bb000005bb500000000000000000000000000000000000000000000000000
00000000006006000000000000000000000000000000000000050000000050000005500000055000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77777777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77777777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77777777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77777777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77777777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77777777001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77777777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77777777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
4040404040404040404040404040404042000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4041414141414141414141414141414042000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4041414141414141414141414141414042000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4041414141414141414141414141414000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4041414141414141414141414141414000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4041414141414141414141414141414000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4041414141414141414141414141414000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4041414141414141414141414141414000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4041414141414141414141414141414000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4041414141414141404040404141414000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4041414141414141404040404141414000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4041414141414141404040404141414000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4041414141414141414141414141414000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4041414141414141414141414141414000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4041414141414141414141414141414000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4040404040404040404040404040404000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
