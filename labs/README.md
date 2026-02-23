# Binary search

**Deadline: Friday, 2/20/2026**

Write concise comments in code.

## Learning Objectives

* Review RISC-V ISA, e.g., support for control flow and memory access 

* Implement nested functions and recursion

* Save/restore registers in a function

## Description

In this lab, we write function `binary_search` in RISC-V. An C implementation
of the function is at the bottom of this page. Translate the C code to RISC-V
assembly code. 

The skeleton code is in `lab4.s`. Function `binary_search` is located at the
end of the file, but it is currently empty.

There are some constraints/tips.  

1.  Follow the C code closely. Although binary search is simple, it is very
    easy to make mistakes if you have not written it many times.

2.  We keep variable `left` in register `s1` and keep other local variables in
    temporary registers. Think about why we need to keep `left`, but not other
    variables, in a saved register.

3.  There should be only one exit (one return instruction) in the function. In
    the C code, we use `goto f_exit` on purpose. With one exit, we do not have
    multiple copies of clean up code, e.g., restoring saved registers.  

4.  There is an IF-ELSEIF-ELSE structure. Write the outline first, without
    instructions in each branch. Follow the order of branches in C code: IF
    branch, then the ELSEIF branch, and finally the ELSE branch. It is easier
    to check the code this way. 

5.  There is only one LW instruction, for reading `a[half]`, between the code
    that saves/restores registers.

6.  During the execution of the program, examine how `ra` and `sp` registers
    are changed and what have been saved on the stack. It helps to understand
    how funciton and local storage work.

### Testing

The array used for testing has multiple of 10s between 0 and 990, inclusive.
Here are some inputs/outputs of the binary search function. Note the program
does NOT print anything. We check the return value in RARS in the Registers
tab.

```
0
0

460
46

990
99

45
-1

1000
-1

-3
-1
```

## Deliverables

Please submit "lab4.s" and take Lab 4 Quiz by the deadline.

In addition to the output, the auto grader also checks some values in registers
and in memory. For example, the value of `s1` should be preserved through the
function all.

## C code 

Here is the C code of the function.

``` C
int     binary_search(int a[], int n, int v)
{
    int     rv;

    if (n == 0) {           // nothing in the array
        rv = -1;
        goto  f_exit;       // return -1
    }

    int half = n / 2;       // integer division
    int half_v = a[half];

    if (half_v == v) {
        rv = half;
    }
    else if (v < half_v) {
        // search the first half, excluding a[half]
        rv = binary_search(a, half, v); 
    }
    else {  // v > half_v
        // search the second half, excluding a[half]
        int left = half + 1;

        // &a[left] means the address of a[left]
        rv = binary_search(&a[left], n - left, v);

        if (rv >= 0) {
            rv += left;
        }
    }

f_exit:
    return rv;
}

```
