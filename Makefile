# Makefile for creating our standalone Cython program
# 這邊必須使用 tab 縮排。

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

# ARCHFLAGS=-Wno-error=unused-command-line-argument-hard-error-in-future 

# all 就是 make 無帶任何參數的執行依據
all: test.o
	mkdir dist
	mkdir source_code
	mkdir obj
	@echo =========Debug Value=========
	@echo $@
	@echo $^
	@echo =========Debug Value=========
	$(LINKCC) -o dist/test $^ -L$(LIBDIR1) -L$(LIBDIR2) -l$(PYLIB) $(LIBS) $(SYSLIBS) $(LINKFORSHARED)
	@python setup.py build_ext --inplace
	@mv *.so dist/
	@mv *.c *.cpp source_code/
	@mv *.o obj/
	@echo 測試： ./dist/test
	@echo 備註：當然你也可以考慮把 my_lib.py 單獨 compiler 成 .pyd 再放進來。就完全看不到 Python Code 了。
	@echo 
	@echo test execute program....
	@dist/test

test.o: test.c
	$(CC) -c $^ -I$(INCDIR) -I$(PLATINCDIR)

test.c: test.pyx
	cython --embed test.pyx

clean:
	@echo Cleaning Demos/embed
	@rm -f *~ *.o *.so core core.* *.c test test.output
	@rm -rf dist
	@rm -rf source_code
	@rm -rf build
	@rm -rf obj

# GCC Build 範本
#   cython test.pyx --embed
#   gcc -pthread -c test.c -I/usr/include/python2.7 -I/usr/include/python2.7
#   gcc -pthread -o test test.o -L/usr/lib -L/usr/lib/python2.7/config -lpython2.7 -lpthread -ldl  -lutil -lm -Xlinker -export-dynamic -Wl,-O1 -Wl,-Bsymbolic-functions
#   ./test      # 執行
