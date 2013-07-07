#!/usr/bin/env python
import shutil

with open('Cheffile', 'a') as fp:
    fp.write('####  Remove after test\n')
    fp.write('cookbook "monitor",\n')
    fp.write('  :path => "./site-cookbooks/monitor"\n')
    fp.write('\n')

shutil.copy2('Cheffile.lock', 'Cheffile.lock.bak')
