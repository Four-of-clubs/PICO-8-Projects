pico-8 cartridge // http://www.pico-8.com
version 32
__lua__
--font credit to audrey briggs 
--( https://www.instagram.com/reybauds/)


function _init()
stars = {}
leye = 0
buildings_lower = {}
buildings_upper = {}
building_distance = 10

//building id,width,hight
bidx = {31,8,17,90,103,44}
bidy = {25,14,7,13,13,3}
bidw = {12,9,14,11,14,12}

speed = 0
groundx = 0
hillx = 0

charlist = {}

frame = 0
framecap = 90

pointer = false

for i=1,50 do
 add(stars, {
 x = rnd(128),
 y = rnd(80),
 v = 1+rnd(2)
 })
end

for i=0,10 do
 add(buildings_lower, {
 x = i*14,
 id = flr(rnd(count(bidx)-2))+1,
 })
end
 
for i=0,10 do
 add(buildings_upper, {
 x = i*14+6,
 id = flr(rnd(count(bidx)-1))+2,
 })
end

--~~~~~~~~~~~~~~~~~~~~~~~~
function cleartext()
 charlist = {}
end

function addleter(x,y,id)
 add(charlist, {
 x = x,
 y = y,
 truey = y,
 id = id,
 ofs = #charlist
 })
end

textbase = "abcdefghijklmnopqrstuvwxyz"
function displaytext(x,y,text)
 origin = x
 for i = 1, #text do
    local c = sub(text,i,i)
    tempid = 0
    for j = 1, #textbase do
     local match = sub(textbase,j,j)
    	if match == c then
     	tempid = j
    	end
    end
    
    tempid -=1
    if tempid <16 then
     idx = 80 + 3*tempid
     idy = 32
    else
     idx = 80 + 3*(tempid-16)
     idy = 35
    end
    
    addleter(x, y, {idx,idy})
    
    x += 4
    if x>108 then
     x = origin
     y = y + 5
    end
 end

end

function text_buffer(text, counter)
 if counter < #text then
  pointer = false
  cleartext()
  counter = counter + .5
  while(sub(text,counter+2,counter+2)==" ") do
   counter += 1
  end
  displaytext(35,103, sub(text,1,counter))
 else
  pointer = true
 end
 return counter
end

--displaytext(35,103,
--"sometimes i wonder where all that confidence went")

function updatetext(frame)
 frame = frame
 for k in all(charlist) do
  if frame/framecap - (k.x/128) < .5 
  or frame/framecap - (k.x/128) > 1.5 then
   k.y = k.truey+2- sin(frame/framecap - (k.x/128))*1.9
  else
   k.y = k.truey+2
  end
 end
 
 
end

function disp_textbox()
 pal(6,0)
 sspr(80,40,8,8,10,99,8,8,false,false)
 sspr(80,40,8,8,10,116,8,8,false,true)
 sspr(80,40,8,8,110,99,8,8,true,false)
 sspr(80,40,8,8,110,116,8,8,true,true)
 rectfill(18,101,110,121, 6)
 rectfill(12,107,115,115, 6)
 
 rectfill(18,99,110,100,1)
 rectfill(18,122,110,123,1)
 rectfill(10,107,11,115,1)
 rectfill(116,107,117,115,1)
 pal()
 pal(8,0)
 sspr(24,32,42-25,48-32,
 15,103)
 pal()

 if pointer then
  if flr(frame/20)%2==0 then
	  sspr(88,0,6,5,108,117)
	 else
	  sspr(88,0,6,5,108,118)
	 end
 else end
end

--~~~~~~~~~~~~~~~~~~~~~~~~

end

counter = 0
function _update60()
 frame = frame+1<framecap*2 and frame+1 or 0
 --updatetext(frame)

 counter = text_buffer(
 "sometimes i wonder where all that     confidence went",counter)
 
 updatetext(frame)

 groundx+=(speed/1.5)
 hillx += (speed/3)

 //leye = 5*speed
 
 for i in all(stars) do
  i.x -= (speed/2)*(i.v+2)
  i.x = (i.x)%128
 end
 
 for i in all(buildings_lower) do
  i.x -= (speed/4)
  if i.x <=-15 then
   i.x = ((i.x)%140)+14
  end
  if i.x > 140 and speed<0 then
  	i.x = ((i.x)%140)-14
  end
 end
 
 for i in all(buildings_upper) do
  i.x -= (speed/4)
  if i.x <=-15 then
   i.x = ((i.x)%140)+14
  end
  if i.x > 140 and speed<0 then
  	i.x = ((i.x)%140)-14
  end
 end
 
 if btn(1) then
  speed += .007
 end
 
 if btn(0) then
  speed -= .007
 end
 
 if btn(2) then
  speed = 0
 end
 
 if btn(3) then
  counter = 0
 end
end

function _draw()
cls()

//road?
rectfill(0,85- 10,128,98,1)

//stars
len = speed*3
for i in all(stars) do
 line(i.x,i.y,i.x+len,i.y,7)
end

//upper buildings
for i in all(buildings_upper) do
 sspr(bidx[i.id],bidy[i.id],
 bidw[i.id],32-bidy[i.id],
 i.x,90-(32-bidy[i.id])- 10)
end

//lower buildings
for i in all(buildings_lower) do
 sspr(bidx[i.id],bidy[i.id],
 bidw[i.id],32-bidy[i.id],
 i.x,98-(32-bidy[i.id]) - 10)
end

//low hill things
for i=0,5 do
  sspr(56,2,29,5,
  ((29*i-hillx)%174)-29,95 - 10)
end

//ground 
--
for i=0,16 do
 spr(20,i*8,100- 10)
 for s=0,4 do
  spr(36,i*8,108+(s*8)- 10)
 end
end
 

 
 //rude bunny
 pal(8,0)
 sspr(5,32,18,32,
 20,75 - 10)
 //line((28-groundx),83,
 //(28-groundx+leye),83,14)
 pal()
 
 
 //textbox
 disp_textbox()
 
 pal(8,7)
 for k in all(charlist) do
  sspr(k.id[1], k.id[2],3,3,k.x,k.y)
 end
 pal()
 --print(stat(7))
 --print(frame/framecap)
 
 
end
__gfx__
00000000777777770000000000000000000000000000000000000000000000000000000000000000000000007777500000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000775000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000005550000000022200000003300000050000000000000000000000000000000000000
00077000000000000000000000000000000000000000000008800000002225555003330222220000033330000000000000000000000000000000000000000000
000770000000000000000000000000000000000000000000dddd0000322222555533333232222055333333000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000dd55dd000322222225533333333222553333333000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000dddddddd00332222255553333333225553333333000000000000000000000000000000000000000000
000000000000000004ddddddddd4000000000000000000dd5555dd00332222255555333332255555333333000000000000000000000000000000000000000000
00000000000000000ddddddddddd55406666666600000dddddddddd0000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000ddaaadaaadd55501116111100000ddadaadadd0000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000ddddddddddd5a501161111100000daadaadaad0000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000ddddddddddd5a501161111100000daadaadaad0000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000ddaaadaaadd55501611111100000daadaadaad0000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000ddddddddddd5a501611111100000dddddddddd000000000000000000000000000000000000000ddd0000000000055550000000000000000
00000000455555540ddddddddddd5a506111111100000dddddddddd0000000000000000000000000000000000000ddaaadd00000005500005500000000000000
000000005aa555555ddaaadaaadd55506666666600000dddddddddd000000000000000000000000000000000000daaaaaaad0000050770000050000000000000
0000000055555aa55ddddddddddd55505555555500000daadaadaad00000000000000000000000000000000000daaa555aaad000500700000005000000000000
00000000555555555ddddddddddd5a505555555500000daadaadaad00000000000000000000000000000000000daa55555aad000500000003005000000000000
000000005aa555555ddaaadaaadd5a505555555500000daadaadaad00000000000000000000000000000000000ddd55555ddd005033833300383500000000000
0000000055555aa55ddddddddddd55505555555500000daadaadaad00000000000000000000000000000000000ddd55555ddd00533c333338333500000000000
00000000555555555ddddddddddd5a505555555500000dddddddddd00000000000000000000000000000000000daaa55aaadd005555333c33555500000000000
000000005aa555555ddaaadaaadd5a505555555500000dddddddddd00000000000000000000000000000000000ddaa555aadd005dd55555555dd500000000000
0000000055555aa55ddddddddddd55505555555500000dddddddddd00000000000000000000000000000000000ddd55555ddd0005ddd5665ddd5000000000000
00000000555555555ddddddddddd55505555555500000daadaadaad00000000000000000000000000000000000ddaa555aadd0005ddd5665ddd5000000000000
000000005aa555555ddaaadaaadd5a500000000000000daadaadaad00000000000000000000000000000000000ddaa555aadd00005dd5665dd50000000000000
0000000055555aa55ddddddddddd5a500444444440000daadaadaad00000000000000000000000000000000000ddd55555ddd00005dd5665dd50000000000000
00000000555555555ddddddddddd55504444444444000daadaadaad00000000000000000000000000000000000ddaa555aadd000005d5665d500000000000000
000000005aa555555ddaaadaaadd5a504aaa66aaa4000dddddddddd00000000000000000000000000000000000ddaaa55aaad000005d5665d500000000000000
0000000055555aa55ddddddddddd5a544aaa66aaa4400dddddddddd00000000000000000000000000000000000ddd55555ddd000005d5665d500000000000000
00000000555555555ddddddddddd555066a6666a66000daaaddaaad00000000000000000000000000000000000ddd5aaa5ddd00005dd5555dd50000000000000
00000000555555555ddddddddddd55506666776666000daaddddaad00000000000000000000000000000000000dd55aaa55dd0005ddd5665ddd5000000000000
00000000555555555ddddddddddd5550666677666600dddddddddddd0000000000000000000000000000000000dd5aaaaa5dd005555556655555500000000000
00000000880880000000000011155555555551110000000000000000000000880000000000000000008800088008800888880800888080808800088080088088
00000008558558000000000011558858855555110000000000000000000008558000000000000000088088800880880880808888080008880800880808808088
00000087758775800000000015585585585555510000000000000000000087755800000000000000808088088880888800888808888888808888800808880800
00000087765675800000000055877557658555550000000000000000000087766580000000000000880088088080808808800808808880000000000000000000
00000008775665800000000055877665658555550000000000000000000008776588800000000000880800080888808808880080080080000000000000000000
00000000876666680000000055587765658555550000000000000000000000876666680000000000008800880080088080088808080088000000000000000000
00000000876666680000000055558766666855550000000000000000000000876666668000000000000000000000000000000000000000000000000000000000
00000008776666658000000055558766666685550000000000000000000008776655566800000000000000000000000000000000000000000000000000000000
00000008766666658000000055587755566558550000000000000000000008766652e66800000000011111110000000000000000000000000000000000000000
00000008766666658000000055587652266228550000000000000000000008766652266800080000111111110000000000000000000000000000000000000000
00000008766666668000000055587652e66e28550000000000000000000008766655566800868000111766660000000000000000000000000000000000000000
00000008776666668000000055587655566558550000000000000000000008776666668008668000117666660000000000000000000000000000000000000000
0000000087766668000000005558776666668555000000000000000000000087766668008e768000116666660000000000000000000000000000000000000000
000000000876668000000000155587766668555100000000000000000000000876668008e2280000116666660000000000000000000000000000000000000000
000000000088880000000000115558766685551100000000000000000000000088880008e2280000116666660000000000000000000000000000000000000000
00000000088e28800000000011155588885551110000000000000000000000088e28888e22800000116666660000000000000000000000000000000000000000
000000008ee2222800000000000000000000000000000000000000000000008eee2228e228000000000000000000000000000000000000000000000000000000
000000088e22222880000000000000000000000000000000000000000000008e2222282280000000000000000000000000000000000000000000000000000000
000000082e22222280000000000000000000000000000000000000000000008e2222282800000000000000000000000000000000000000000000000000000000
000000082e22222280000000000000000000000000000000000000000000008e2222288000000000000000000000000000000000000000000000000000000000
000000082e22222280000000000000000000000000000000000000000000008e2222280000000000000000000000000000000000000000000000000000000000
000000008e22222878000000000000000000000000000000000000000000008ee222280000000000000000000000000000000000000000000000000000000000
0000000088e22227780000000000000000000000000000000000000000000008ee82280000000000000000000000000000000000000000000000000000000000
000000008222222880000000000000000000000000000000000000000000008e8822280000000000000000000000000000000000000000000000000000000000
0000000086ddddd8000000000000000000000000000000000000000000000086ddddd80000000000000000000000000000000000000000000000000000000000
0000000086ddddd8000000000000000000000000000000000000000000000086ddddd80000000000000000000000000000000000000000000000000000000000
0000000086dd8dd8000000000000000000000000000000000000000000000086dd8dd80000000000000000000000000000000000000000000000000000000000
0000000086dd8dd8000000000000000000000000000000000000000000000086dd8dd80000000000000000000000000000000000000000000000000000000000
0000000086d88d88000000000000000000000000000000000000000000000086d88d880000000000000000000000000000000000000000000000000000000000
000000008e28822800000000000000000000000000000000000000000000008e2882280000000000000000000000000000000000000000000000000000000000
00000000822282228000000000000000000000000000000000000000000000822282228000000000000000000000000000000000000000000000000000000000
00000000088818880000000000000000000000000000000000000000000000088818880000000000000000000000000000000000000000000000000000000000
__sfx__
001800001102013020110200000011020000001102014020180201702018020000001802000000100200000011020130201102000000110200000011020140201802017020180200000018020000001002000000
01180000110201402017020000001702000000180201b0201c0201b0001c020000001c020000001c0201b0201c020000000000000000000000000000000000000000000000000000000000000000000000000000
011800001c5001c510000001d51020510235102451024510245102451000500235102451023510245102451021510005002151024510285102751000500275200050027520005002752000500275252700000000
011800000050000500005001c5101d5101d5101d51000500005001c5101d5101c5001d5001f5101d5101a5101b5101c510005001d510005001d510005001d5101f5101f510005001951018510195101b5101c510
__music__
01 00034344
01 00024344
00 01424344
