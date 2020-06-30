# alu
4-bit Arithmetic Logic Unit made in VHDL

Operations are as follows (these are included in the code comments as well):

000 -> Result: nib_1 + nib_2     || Flag: Cout = Overflow || Desc: Addition

001 -> Result: nib_1 - nib_2     || Flag: 1 iff nib_2 > nib_1, otherwise 0 || Desc: Test / diff

010 -> Result: nib_1 & nib_2     || Flag: 0 || Desc: Bitwise AND

011 -> Result: nib_1 | nib_2     || Flag: 0 || Desc: Bitwise OR

100 -> Result: nib_1 ^ nib_2     || Flag: 0 || Desc: Bitwise XOR

101 -> Result: 15 - nib_1        || Flag: 0 || Desc: Bitwise inverse nib_1

110 -> Result: 15 - nib_2        || Flag: 0 || Desc: Bitwise inverse nib_2

111 -> Result: nib_1 + nib_2 + 1 || Flag: Cout = Overflow || Desc: Addition
