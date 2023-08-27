pico-8 cartridge // http://www.pico-8.com
version 32
__lua__
--pond in the rain
--[[
function _init()
frame_count = 0
waves = {}
wave_effect(64,64)
end

function water_effects(x,y)
 line(x,y,x+10,y,7)
 line(x,y+3,x+13,y+3,7)
 line(x,y+6,x+10,y+6,7)
end

function wave_effect(x,y)
 add(waves,{ 
 x = x,
 y = y,
 r = 1,
 })
 
end

function _update60()
 frame_count += 1
 frame_count %= 60
 for i in all(waves) do
  i.r += 1
  if i.r >= 128 then
   del(waves,i)
  end
 end
 
 if frame_count%12==1 then
 wave_effect(rnd(192)-32,
 rnd(192)-32)
 end 
 
end

function _draw()
 cls()
 rectfill(0,0,128,128,12)
 --[[
 water_effects(20,20)
 water_effects(26,100)
 water_effects(90,45)
 ]]
 for i in all(waves) do
  circ(i.x,i.y,i.r,7)
 end
 
 

end
]]
-->8
--circle varriation
--[[
function _init()
pointx = 64
pointy = 64
frame_count = 0
waves = {}
wave_effect(64,64)
end

function water_effects(x,y)
 line(x,y,x+10,y,7)
 line(x,y+3,x+13,y+3,7)
 line(x,y+6,x+10,y+6,7)
end

function wave_effect(x,y,col)
 add(waves,{ 
 x = x,
 y = y,
 r = 1,
 col = col,
 })
 
end

function _update60()
 frame_count += 1
 frame_count %= 60
 for i in all(waves) do
  i.r += 1
  if i.r >= 128 then
   del(waves,i)
  end
 end
 
 pointx =64+ 20*cos(time()/3)
 pointy =64+20*sin(time()/3)
 
 if frame_count%12==1 then
 wave_effect(pointx,pointy,
 (8+frame_count/12))
 end 
 
end

function _draw()
 cls()
 --rectfill(0,0,128,128,12)
 --pset(pointx,pointy,8)
 --pset(64,64,8)
 --[[
 water_effects(20,20)
 water_effects(26,100)
 water_effects(90,45)
 ]]
 for i in all(waves) do
  circ(i.x,i.y,i.r,i.col)
 end

end
]]
-->8
--brook in the fall
--
function _init()
frame_count = 0
leaves = {}
waves = {}
--wave_effect(64,64)
leaves_col = {5,8,9,10}
end

function water_effects(x,y)
 line(x,y,x+10,y,7)
 line(x-1,y+3,x+13,y+3,7)
 line(x,y+6,x+10,y+6,7)
end

function new_leaf(x,y,bot)
 add(leaves, {
 f=flr(rnd(2))+1,
 vx = (rnd(1.5)-.75),
 x=x,
 y=y,
 bot=bot,
 col=leaves_col[flr(rnd(4)+1)]
 })
end

function wave_effect(x,y)
 add(waves,{ 
 x = x,
 y = y,
 r = 1,
 })
 
end

function _update60()
 frame_count += 1
 frame_count %= 60
 for i in all(waves) do
  i.r += 1
  if i.r >= 128 then
   del(waves,i)
  end
 end
 
 
 if frame_count%30==1 then
  new_leaf(rnd(128),-5,
  rnd(120)+8)
 end 
 
 for i in all(leaves) do
  if i.x <= -10 then
   del(leaves,i)
  end
 end
 
 for i in all(leaves) do
  if i.y < i.bot then
   i.y += 1
   i.x += i.vx
   if i.y >= i.bot then
    wave_effect(i.x,i.y+4)
   end
  else 
   i.x -= .5
  end
 end
 
end

function _draw()
 cls()
 rectfill(0,0,128,128,12)
 --
 water_effects(20,20)
 water_effects(26,100)
 water_effects(90,45)
 
 for i in all(leaves) do
  if i.y < i.bot then
   palt(1,true)
  end
  pal(3,i.col)
  spr(i.f,i.x,i.y)
  pal()
  palt()
 end
 
 for i in all(waves) do
  circ(i.x,i.y,i.r,7)
 end
 
 

end

-->8
--pond with better rain
--[[
function _init()
frame_count = 0
leaves = {}
waves = {}
--wave_effect(64,64)
leaves_col = {5,8,9,10}

num_second = 1
radius = 128
end

function water_effects(x,y)
 line(x,y,x+10,y,7)
 line(x,y+3,x+13,y+3,7)
 line(x,y+6,x+10,y+6,7)
end

function new_leaf(x,y,bot)
 add(leaves, {
 f=1,
 x=x,
 y=y,
 bot=bot
 })
end

function wave_effect(x,y)
 add(waves,{ 
 x = x,
 y = y,
 r = 1,
 })
 
end

function _update60()
 frame_count += 1
 frame_count %= 120
 
 if btn(1) and num_second < 30 then
  num_second += .25
 end
 
 if btn(0) and num_second > 1 then
  num_second -= .25
 end
 
 if btn(2) and radius < 128 then
  radius += 1
 end
 
 if btn(3) and radius > 1 then
  radius -= 1
 end
 
 //waves
 for i in all(waves) do
  i.r += 1
  if i.r >= radius then
   del(waves,i)
  end
 end
 
 fwait =flr(60/num_second)
 //leaves
 if frame_count%fwait==1 then
  new_leaf(rnd(128),-5,
  rnd(120)+8)
 end 
 
 for i in all(leaves) do
  if i.y < i.bot then
   i.y += 5
   if i.y >= i.bot then
    wave_effect(i.x,i.y)
    del(leaves, i)
   end
  end
 end
 
end

function _draw()
 cls()
 rectfill(0,0,128,128,12)
 --[[
 water_effects(20,20)
 water_effects(26,100)
 water_effects(90,45)
 ]]
 for i in all(leaves) do
  line(i.x,i.y,i.x,i.y-1,7)
 end
 
 for i in all(waves) do
  circ(i.x,i.y,i.r,7)
 end
 
 

end
]]
-->8
--rain on window
--[[
function _init()
frame_count = 0
drops = {}
streaks = {}
--wave_effect(64,64)
leaves_col = {5,8,9,10}

num_second = 1
radius = 128
end

function new_drop(x,y,bot)
 add(drops, {
 f=1,
 x=x,
 y=y,
 bot=bot
 })
end

function streak_effect(x,y)
 add(streaks,{ 
 x = x,
 y1 = y,
 y2 = y,
 })
 
end

function _update60()
 frame_count += 1
 frame_count %= 120
 
 if btn(1) and num_second < 30 then
  num_second += .25
 end
 
 if btn(0) and num_second > 1 then
  num_second -= .25
 end
 
 --[[
 if btn(2) and radius < 128 then
  radius += 1
 end
 
 if btn(3) and radius > 1 then
  radius -= 1
 end
 ]]
 
 //streak effects
 for i in all(streaks) do
  if i.y2 <128 then
   i.y2 += 1
  end
 end
 
 fwait =flr(60/num_second)
 
 //drops
 if frame_count%fwait==1 then
  new_drop(rnd(128),-5,
  rnd(120)+8)
 end 
 
 for i in all(drops) do
  if i.y < i.bot then
   i.y += 5
   if i.y >= i.bot then
    streak_effect(i.x,i.y)
    del(drops, i)
    sfx(0)
   end
  end
 end
 
end

function _draw()
 cls()
 rectfill(0,0,128,128,12)
 
 for i in all(drops) do
  line(i.x,i.y,i.x,i.y-1,7)
 end
 
 for i in all(streaks) do
  line(i.x,i.y1,i.x,i.y2,6)
 end
 
 for i=0,2 do
  rect(i,i,127-i,127-i,5)
 end

end
]]
-->8
--rain out window
--[[
function _init()
frame_count = 0
drops = {}
streaks = {}
--wave_effect(64,64)
leaves_col = {5,8,9,10}

num_second = 1
radius = 128
end

function new_drop(x,y,bot)
 add(drops, {
 f=1,
 x=x,
 y=y,
 bot=bot
 })
end

function streak_effect(x,y)
 add(streaks,{ 
 x = x,
 y1 = y,
 y2 = y,
 })
 
end

function _update60()
 frame_count += 1
 frame_count %= 120
 
 if btn(1) and num_second < 30 then
  num_second += .25
 end
 
 if btn(0) and num_second > 1 then
  num_second -= .25
 end
 
 --[[
 if btn(2) and radius < 128 then
  radius += 1
 end
 
 if btn(3) and radius > 1 then
  radius -= 1
 end
 ]]
 
 //streak effects
 for i in all(streaks) do
  --
 end
 
 fwait =flr(60/num_second)
 
 //drops
 if frame_count%fwait==1 then
  new_drop(rnd(128),-5,
  140)
 end 
 
 for i in all(drops) do
  if i.y < i.bot then
   i.y += 5
   if i.y >= i.bot then
    streak_effect(i.x,i.y)
    del(drops, i)
   end
  end
 end
 
end

function _draw()
 cls()
 rectfill(0,0,128,128,1)
 circfill(64,400,300,3)
 
 for i in all(drops) do
  rectfill(i.x,i.y,i.x+1,i.y-5,7)
 end
 
 --[[
 for i in all(streaks) do
 end
 ]]
 
 for i=0,2 do
  rect(i,i,127-i,127-i,5)
 end
 rectfill(0,63,128,65,5)

end
]]
__gfx__
00000000000300003000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000033000000330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700333000000333000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000331000000133000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000110000000011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
010100001103000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
