#
# MEMORY LAYOUT
#     Z0 = 0
#     y  = 121
#     e  = 101
#     s  = 115
#     LF = 10
#     Z1 = 0
#     F  = 1 (flag for an infinite loop)
#

# build the text
Z0  >
y   >+++++++++++[-<+++++++++++>]
e   >++++++++++[-<++++++++++>]<+>
s   >+++++++++[-<+++++++++++++>]<-->
LF  ++++++++++>
Z1

# output the text infinitely
Z1  >
F   +
F   [
F       <<[<]
Z0      >[.>]
Z1      >
F   ]

