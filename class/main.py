# coding:utf-8

import test_cy

print test_cy.echo()

print test_cy.echo2()

# print test_cy.echo3()

print test_cy.echo5()

print test_cy.ee

print dir(test_cy)

import pyximport; pyximport.install()
import lib2	 # import 時後才編譯成 pyd

import pdb; pdb.set_trace()

