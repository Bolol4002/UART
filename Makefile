.PHONY: clean

%:
	@echo "=== Compiling ===" && \
	iverilog -o sim.vvp src/$@.v tb/$@_tb.v && \
	echo "=== Simulation Output ===" && \
	vvp sim.vvp && \
	echo "=== Opening GTKWave ===" && \
	gtkwave $@_tb.vcd &

clean:
	rm -f sim.vvp *.vcd
