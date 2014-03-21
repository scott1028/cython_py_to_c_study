# coding:utf-8

from distutils.core import setup
from Cython.Build import cythonize

setup(
    ext_modules = cythonize("my_lib.py")
)

# 多檔案處理( Multiple Cython Files in a Package )
# 	To automatically compile multiple Cython files without listing all of them explicitly, you can use glob patterns:
	
# 	setup(
# 	    ext_modules = cythonize("package/*.pyx")
# 	)
# 	You can also use glob patterns in Extension objects if you pass them through cythonize():
	
# 	extensions = [Extension("*", "*.pyx")]
	
# 	setup(
# 	    ext_modules = cythonize(extensions)
# 	)
