# coding:utf-8

cdef extern from "math.h":
    double sin(double x)   

cpdef invoke_c():
    print sin(10)  # invoke C Function by main.py test_cy.test_by_extern()

cpdef test_echo_lib2():
    print 'import by pyximport; pyximport.install()...'
