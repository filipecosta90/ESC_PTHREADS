#!bin/bash
dtrace -s lwptime.d -c './pth_trap 10 semaphore 1 0 1000'
