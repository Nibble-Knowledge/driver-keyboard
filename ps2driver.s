#driver for ps2 keyboard controller

PS2_DRIVER.Enter:

MOV N_[0b0000] INTO STATUS_BUS
MOV CS_KEYBOARD INTO CHIP_SELECT

#Check for ready signal - if not given, note this and return.
#If given, note this and continue

AND STATUS_BUS N_[0b0010] INTO PS2_DRIVER.GotKey
LOD PS2_DRIVER.GotKey
JMP PS2_DRIVER.Done

#Stall for time - this was added to troubleshoot
PS2_DRIVER.Spin:
INC8 PS2_DRIVER.SpinVar
JMPNE8 PS2_DRIVER.SpinVar PS2_DRIVER.SpinTest TO PS2_DRIVER.Spin

#If a key was found, read it.

MOV N_[0b1000] INTO STATUS_BUS
NOP
NOP
MOV DATA_BUS INTO PS2_DRIVER.Keystroke[0]
MOV N_[0b0000] INTO STATUS_BUS

NOP
NOP
NOP
NOP

MOV N_[0b1000] INTO STATUS_BUS
NOP
NOP
MOV DATA_BUS INTO PS2_DRIVER.Keystroke[1]
MOV N_[0b0000] INTO STATUS_BUS

#Return
PS2_DRIVER.Done:

MOV N_[F] INTO CHIP_SELECT
LOD N_[0]

PS2_DRIVER.Exit:
JMP 0x0000


PS2_DRIVER.GotKey:		.data 1
PS2_DRIVER.Keystroke:	.data 2

PS2_DRIVER.SpinVar:		.data 2 0x00
PS2_DRIVER.SpinTest:	.data 2 0x00
