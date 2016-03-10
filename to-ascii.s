
TO_ASCII.Enter:

#Nonzero is false, because this architecture is backwards
MOV N_[1] INTO TO_ASCII.Recognised

#Set up our counter variable
LOD N_[0]
STR TO_ASCII.TableCount[0]
STR TO_ASCII.TableCount[1]

#Check if it's a space character
JMPNE8 TO_ASCII.Keycode TO_ASCII.PS2Space TO TO_ASCII.NotSpace

#Special case for space character
MOV8 TO_ASCII.AsciiSpace INTO TO_ASCII.Ascii
MOV N_[0] INTO TO_ASCII.Recognised
LOD N_[0]
JMP TO_ASCII.Exit

#Look through the table.
TO_ASCII.NotSpace:

#Set up pointers to grab the code we're inspecting
LSHIFT8 TO_ASCII.TableCount INTO TO_ASCII.TableIndex
ADD16 TO_ASCII.TablePtr[1] TO_ASCII.TableIndexPadded INTO TO_ASCII.Ptr1[1]
INC16 TO_ASCII.Ptr1[1] INTO TO_ASCII.Ptr2[1]

#Load it into a known location
TO_ASCII.Ptr1:
LOD 0x0000
STR TO_ASCII.CheckCode[0]
TO_ASCII.Ptr2:
LOD 0x0000
STR TO_ASCII.CheckCode[1]

#Test equality
JMPEQ8 TO_ASCII.CheckCode TO_ASCII.KeyCode TO TO_ASCII.FoundIt

#increment, if not equal
INC8 TO_ASCII.TableCount

#Test if we've overrun
JMPGE TO_ASCII.TableCount TO_ASCII.TableMax TO TO_ASCII.Exit

#Loop
LOD N_[0]
JMP TO_ASCII.NotSpace

#Case for if we found the code
#Ascii is numbered meaningfully, meaning we can get away with this!
TO_ASCII.FoundIt:
ADD8 TO_ASCII.TableCount TO_ASCII.AsciiA INTO TO_ASCII.Ascii
MOV N_[0] INTO TO_ASCII.Recognised
LOD N_[0]
JMP TO_ASCII.Exit

#Return
LOD N_[0]
TO_ASCII.Exit:
JMP 0x0000

#This sits around to make things easier; essentially data
TO_ASCII.TablePtr:
JMP TO_ASCII.KeysTable

#Inputs and outputs
TO_ASCII.Recognised:	.data 1
TO_ASCII.Keycode: 		.data 2
TO_ASCII.Ascii:			.data 2

#Control flow
TO_ASCII.TableCount:	.data 2
TO_ASCII.TableIndexPadded:	.data 2 0x00
TO_ASCII.TableIndex:	.data 2
TO_ASCII.CheckCode:		.data 2

TO_ASCII.TableMax:		.data 2 0d25


#Data
TO_ASCII.AsciiSpace:	.data 2 0x20
TO_ASCII.PS2Space:		.data 2 0x29
TO_ASCII.AsciiA			.data 2 0x41

TO_ASCII.KeysTable:		
TO_ASCII.A:				.data 2 0x1C
TO_ASCII.B:				.data 2 0x32
TO_ASCII.C:				.data 2 0x21
TO_ASCII.D:				.data 2 0x23
TO_ASCII.E:				.data 2 0x24
TO_ASCII.F:				.data 2 0x2B
TO_ASCII.G:				.data 2 0x34
TO_ASCII.H:				.data 2 0x33
TO_ASCII.I:				.data 2 0x43
TO_ASCII.J:				.data 2 0x3B
TO_ASCII.K:				.data 2 0x42
TO_ASCII.L:				.data 2 0x4B
TO_ASCII.M:				.data 2 0x3A
TO_ASCII.N:				.data 2 0x31
TO_ASCII.O:				.data 2 0x44
TO_ASCII.P:				.data 2 0x4D
TO_ASCII.Q:				.data 2 0x15
TO_ASCII.R:				.data 2 0x2D
TO_ASCII.S:				.data 2 0x1B
TO_ASCII.T:				.data 2 0x2C
TO_ASCII.U:				.data 2 0x3C
TO_ASCII.V:				.data 2 0x2A
TO_ASCII.W:				.data 2 0x1D
TO_ASCII.X:				.data 2 0x22
TO_ASCII.Y:				.data 2 0x35
TO_ASCII.Z:				.data 2 0x1A

