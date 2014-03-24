# coding:utf-8

# 可以使用類似 c 的 #include 但是 setup.py 內記得要設定編譯項目。
# 如果沒有 my_lib_plugin_A('plugin invoked!') 將拋錯！
include "my_lib_plugin.pyx"

def test2(url):
	import urllib2
	return urllib2.urlopen(url).read()

def echo(msg):
	print msg
	return msg

def call_plugin():
	my_lib_plugin_A('plugin invoked!')
