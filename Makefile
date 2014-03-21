# Makefile for creating our standalone Cython program

PYTHON=python
PYVERSION=$(shell $(PYTHON) -c "import sys; print(sys.version[:3])")

INCDIR=$(shell $(PYTHON) -c "from distutils import sysconfig; print(sysconfig.get_python_inc())")
PLATINCDIR=$(shell $(PYTHON) -c "from distutils import sysconfig; print(sysconfig.get_python_inc(plat_specific=True))")
LIBDIR1=$(shell $(PYTHON) -c "from distutils import sysconfig; print(sysconfig.get_config_var('LIBDIR'))")
LIBDIR2=$(shell $(PYTHON) -c "from distutils import sysconfig; print(sysconfig.get_config_var('LIBPL'))")
PYLIB=$(shell $(PYTHON) -c "from distutils import sysconfig; print(sysconfig.get_config_var('LIBRARY')[3:-2])")

CC=$(shell $(PYTHON) -c "import distutils.sysconfig; print(distutils.sysconfig.get_config_var('CC'))")
LINKCC=$(shell $(PYTHON) -c "import distutils.sysconfig; print(distutils.sysconfig.get_config_var('LINKCC'))")
LINKFORSHARED=$(shell $(PYTHON) -c "import distutils.sysconfig; print(distutils.sysconfig.get_config_var('LINKFORSHARED'))")
LIBS=$(shell $(PYTHON) -c "import distutils.sysconfig; print(distutils.sysconfig.get_config_var('LIBS'))")
SYSLIBS= $(shell $(PYTHON) -c "import distutils.sysconfig; print(distutils.sysconfig.get_config_var('SYSLIBS'))")

test: test.o
	mkdir dist
	$(LINKCC) -o dist/$@ $^ -L$(LIBDIR1) -L$(LIBDIR2) -l$(PYLIB) $(LIBS) $(SYSLIBS) $(LINKFORSHARED)
	cp my_lib.py dist/

# 測試 ./dist/test
# 當然你也可以考慮把 my_lib.py 單獨 compiler 成 .pyd 再放進來。就完全看不到 Python Code 了。

test.o: test.c
	$(CC) -c $^ -I$(INCDIR) -I$(PLATINCDIR)

test.c: test.pyx
	cython --embed test.pyx

all: test
	./dist/test

clean:
	@echo Cleaning Demos/embed
	@rm -f *~ *.o *.so core core.* *.c test test.output
	@rm -rf dist

# GCC Build 範本
# 	cython test.pyx --embed
# 	gcc -pthread -c test.c -I/usr/include/python2.7 -I/usr/include/python2.7
# 	gcc -pthread -o test test.o -L/usr/lib -L/usr/lib/python2.7/config -lpython2.7 -lpthread -ldl  -lutil -lm -Xlinker -export-dynamic -Wl,-O1 -Wl,-Bsymbolic-functions
# 	./test		# 執行
