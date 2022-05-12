MCU = PIC16f54
PROJECT =lt5250_4digit
EXECUTABLE = $(PROJECT)_$(MCU).hex

$(EXECUTABLE): seven_seg.asm #seven_seg.inc
	gpasm seven_seg.asm -o $(EXECUTABLE)

program: $(EXECUTABLE)
	pk2cmd -P$(MCU) -T -A5 -R -J -Z -M -F$(EXECUTABLE)

clean:
	rm -r *.hex *.lst *.cod ./documents/README.pdf documents/remove_first_line.md