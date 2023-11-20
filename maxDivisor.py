#!/usr/bin/env python3
# 112314001

import multiprocessing

def findDivisors(n, q):
	dcount = 0

	for i in range(1, n + 1):
		if n % i == 0:
			dcount += 1

	q.put((n, dcount))

ACCEPT_DIRECT = True

def main():
	count = int(input('Enter the number of elements: '))
	elems = []

	if(count < 1):
		print('Count is less than one.')
		return

	if ACCEPT_DIRECT: # Follows the example given in the question
		elems = eval(input('Enter the elements as a Python list: '))
		if len(elems) != count:
			print('Error: count differs.')
			return
	else: # More secure
		for i in range(count):
			elems.append(int(input(f'Enter element {i}: ')))

	q = multiprocessing.Queue()

	procs = []
	for n in elems:
		proc = multiprocessing.Process(target = findDivisors, args = [n, q])
		proc.start()
		procs.append(proc)

	for proc in procs:
		proc.join()

	maxDivNo = False
	maxDivCount = 0

	while(not q.empty()):
		tup = q.get()
		print(f'Number {tup[0]} has {tup[1]} divisor(s).')

		if(tup[1] > maxDivCount):
			maxDivCount = tup[1]
			maxDivNo = tup[0]

	print(f'\nNumber {maxDivNo} has the most number of (trivial + nontrivial) divisor(s) is {maxDivCount}.')

main()
