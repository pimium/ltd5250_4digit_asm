MCU = PIC16f54
PROJECT =lt5250_4digit
EXECUTABLE = $(PROJECT)-$(MCU).hex

$(EXECUTABLE): seven_seg.asm #seven_seg.inc
	gpasm seven_seg.asm

program: $(EXECUTABLE)
	pk2cmd -P$(MCU) -T -A5 -R -J -Z -M -F$(EXECUTABLE)

clean:
	rm -r *.hex *.lst *.o *.cod