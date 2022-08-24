#!/bin/bash
ghdl -a ./src/pwm.vhd ./src/pwm_tb.vhd
ghdl -s ./src/pwm.vhd ./src/pwm_tb.vhd
ghdl -e pwm_tb
ghdl -r pwm_tb --vcd=pwm_tb.vcd --stop-time=1000us
gtkwave pwm_tb.vcd
