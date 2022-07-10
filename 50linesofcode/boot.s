.code16 # tell the assembler that we're using 16 bit mode
.global init # makes our label "init" available to the outside

# https://50linesofco.de/post/2018-02-28-writing-an-x86-hello-world-bootloader-with-assembly
# x86 AT&T syntax

init:
  mov $msg, %si # loads the address of msg into si
  mov $0xe, %ah # loads 0xe (function number for int 0x10) into ah
print_char:
  lodsb # loads the byte from the address in si into al and increments si
  cmp $0, %al # compares content in AL with zero
  je done # if al == 0, go to "done"
  int $0x10 # prints the character in al to screen
  jmp print_char # repeat with next byte
done:
  hlt # stop execution

msg: .asciz "Hello world!"

.fill 510-(.-init), 1, 0 # add zeroes to make it 510 bytes long
.word 0xaa55 # magic bytes that tell BIOS that this is bootable; remember x86 is little endian, so this is actually 0x55aa, magic bytes



