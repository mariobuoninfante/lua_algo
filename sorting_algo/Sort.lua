-- sort algorithms

local Sort = {}

function Sort.selection(T, direction)
   -- args: T = table to sort; direction = 0/1 ascending/descending  
    
   -- check 'direction' variable and create a 'compare' function
   direction = direction or 0  
   local compare = function (a, b) return a < b end
   if direction == 1 then
      compare = function (a, b) return a > b end
   end
   -- get table size
   local N = #T 
   local min_max = 1
   -- re-order the table
   for i = 1, N do 
      min_max = i
      for j = i+1, N do 
	 -- find the min/max
	 if compare(T[j], T[min_max]) then 
	    min_max = j
	 end
      end
      T[i], T[min_max] = T[min_max], T[i]
   end
end

function Sort.insertion(T, direction)
   -- args: T = table to sort; direction = 0/1 ascending/descending  

   -- check 'direction' variable and create a 'compare' function
   direction = direction or 0  
   local compare = function (a, b) return a < b end
   if direction == 1 then
      compare = function (a, b) return a > b end
   end    
   -- get the length of the table
   local N = #T
   local j = 1
   for i = 2, N do
      j = i 
      -- sort all elements from ith to 1st
      while (j > 1 and compare(T[j],T[j-1])) 
      do 
	 T[j], T[j-1] = T[j-1], T[j]
	 j = j - 1
      end
   end
end

function Sort.shell(T, direction)
   -- args: T = table to sort; direction = 0/1 ascending/descending  

   -- check 'direction' variable and create a 'compare' function
   direction = direction or 0  
   local compare = function (a, b) return a < b end
   if direction == 1 then
      compare = function (a, b) return a > b end
   end    
   -- get the length of the table
   local N = #T
   local h = 1
   local j = 1
   while (h < N//3) do h = (3 * h) + 1 end
   while (h >= 1)
   do
      for i = h, N-1 do 
	 j = i
	 while (j >= h and compare(T[j+1], T[j-h+1]))
	 do 
	    T[j+1], T[j-h+1] = T[j-h+1], T[j+1]
	    j = j - h
	 end
      end
      h = h//3
   end
end


function Sort.merge(T, lo, mid, hi, direction)   
   -- merge 2 tables - used in mergesort()
   
   local direction  = direction or 0
   local compare = function (a, b) return a < b end
   if direction == 1 then
      compare = function (a, b) return a > b end
   end   
   -- get the lenght of the array
   local N = #T
   local A = {}    
   local i, j = lo, mid+1
   
   -- copy T[lo..hi] to A[lo..hi]
   for k, v in ipairs(T) do A[k] = v end

   -- merge back to T[lo..hi]
   for k = lo, hi do 
      if (i > mid) then 
	 T[k] =  A[j]
	 j = j + 1
      elseif (j > hi) then 
	 T[k] =  A[i]
	 i = i + 1
      elseif (compare(A[j], A[i])) then 
	 T[k] = A[j]
	 j = j + 1
      else 
	 T[k] = A[i]
	 i = i + 1 
      end
   end
end

function Sort.mergesort(T, ...)
   -- top-down mergesort
 
   local lo, hi, direction

   -- check the 'direction' arg and make sure doesn't get lost in the stack - ie always pass it over when calling mergesort()
   if #{...} == 1 then
      direction = ...
   else
      lo, hi, direction = ...
   end
   direction = direction or 0
   
   -- first call (no lo and hi args passed)
   if lo == nil or hi == nil then
      Sort.mergesort(T, 1, #T, direction)
      return 0
   end
   
   if hi <= lo then return 0 end

   local mid = lo + ((hi - lo) // 2)
   
   Sort.mergesort(T, lo, mid, direction) -- first half of the table
   Sort.mergesort(T, mid+1, hi, direction) -- second half of the table
   Sort.merge(T, lo, mid, hi, direction)
end

return Sort
