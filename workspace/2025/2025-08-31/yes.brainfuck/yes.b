#!/usr/bin/env brainfuck
#
# MEMORY LAYOUT
#     Z0 = 0
#     y  = 121
#     e  = 101
#     s  = 115
#     LF = 10
#     Z1 = 0
#     F  = 1 (flag for infinite loop)
#

# build text to output
Z0  >
y   >+++++++++++[-<+++++++++++>]
e   >++++++++++[-<++++++++++>]<+>
s   >+++++++++[-<+++++++++++++>]<-->
LF ++++++++++>
Z1

# output text infinitly
Z1  >
F   +
F   [
F       <<[<]
Z0      >[.>]
Z1      >
F   ]

