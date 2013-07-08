#!/usr/bin/env python
import shutil
import os

site_cookbooks = os.listdir('site-cookbooks')

with open('Cheffile', 'a') as fp:
    fp.write('####  Remove after test\n')
    for cookbook in site_cookbooks:
        fp.write('cookbook "%s",\n' % cookbook)
        fp.write('  :path => "./site-cookbooks/%s"\n' % cookbook)
        fp.write('\n')

shutil.copy2('Cheffile.lock', 'Cheffile.lock.bak')
