#driver for ps2 keyboard controller

PS2_DRIVER.Enter:

#Change when final chip select assignments made
MOV N_[1] INTO CHIP_SELECT

#Check for ready signal - if not given, note this and return.
#If given, note this and continue
OR STATUS_BUS N_[0b0010] INTO PS2_DRIVER.GotKey
LOD PS2_DRIVER.GotKey
JMP PS2_DRIVER.Exit

#If a key was found, read it.

MOV N_[0b1000] INTO STATUS_BUS
MOV DATA_BUS INTO PS2_DRIVER.Keystroke[0]
MOV N_[0b0000] INTO STATUS_BUS

MOV N_[0b1000] INTO STATUS_BUS
MOV DATA_BUS INTO PS2_DRIVER.Keystroke[1]
MOV N_[0b0000] INTO STATUS_BUS


PS2_DRIVER.Exit:
JMP 0x0000


PS2_DRIVER.GotKey:		.data 1
PS2_DRIVER.Keystroke:	.data 2
