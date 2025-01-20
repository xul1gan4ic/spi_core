vlog -sv -mfcu +initmem+0 \
    ../rtl/*.sv           \
    ./src/*.sv            \

vsim -voptargs="+acc" work.tb_spi_core