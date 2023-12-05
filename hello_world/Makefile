# *************************************************
# IMPORTANTE PARA PODER COMPILAR ESTE EJEMPLO:
# En el aechivo:litex/litex/soc/software/common.mak
# cambiar de:
# ifeq ($(LTO), 1)
# COMMONFLAGS += -flto
# endif
# a:
# COMMONFLAGS += -flto
# *************************************************

TARGET=alpha_board
BUILD_DIR=../build/$(TARGET)/
include $(BUILD_DIR)/software/include/generated/variables.mak
include $(SOC_DIRECTORY)/software/common.mak
OBJECTS=isr.o main.o crt0.o
all: hello_world.bin
%.bin: %.elf
	$(OBJCOPY) -O binary $< $@
	chmod -x $@

hello_world.elf: $(OBJECTS)
	$(CC) $(LDFLAGS) \
		-T linker.ld \
		-N -o $@ \
		$(OBJECTS) \
		-L$(BUILD_DIR)/software/libbase \
		-L$(BUILD_DIR)/software/libcompiler_rt \
		-L$(BUILD_DIR)/software/libc/ \
		-lc -lbase -lcompiler_rt 
	chmod -x $@

main.o: main.c
	$(compile)
	
crt0.o: $(CPU_DIRECTORY)/crt0.S
	$(assemble)
%.o: %.c
	$(compile)
%.o: %.S
	$(assemble)
clean:
	$(RM) $(OBJECTS) *.elf *.bin .*~ *~ *.map *.d
.PHONY: clean
