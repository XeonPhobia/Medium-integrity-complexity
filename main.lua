local function primify(a)
local n = {}
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
print(sum)
end

local function main()
a = 5678
n = primify(a)
for i = 1, #n do
  n[i] = divide(n[i])
end
local p
for i = 1, #n do
  if i == 1 then p = n[i] else p = p .. '*' .. n[i] end
end
print(p)
print(summary(p))
end
main()
