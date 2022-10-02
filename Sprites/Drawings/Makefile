##
# Make small
#
# @file
# @version 0.1

DRAWINGS := $(shell find . -regex "\.\/TattooDraw\w\w.png")
DRAWINGS_SMALL := $(patsubst %.png,%_small.png,$(DRAWINGS))

all: $(DRAWINGS_SMALL)

%_small.png: %.png
	magick $^ -resize 72 $@

echo:
	@echo $(DRAWINGS)
	@echo $(DRAWINGS_SMALL)
# end
