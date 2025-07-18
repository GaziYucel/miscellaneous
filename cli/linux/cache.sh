#!/bin/bash
set -x #echo on

# Clearing the PageCache

sudo sync && echo 1 | sudo tee /proc/sys/vm/drop_caches

# Clearing the Dentries and Inodes

sudo sync && echo 2 | sudo tee /proc/sys/vm/drop_caches

# Clearing the PageCache, Dentries, and Inodes

sudo sync && echo 3 | sudo tee /proc/sys/vm/drop_caches

