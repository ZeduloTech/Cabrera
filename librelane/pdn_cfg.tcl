#SRAM

## 512
define_pdn_grid \
    -macro \
    -instances i_chip_core.sram_0 \
    -name sram_macros_NS \
    -starts_with POWER \
    -halo "$::env(PDN_HORIZONTAL_HALO) $::env(PDN_VERTICAL_HALO)"

# Macro Metal3 power ring to Metal4 straps
add_pdn_connect \
    -grid sram_macros_NS \
    -layers "Metal3 $::env(PDN_VERTICAL_LAYER)"

# Metal4 straps to top-level Metal5 horizontal stripes
add_pdn_connect \
    -grid sram_macros_NS \
    -layers "$::env(PDN_VERTICAL_LAYER) $::env(PDN_HORIZONTAL_LAYER)"

# Straps aligned with the macro's
add_pdn_stripe \
    -grid sram_macros_NS \
    -layer Metal4 \
    -width 2.36 \
    -offset 1.18 \
    -spacing 0.28 \
    -pitch 426.86 \
    -starts_with GROUND \
    -number_of_straps 2

# Wider straps to backfill the top-level PDN over the macro
add_pdn_stripe \
    -grid sram_macros_NS \
    -layer Metal4 \
    -width 4.00 \
    -offset 65.93 \
    -spacing 0.28 \
    -pitch 50 \
    -starts_with GROUND \
    -number_of_straps 7

