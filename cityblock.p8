pico-8 cartridge // http://www.pico-8.com
version 32
__lua__
--[[
function _init()
 ptlist = {}
 ptlist2 = {}
 speed = 1
 xold = 0
 yold = 100
 dbt = 0
 
 while dbt <= 128 do
  
  xrand = flr(rnd(14))+dbt+4
  yrand = -(flr(rnd(16))+7)
  add(ptlist, {
  x = 0+dbt,
  y = 0
  })
  add(ptlist, {
  x = 0+dbt,
  y = yrand
  })
  add(ptlist, {
  x = xrand,
  y = yrand,
  })
  add(ptlist, {
  x = xrand,
  y = 0
  })
  
  dbt = xrand+(flr(rnd(6)))
 end
end

function _update60()

 for i in all(ptlist) do
   i.x -= speed
   if i.x < -18 then
   del(ptlist,i)
   end
 end
 dbt -= speed
 while dbt <= 128 do
  
  xrand = flr(rnd(14))+dbt+4
  yrand = -(flr(rnd(16))+5)
  add(ptlist, {
  x = 0+dbt,
  y = 0
  })
  add(ptlist, {
  x = 0+dbt,
  y = yrand
  })
  add(ptlist, {
  x = xrand,
  y = yrand,
  })
  add(ptlist, {
  x = xrand,
  y = 0
  })
  
  dbt = xrand+(flr(rnd(6)))
 end
end

function _draw()
 cls()
 print(dbt,0,0,3)
 xold = -1
 yold = 60
 for i in all(ptlist) do
  line(xold,yold,i.x,i.y+60,3)
  xold = i.x
  yold = i.y+60

 end

end
]]
-->8

function _init()
 ptlist = {}
 ptlist2 = {}
 ptlist3 = {}
 
 cloud_table = {{8,0,20,9},
 {8,14,20,7},{8,22,20,9},
 {31,1,19,10},{31,11,19,10},
 {31,23,19,10}}
 
 clist = {}
 for i=0,3 do
 add(clist, {
 info = cloud_table[flr(rnd(count(cloud_table))+1)],
 x = 50*i,
 y = rnd(30)+10
 }) 
 end
 
 ll = {ptlist,ptlist2,ptlist3}
 speed = 1
 xold = 0
 yold = 100
 
 for i in all(ll) do
  i.dbt = 0
  while i.dbt <= 128 do
   xrand = flr(rnd(13))+i.dbt+5
   yrand = -(flr(rnd(16))+7)
   add(i, {
   x = 0+i.dbt,
   y = 0
   })
   add(i, {
   x = 0+i.dbt,
   y = yrand
   })
   add(i, {
   x = xrand,
   y = yrand,
   })
   add(i, {
   x = xrand,
   y = 0
   })
   i.dbt = xrand+(flr(rnd(6)))
   end
  end
end

function _update60()
 ptlist.speed = speed*.4
 ptlist2.speed = speed*.7
 ptlist3.speed = speed*1
 
 for x in all(ll) do
 x.dbt -= x.speed
 for i in all(x) do
   i.x -= x.speed
   if i.x < -18 then
   del(x,i)
   end
 end
 end
 
  for i in all(ll) do
  while i.dbt <= 128 do
   xrand = flr(rnd(14))+i.dbt+4
   yrand = -(flr(rnd(16))+7)
   add(i, {
   x = 0+i.dbt,
   y = 0
   })
   add(i, {
   x = 0+i.dbt,
   y = yrand
   })
   add(i, {
   x = xrand,
   y = yrand,
   })
   add(i, {
   x = xrand,
   y = 0
   })
   i.dbt = xrand+(flr(rnd(6)))
   end
  end
  
  for i in all(clist) do
   i.x -= speed*.6
   if i.x<-50 then
    del(clist,i)
    add(clist, {
     info = cloud_table[flr(rnd(count(cloud_table))+1)],
     x = 150,
     y = rnd(30)+10
     }) 
   end
  end
end

function _draw()
 cls()
 --[[
 for i in all(clist) do
  sspr(i.info[1],i.info[2],
  i.info[3],i.info[4],
  i.x,i.y,2*i.info[3],2*i.info[4])
 end
 
 rectfill(0,90,128,128,1)
 
 for x=0,2 do
 yst = 60+(x*15)
 
 rectfill(0,yst,128,yst+15,3-x)
 print(ll[x+1].dbt,0,6*x,3-x)
 
 xold = -1
 yold = yst
 for i in all(ll[x+1]) do
  line(xold,yold,i.x,i.y+yst,3-x)
  if i.y < yst then
   rectfill(xold,yst,i.x,i.y+yst,3-x)
  end
  xold = i.x
  yold = i.y+yst
 end
 end
 
end

__gfx__
00000000000000000000007077770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000777770000000000000000007777777700000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000777777777770000000000000777777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000077777777777777770000000777777777777000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000007777777777777000000000077700000077777000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700777777770007777777000007777777777777770000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000007777777777777000000000777777777777000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000007777777770000000007777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000007777700000000077777777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000077777000000007000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000777777700077700000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000007777770007770000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000077777770007770000000000000077777777000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000777777777777777770000000000777777777770000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000777777777777777770000777777777777777700000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000007777777777777777700000077777777777777770000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000007777777777700000000077777770000777770000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000007000007777770000000000007777700007777000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000077700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000777000000777770000000077770000770000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000077777770000007777700000777777007777000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000007777700000077777770000077777777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000777777700000000000777777700000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000007777777777770000000077777777777700000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000077777777700000000007777777777770000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000077777770000000000000000777777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000777777770000000000000007770007077700000000000000000000000000000000000000000000000000000000000000000000000000000000