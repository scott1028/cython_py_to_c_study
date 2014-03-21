# coding:utf-8

import my_lib

if __name__ == '__main__':
	print 'hello world'
	my_lib.echo('hi all...')
	try:
		print 'get url: http://www.youtube.com html file:'
		print my_lib.test('http://www.youtube.com')[0:100]
	except Exception:
		print 'no network!'

