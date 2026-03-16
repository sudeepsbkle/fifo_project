SIM ?= vcs
TESTNAME ?= all  # Default: all TCs

.PHONY: all comp run clean tc1 tc2 tc3 tc4 tc5 tc6 tc7 tc8 tc9 tc10

all: comp run

comp:
ifeq ($(SIM),vcs)
	vcs -full64 -sverilog -timescale=1ns/1ps -f flist.f -l compile.log
else ifeq ($(SIM),ius)
	irun -64bit -sv -f flist.f -elaborate -logfile compile.log
else
	@echo "Unsupported SIM=$(SIM). Set SIM=vcs or SIM=ius"
	@exit 1
endif

run:
	@if [ "$(SIM)" = "vcs" ]; then \
		./simv +TESTNAME=$(TESTNAME) -l sim_$(TESTNAME).log; \
	elif [ "$(SIM)" = "ius" ]; then \
		irun -64bit -sv -f flist.f +TESTNAME=$(TESTNAME) -access +rwc -logfile sim_$(TESTNAME).log; \
	else \
		echo "Unsupported SIM=$(SIM). Set SIM=vcs or SIM=ius"; \
		exit 1; \
	fi

# Quick TC targets (runs only that TC)
tc1:
	make run TESTNAME=tc1

tc2:
	make run TESTNAME=tc2

tc3:
	make run TESTNAME=tc3

tc4:
	make run TESTNAME=tc4

tc5:
	make run TESTNAME=tc5

tc6:
	make run TESTNAME=tc6

tc7:
	make run TESTNAME=tc7

tc8:
	make run TESTNAME=tc8

tc9:
	make run TESTNAME=tc9

tc10:
	make run TESTNAME=tc10

clean:
	rm -rf simv* csrc ucli.key *.log DVEfiles urgReport *flex*.log *.vpd INCA_libs irun.key waves.shm sim_*.log