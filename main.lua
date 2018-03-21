local function primify(a)
local n = {}
if a < 6 then n[1] = a return n; end
local i = 2

while i^2 <= a do
  while a%i==0 do 
    table.insert(n, i)
    a = a / i
  end
  i = i+1
end
if a > 1 then table.insert(n, a) end
for i = 1, #n - 1 do
  if n[i] == 2 and n[i + 1] == 2 then 
    n[i] = 4
    table.remove(n, i + 1) end
end
return n;
end

local function divide(a)
if type(a) ~= 'number' then print(type(a), a, "is not a number") return a; end
if a <= 6 then return a; end
local n = primify(a - 1)
local p = '(1+'
for i = 1, #n do
  if n[i] > 6 then n[i] = divide(n[i]) end
  if i == 1 then p = p .. n[i] else p = p .. '*' .. n[i] end
end
p = p .. ')'
  return p;
end

local function summary(line) 
if type(line) == 'number' then line = tostring(line) end 
local mapLine = {}
local s = 1
while true do
  table.insert(mapLine, tonumber(string.match(line, "%d+", s)))
  if not(line:find("%d", s)) then break else s = line:find("%d", s) + 1 end
end
local sum = 0
    for k,v in pairs(mapLine) do
        sum = sum + v
    end
return sum;
end

local function main()
pe = {sum = {1}, representation = {1}}
for a = 2, 1000 do
  pe.sum[a], pe.representation[a] = (function (a) local n = primify(a)
  for i = 1, #n do
    n[i] = divide(n[i])
  end
  local p
  for i = 1, #n do
    if i == 1 then p = n[i] else p = p .. '*' .. n[i] end
  end
  return summary(p), p;
end)(a)

  if pe.sum[a] > 1 + pe.sum[a - 1] then 
    pe.sum[a] = 1 + pe.sum[a - 1]
    pe.representation[a] = '1+' .. pe.representation[a - 1]  end
end 
--for i = 1, #pe.sum do
--  print(i, pe.sum[i], pe.representation[i])
--end 
numb = 0
for i = 1, #pe.sum do
  numb = numb + pe.sum[i]
end
print("1000 =", numb)
end
main()
