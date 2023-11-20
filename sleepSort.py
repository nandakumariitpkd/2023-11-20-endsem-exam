#!/usr/bin/env python3
# 112314001

import threading
import time

def sleepAndPrint(n):
	time.sleep(n)
	print(n)

def main():
	count = int(input('Enter the number of elements: '))
	elems = []

	for i in range(count):
		elems.append(int(input(f'Enter element {i} (must be positive): ')))

	print('Elements in sorted order: ')

	threads = []
	for n in elems:
		th = threading.Thread(target = sleepAndPrint, args = [n])
		th.start()
		threads.append(th)

	for th in threads:
		th.join()

main()
