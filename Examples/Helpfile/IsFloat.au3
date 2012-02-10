IsFloat(3.14159) ; Returns 1
IsFloat(3.000) ; Returns 0 as the value is an integer i.e. 3
IsFloat(1 / 2 - 5) ; Returns 1
IsFloat(1.5e3) ; Returns 0 as 1.5e3 is equal to 1500.
IsFloat("12.345") ; Returns 0 as the value is a string.
