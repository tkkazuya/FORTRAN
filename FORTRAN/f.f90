real*8 function f(x,y,z)
real*8 :: x, y, z

    f = (dsqrt(z))/(dsqrt((z-x)**2+y**2))-1.0d0/sqrt(z)

return
end