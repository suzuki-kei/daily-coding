#
# MEMORY LAYOUT
#     Z0 = 0
#     y  = 121
#     e  = 101
#     s  = 115
#     LF = 10
#     Z1 = 0
#     F  = flag for inifite loop
#

# build text to output
Z0  >
y   >+++++++++++[-<+++++++++++>]
e   >++++++++++[-<++++++++++>]<+>
s   >+++++++++[-<+++++++++++++>]<-->
LF  ++++++++++>
Z1

# output text infinitly
Z1  >
F   +
F   [
F       <<[<]
Z0      >
y       [.>]
Z1      >
F   ]

