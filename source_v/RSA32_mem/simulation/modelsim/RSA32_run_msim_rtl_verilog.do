transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/BaekSeungWook/Desktop/BaekSW/Quartus-II/RSA32_mem {C:/Users/BaekSeungWook/Desktop/BaekSW/Quartus-II/RSA32_mem/RL_binary.v}
vlog -vlog01compat -work work +incdir+C:/Users/BaekSeungWook/Desktop/BaekSW/Quartus-II/RSA32_mem {C:/Users/BaekSeungWook/Desktop/BaekSW/Quartus-II/RSA32_mem/mont_mult.v}
vlog -vlog01compat -work work +incdir+C:/Users/BaekSeungWook/Desktop/BaekSW/Quartus-II/RSA32_mem {C:/Users/BaekSeungWook/Desktop/BaekSW/Quartus-II/RSA32_mem/mod_exp.v}
vlog -vlog01compat -work work +incdir+C:/Users/BaekSeungWook/Desktop/BaekSW/Quartus-II/RSA32_mem {C:/Users/BaekSeungWook/Desktop/BaekSW/Quartus-II/RSA32_mem/long_div.v}
vlog -vlog01compat -work work +incdir+C:/Users/BaekSeungWook/Desktop/BaekSW/Quartus-II/RSA32_mem {C:/Users/BaekSeungWook/Desktop/BaekSW/Quartus-II/RSA32_mem/get_length.v}
vlog -vlog01compat -work work +incdir+C:/Users/BaekSeungWook/Desktop/BaekSW/Quartus-II/RSA32_mem {C:/Users/BaekSeungWook/Desktop/BaekSW/Quartus-II/RSA32_mem/IO.v}
vlog -vlog01compat -work work +incdir+C:/Users/BaekSeungWook/Desktop/BaekSW/Quartus-II/RSA32_mem {C:/Users/BaekSeungWook/Desktop/BaekSW/Quartus-II/RSA32_mem/ltp.v}

vlog -vlog01compat -work work +incdir+C:/Users/BaekSeungWook/Desktop/BaekSW/Quartus-II/RSA32_mem {C:/Users/BaekSeungWook/Desktop/BaekSW/Quartus-II/RSA32_mem/IO_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver -L rtl_work -L work -voptargs="+acc"  IO_tb

add wave *
view structure
view signals
run -all
