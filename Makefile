CFLAGS=-O1 -g  -fno-omit-frame-pointer -Wall -Wextra
#LDFLAGS = -g -fsanitize=address -L/usr/lib/x86_64-linux-gnu/
LDFLAGS = -g 
LDLIBS=-levent_core


#SRCS := lib/schrift.c compat.c bitmap.c net.c region.c text.c main.c
SRCS := mavfwd.c bmp/bitmap.c bmp/region.c osd/net/network.c osd/msp/msp.c
#BUILD = $(CC) $(SRCS) -I $(SDK)/include -L $(DRV) $(LIB) -Os -s -o $(or $(TARGET),$@)

#BUILD = $(CC) $(SRCS) -I $(SDK)/include -L $(DRV) $(LIB) $(CFLAGS) $(LDFLAGS) $(LDLIBS) -o $(or $(TARGET),$@)
#BUILD = $(CC) $(SRCS) -I $(SDK)/include -L $(DRV) $(LIB) $(CFLAGS) $(LDFLAGS) $(LDLIBS) -o $(or $(TARGET),$@)
BUILD = $(CC) $(SRCS) -I $(SDK)/include -L$(DRV) $(CFLAGS) $(LDFLAGS) $(LIB) $(LDLIBS) -o $(or $(TARGET),$@)


clean:
	rm -f *.o osd-x86 osd-goke osd-hisi osd-star6b0 osd-star6e msposd


osd-goke:
	$(eval SDK = ./sdk/gk7205v300)
	$(eval LIB = -ldnvqe -lgk_api -lhi_mpi -lsecurec -lupvqe -lvoice_engine)
	$(BUILD)

osd-hisi:
	$(eval SDK = ./sdk/hi3516ev300)
	$(eval LIB = -D__GOKE__ -ldnvqe -lmpi -lsecurec -lupvqe -lVoiceEngine)
	$(BUILD)

osd-star6b0:
	$(eval SDK = ./sdk/infinity6)
	$(eval LIB = -D__SIGMASTAR__ -D__INFINITY6__ -D__INFINITY6B0__ -lcam_os_wrapper -lm -lmi_rgn -lmi_sys)
	$(BUILD)

osd-star6e:
	$(eval SDK = ./sdk/infinity6)
	$(eval LIB = -D__SIGMASTAR__ -D__INFINITY6__ -D__INFINITY6E__ -lcam_os_wrapper -lm -lmi_rgn -lmi_sys)
	$(BUILD)


osd-x86:
	$(eval SDK = ./sdk/gk7205v300)
	$(eval CFLAGS += -D_x86)
	$(eval LIB = -lcsfml-graphics -lcsfml-window -lcsfml-system)
	$(eval TARGET = msposd)
	$(BUILD)
#cc mavfwd.c -I ./include -L/usr/lib/x86_64-linux-gnu/  -lcsfml-graphics -lcsfml-window -lcsfml-system -O1 -g -fsanitize=address -fno-omit-frame-pointer -Wall -Wextra -D_x86 -g -fsanitize=address -levent_core -o msposd