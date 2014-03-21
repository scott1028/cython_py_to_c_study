# coding:utf-8

def test(url):
	import urllib2
	return urllib2.urlopen(url).read()

def echo(msg):
	print msg
	return msg
