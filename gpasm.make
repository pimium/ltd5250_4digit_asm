PK2_DIR = /usr/share/pk2
USIM_DIR = ~/tools/usim/bin

MCU = PIC16f54
PROJECT =ltd5250_4digit
EXECUTABLE = $(PROJECT)_$(MCU)
DEBUGABLE = $(PROJECT)_$(MCU)_debug


$(EXECUTABLE).hex: seven_seg.asm #seven_seg.inc
	gpasm --mpasm-compatible seven_seg.asm -o $(EXECUTABLE).hex

$(DEBUGABLE).hex: sim.asm #seven_seg.inc
	gpasm --mpasm-compatible -g sim.asm -o $(DEBUGABLE).hex

debug: $(DEBUGABLE).bin

$(DEBUGABLE).bin: $(DEBUGABLE).hex
	$(USIM_DIR)/hexconv $(DEBUGABLE).hex

sim: $(DEBUGABLE).bin
	$(USIM_DIR)/usim $(DEBUGABLE).bin

program: $(EXECUTABLE)
	pk2cmd -B$(PK2_DIR) -P$(MCU) -T -A5 -R -J -Z -M -F$(EXECUTABLE)

run: 
	pk2cmd -B$(PK2_DIR) -P$(MCU) -T -A5

clean:
	rm -r *.hex *.lst *.cod *.bin ./documents/README.pdf documents/remove_first_line.md