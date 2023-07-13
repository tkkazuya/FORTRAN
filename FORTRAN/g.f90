real*8 function g(x,y,z)
real*8 :: x, y, z

    g = dsqrt(z)-(dsqrt(z)*(z-x))/(dsqrt((z-x)**2+y**2))

return
end