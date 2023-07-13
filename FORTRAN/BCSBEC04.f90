program BCSBEC03
    implicit none
    real*8 :: h, Finta, Fintb, Fintc, Ginta, Gintb, Gintc, f, g, t, deltaa, deltab, deltac, mua, mub ,muc, mu, delta, mux, deltax
    real*8,parameter :: e=1.0d-6, a=1.0d-2, b=1.0d4, pi=acos(-1.0d0)
    integer,parameter :: N=1000000, L=22
    integer :: i, j

    !read(*,*) t
    open ( 10, file = 'BCSBEC05.dat')
    h = (b-a)/dble(N)
    mu = 1.0d0
    delta = 6.0d-1
    mux = 2.0d0
    deltax = -1.0d0
    do j = 1, L
        t = -1.0d-1 + dble(j-1)*1.0d-1
        mux = 2.0d0
        deltax = -1.0d0

        do while ( dabs(mu-mux) > e .or. dabs(delta-deltax) > e )
            !----------???????----------
            mua = 1.0d0
            mub = -6.0d0

            !???????
            Finta = (f(mua,delta,a)+f(mua,delta,b))/2.0d0
            Fintb = (f(mub,delta,a)+f(mub,delta,b))/2.0d0
            do i = 1, N-1
                Finta = Finta + f(mua,delta,a+dble(i)*h)
                Fintb = Fintb + f(mub,delta,a+dble(i)*h)
            end do
            Finta = Finta*h + pi*t
            Fintb = Fintb*h + pi*t
            if ( Finta*Fintb > 0.0d0 ) then
                write(*,*) '?????????????????',delta
                stop
            end if

            !??????????
            do while ( dabs(mua-mub) .GE. 1.0d-10 )
                !write(*,*) mua-mub
                muc = (mua+mub)/2.0d0
                Finta = (f(mua,delta,a)+f(mua,delta,b))/2.0d0
                Fintc = (f(muc,delta,a)+f(muc,delta,b))/2.0d0
                do i = 1, N-1
                    Finta = Finta + f(mua,delta,a+dble(i)*h)
                    Fintc = Fintc + f(muc,delta,a+dble(i)*h)
                end do
                Finta = Finta*h + pi*t
                Fintc = Fintc*h + pi*t
                if (Finta*Fintc < 0.0d0) then
                    mua = mua
                    mub = muc
                else
                    mua = muc
                    mub = mub
                end if
            end do

            !----------—??????----------
            deltaa = 1.0d-5
            deltab = 5.0d0

            !???????
            Ginta = (g(muc,deltaa,a)+g(muc,deltaa,b))/2.0d0
            Gintb = (g(muc,deltab,a)+g(muc,deltab,b))/2.0d0
            do i = 1, N-1
                Ginta = Ginta + g(muc,deltaa,a+dble(i)*h)
                Gintb = Gintb + g(muc,deltab,a+dble(i)*h)
            end do
            Ginta = Ginta*h - 4.0d0/3.0d0
            Gintb = Gintb*h - 4.0d0/3.0d0
            if ( Ginta*Gintb > 0.0d0 ) then
                write(*,*) '????????????????', muc
                stop
            end if

            !???????????
            do while ( dabs(deltaa-deltab) .GE. 1.0d-10 )
                !write(*,*) deltaa-deltab
                deltac = (deltaa+deltab)/2.0d0
                Ginta = (g(muc,deltaa,a)+g(muc,deltaa,b))/2.0d0
                Gintc = (g(muc,deltac,a)+g(muc,deltac,b))/2.0d0
                do i = 1, N-1
                    Ginta = Ginta + g(muc,deltaa,a+dble(i)*h)
                    Gintc = Gintc + g(muc,deltac,a+dble(i)*h)
                end do
                Ginta = Ginta*h - 4.0d0/3.0d0
                Gintc = Gintc*h - 4.0d0/3.0d0
                if (Ginta*Gintc < 0.0d0) then
                    deltaa = deltaa
                    deltab = deltac
                else
                    deltaa = deltac
                    deltab = deltab
                end if
            end do
            write(*,*) deltac,muc
            mux = mu
            mu = muc
            deltax = delta
            delta = deltac
        end do
        write(10,*) t, delta, mu
        write(*,*) t, delta, mu
    end do
    close (10)

end program