transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/BaekSeungWook/Desktop/BaekSW/QuartusPrime/RL_binary {C:/Users/BaekSeungWook/Desktop/BaekSW/QuartusPrime/RL_binary/RL_binary.v}
vlog -vlog01compat -work work +incdir+C:/Users/BaekSeungWook/Desktop/BaekSW/QuartusPrime/RL_binary {C:/Users/BaekSeungWook/Desktop/BaekSW/QuartusPrime/RL_binary/get_length.v}
vlog -vlog01compat -work work +incdir+C:/Users/BaekSeungWook/Desktop/BaekSW/QuartusPrime/RL_binary {C:/Users/BaekSeungWook/Desktop/BaekSW/QuartusPrime/RL_binary/mod_exp.v}
vlog -vlog01compat -work work +incdir+C:/Users/BaekSeungWook/Desktop/BaekSW/QuartusPrime/RL_binary {C:/Users/BaekSeungWook/Desktop/BaekSW/QuartusPrime/RL_binary/mont_mult.v}
vlog -vlog01compat -work work +incdir+C:/Users/BaekSeungWook/Desktop/BaekSW/QuartusPrime/RL_binary {C:/Users/BaekSeungWook/Desktop/BaekSW/QuartusPrime/RL_binary/long_div.v}

vlog -vlog01compat -work work +incdir+C:/Users/BaekSeungWook/Desktop/BaekSW/QuartusPrime/RL_binary {C:/Users/BaekSeungWook/Desktop/BaekSW/QuartusPrime/RL_binary/RL_binary_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  RL_binary_tb

add wave *
view structure
view signals
run -all
