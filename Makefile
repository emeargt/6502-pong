TARGET_ARCH := nes

ASM  := ca65
LINK := ld65

EXE := pong.nes
SOURCES := pong.asm
OBJECTS := $(SOURCES:%.asm=%.o)

$(EXE): $(OBJECTS) Makefile
	$(LINK) $(OBJECTS) -o $@ -t $(TARGET_ARCH)

$(OBJECTS): $(SOURCES) Makefile
	$(ASM) $(SOURCES) -o $@ -t $(TARGET_ARCH)

.PHONY: all, clean

all: $(EXE)

clean:
	rm -f -v *.deb $(OBJECTS) $(EXE)


