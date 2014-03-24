# coding:utf-8

try:
    import my_lib
except Exception:
    pass

def run_for_test2(x):
    print x, 'i run in test2'

# 遞迴展開目錄
def scan_dir(path):
    import glob
    files = glob.glob(path+'/*')
    if len(files) == 0:
        return len(files)
    else:
        for i in files:
            l = scan_dir(i)
            print i


        return len(files)

if __name__ == '__main__':
    scan_dir('.')
    