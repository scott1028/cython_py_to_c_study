# coding:utf-8

# as like c header file, in pyx file don not need be cimport

# test_cy.pxd ~= test_cy.h
# test_cy.pyx ~= test_cy.cpp
# two file will in same namespace.

# as decorator
import cython

# can not be see in python but c
cdef inline void echo4():
    print "echo in pxd"

# can be see in python
cpdef inline echo5():
    print "echo in pxd with cpdef"

@cython.final
cdef class A:
    cdef int a
    cdef int b  # 注意：沒有 cpdef , 所有 cpdef type 將被視為 cdef 。
    cpdef inline int cal(self, int x):
        self.b = 20
        print self.b
        print x
        return x + 100

# 如果從 pyx 移到 pxd 寫法將加上 @cythin.final、 inline keyword
@cython.final
cdef class BB:
    cpdef inline double eval(self, double x) except *:
        return x**2

# header (define interface, implement in .pyx file)
cdef class ball:
    cdef int x
    cdef int y
    cpdef echo(self)
    cdef echo2(self)
