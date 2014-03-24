# coding:utf-8
# 說明：介紹多文件編譯範本。
# ref: http://stackoverflow.com/questions/11698482/project-structure-for-wrapping-many-c-classes-in-cython-to-a-single-shared-obj/11804020#11804020
# ref: https://github.com/cython/cython/wiki/PackageHierarchy

from distutils.core import setup
from Cython.Build.Dependencies import Extension  # 多檔處理必須引入
from Cython.Build import cythonize

# the mudule name must fit the contains array first file name.
# 各模組可以指定用 c++ 以 code 方式編譯, 不指定為 c。
extensions = [
    Extension('test2' ,["test2.pyx"]),  # 產出 test2.pyd(by c)
    Extension('my_lib' ,["my_lib.pyx","my_lib_plugin.pyx"], language="c++"),  # 產出 my_lib.pyd(由 2 個檔案組成, by c++)
                                                                              # my_lib.pyx 包含一個 #include "my_lib_plugin.pyx" 敘述！
]

setup(
    ext_modules = cythonize(extensions)
)
