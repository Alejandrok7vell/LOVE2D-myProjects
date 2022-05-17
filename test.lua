tabla = {}

table.insert(tabla, 1)
table.insert(tabla, 2)
table.insert(tabla, 3)

table.remove(tabla, 1)

for index in ipairs(tabla) do
   print(tabla[index])
end

print(#tabla)