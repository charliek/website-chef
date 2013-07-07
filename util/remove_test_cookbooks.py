#!/usr/bin/env python
import shutil

cheffile = ''
with open('Cheffile', 'r') as fp:
    for line in fp:
        if line.find('####  Remove after test') != -1:
            break
        else:
            cheffile += line

with open('Cheffile', 'w') as fp:
    fp.write(cheffile)

shutil.move('Cheffile.lock.bak', 'Cheffile.lock')
