#To receive the direct keystroke code from the PS2 driver

MOVADDR return INTO PS2_DRIVER.Exit[1]
LOD N_[0]
JMP PS2_DRIVER.Entry
return:
NOP 00

#If a keystroke was found, PS2_DRIVER.GotKey is non-zero
#So if it is zero, jump past the stuff to process it.
#If a keystroke was found, it is now stored in PS2_DRIVER.Keystroke
#Be aware that if no keystroke was found, that just holds
#the most recent keystroke.
