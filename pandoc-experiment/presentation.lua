function getAllData(t, prevData)
  -- if prevData == nil, start empty, otherwise start with prevData
  local data = prevData or {}

  -- copy all the attributes from t
  for k,v in pairs(t) do
    data[k] = data[k] or v
  end

  -- get t's metatable, or exit if not existing
  local mt = getmetatable(t)
  if type(mt)~='table' then return data end

  -- get the __index from mt, or exit if not table
  local index = mt.__index
  if type(index)~='table' then return data end

  -- include the data from index into data, recursively, and return
  return getAllData(index, data)
end

return {
  {
    Str = function (elem)
        print(getAllData(elem, nil))
        print("str" .. tostring(elem))
    end,
    Header = function (elem)
      print(elem)
           if elem.class ~= nil then
       print(elem.class)
      if elem.class["pres"] ~= nil or elem.class["all"] ~= nil  then
        print ("inside")
        return elem
      else
        print ("return null")
        return Null
      end

end
    end,
  }
}