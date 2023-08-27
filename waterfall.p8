pico-8 cartridge // http://www.pico-8.com
version 32
__lua__
 --waterfall (10/6/2022)
function _init()
 drops = {}
 splash = {}
 fish = {}
 clouds = {}
 
 fall_width = 30
 fall_height = 60
 fallx = 10
 fally = 10
 
 --functions for the rushing water effects
 function add_drop()
  add(drops, {
 		x = rnd(fall_width + 1) + fallx,
 		y = rnd(fall_height) + fally
 		})
 end
 
 for i=1,30 do
  add_drop()
 end
 
 function update_drops()
  for i in all(drops) do
   i.y = i.y + 3
   if i.y >= fally + fall_height then
    add_splash(i.x,i.y)
    i.x = rnd(fall_width + 1) + fallx
 		 i.y = fally
   end
  end
 end
 
 function draw_drops()
  for i in all(drops) do
   line(i.x,i.y,i.x,max(i.y-2, fally),7)
  end
 end
 
 --functions for the splash effects
 function add_splash(x,y)
  add(splash, {
 		x = x,
 		y = y,
 		vx = (rnd(4)-2)/2.5,
 		vy = (rnd(4)-5)/2,
 		life = 30
 		})
 end
 
 function update_splash()
  for i in all(splash) do
   i.life = i.life - .5
   i.vy = i.vy + .1/2
   i.x = i.x + i.vx/2
   i.y = i.y + i.vy/2
  end
  
  for i=#splash,1,-1 do
   if splash[i].life <= 0 then
    del(splash, splash[i])
   end
  end
  
 end
 
 function draw_splash()
  for i in all(splash) do
   circfill(i.x,i.y,min(i.life/2,3),7)
  end
 end
 
 
 function add_fish()
  add(fish,{
  x = rnd(64)+32,
  y = rnd(64)+66,
  vx = 0,
  vy = 0,
  })
 end
 
 for i=1,20 do
  add_fish()
 end
 
 function update_fish()
  for i in all(fish) do
   i.x = i.x + i.vx
   i.y = i.y + i.vy
   i.vx = i.vx*.98 + (rnd(2)-1)/10
   i.vy = i.vy*.9 + (rnd(2)-1)/10
   
   if i.y < 66 then
    i.y = 67
    i.vy = .2
   elseif (i.y - 64) * (i.y -64)
    + (i.x-65) * (i.x-65) >= 60*60 - 3 then
    
    local run_s = i.x - 64 
    local rise_s = i.y - 64
    
    i.x = i.x - run_s/30
    i.y = i.y - rise_s/30
    
    i.vx = 0
    i.vy = 0
   end
  end
 end
 
 function draw_fish()
  for i in all(fish) do
   line(i.x, i.y, i.x-1, i.y,9)
  end
 end
 
 function add_cloud()
  add(clouds, {
 		x = rnd(128),
 		y = rnd(64),
 		l = rnd(15)+10,
 		s = rnd(1)+1
 	})
 end
 
 for i=1,30 do
  add_cloud()
 end
 
 function update_clouds()
  for i in all(clouds) do
   i.x = i.x+i.s
   if i.x > 128+25 then
 		i.x = 0
 		i.y = rnd(64)
 		i.l = rnd(15)+10
 		i.s = rnd(1)+1
   end
  end
 end
 
 function draw_clouds()
  for i in all(clouds) do
   line(i.x,i.y,i.x-i.l,i.y,7)
  end
 end
 
end

function _update60()

 update_drops()
 
 update_splash()
 
 update_fish()
 
 update_clouds()
 
end

function _draw()
 cls(3) 
 
 --basic shapes
 circfill(64,64,60,1)
  
 rectfill(0,0,128,64,13)
 
 draw_clouds()
 
 rectfill(40,8,50,64,5)
 rectfill(0,8,9,64,5)
 
 --waterfall
 rectfill(10,10,40,70,1)
 
 draw_drops()
 
 draw_fish()
 
 draw_splash()
 
 print(#splash)

end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
