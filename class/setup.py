from distutils.core import setup

from Cython.Build import cythonize

setup(
	name = 'cython-lab',
	ext_modules = cythonize(['*.pyx']),
)

# Command:
# 	python setup.py build_ext --inplace
