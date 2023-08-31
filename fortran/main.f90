program lolcat
    implicit none

    type :: t_rgb
        integer :: r, g, b
    end type t_rgb
    
    character(len=1), parameter :: esc = achar(27)
    real, parameter :: pi = acos(-1.0)
    real, parameter :: freq = 0.1

    integer :: i, imax
    character(len=1) :: c
    ! NOTE: string has a maximum length after which it gets truncated, but this should be enough for the repo's goal
    character(len=256) :: arg
    type(t_rgb) :: col

    if (iargc() > 0) then
        call getarg(1, arg)
        
        imax = len(trim(arg))
        
        do i = 1, imax
            c = arg(i:i)
            col = rainbow(freq, i)

            call putc_with_rgb(c, col)
        end do
    end if
contains
    type(t_rgb) function rainbow(frequency, j) result(res)
        real, intent(in) :: frequency
        integer, intent(in) :: j

        real :: r, g, b

        r = sin(frequency * j) * 127 + 128
        g = sin(frequency * j + 2 * pi / 3) * 127 + 128
        b = sin(frequency * j + 4 * pi / 3) * 127 + 128

        res = t_rgb(int(r), int(g), int(b))
    end function rainbow

    integer function count_digits(num)
        integer, intent(in) :: num

        if (num < 10) then
            count_digits = 1
        else if (num < 100) then
            count_digits = 2
        else if (num < 256) then
            ! NOTE: no need to check 'num < 1000' as color can only be in range [0, 255]
            count_digits = 3
        end if
    end function count_digits

    subroutine putc_with_rgb(char, color)
        character(len=1), intent(in) :: char
        type(t_rgb), intent(in) :: color

        integer :: cr, cg, cb
        character(len=3) :: sr, sg, sb

        write (sr, "(i0)") color%r
        write (sg, "(i0)") color%g
        write (sb, "(i0)") color%b

        cr = count_digits(color%r)
        cg = count_digits(color%g)
        cb = count_digits(color%b)

        write (*, "(11a)", advance="no") esc, "[38;2;", sr(1:cr), ";", sg(1:cg), ";", sb(1:cb), "m", char, esc, "[0m"
    end subroutine putc_with_rgb
end program lolcat