local bint = require 'bint'(24576)    

function sqrt(x, ndigits)
    local sqrtx = bint.ipow(10, ndigits-2)*85
    repeat
        sqrtxh = sqrtx
        sqrtx = (5*(sqrtx + (x // sqrtx)))//10
    until sqrtx == sqrtxh
    
    return sqrtx
end


local function gauss(ndigits)
    ndigits = ndigits + ndigits // 600 + 2
    local one = bint.ipow(10, ndigits)
    sqrt2 = sqrt(2*one*one, ndigits)

    a = {bint.ipow(10, ndigits)}
    b = {bint.ipow(10, ndigits)*bint.ipow(10, ndigits) // sqrt2}
    t = {bint.ipow(10, ndigits) // 4}
    p = {bint.ipow(10, ndigits)}
    i = 1
    repeat
        i = i + 1

        a[i] = (a[i-1]+b[i-1]) // 2

        b[i] = sqrt(a[i-1]*b[i-1], ndigits)

        r = (a[i-1]-a[i])*(a[i-1]-a[i])
        t[i] = t[i-1]-((p[i-1]*r) // one) //one

        p[i] = 2*p[i-1]
        
    
    until a[i] == a[i-1] and b[i] == b[i-1]
    
    mypi = ((a[i]+b[i])*(a[i]+b[i])) // (4*t[i])
    mypi = tostring(mypi)
    mypi = mypi:sub(1,1) .. '.' .. mypi:sub(2, ndigits - (ndigits // 600 + 2) + 1)
    
    return mypi
    
end



pi = gauss(1600)

print(pi)

