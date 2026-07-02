gds read $::env(GDS)
set cell $::env(CELL)

if {[info exists ::env(LEF)]} {
    set lef $::env(LEF)
} else {
    set lef ${cell}.lef
}

#-toplayer
set add_opts "-toplayer -nomaster"
if {[info exists ::env(HIDE)]} {
    set add_opts "-hide ${::env(HIDE)}um $add_opts"
} else {
    set add_opts "$add_opts"
}

load $cell
select top cell

puts "Zeroizing Origin"
set bbox [box values]
set offset_x [lindex $bbox 0]
set offset_y [lindex $bbox 1]
move origin [expr {$offset_x/2}] [expr {$offset_y/2}]
property FIXED_BBOX [box values]

# following is needed to mark efuse as obstruction on metal1&2 layers
#load efuse_bitline
#select top cell
#expand
#snap internal 
#select visible efuse
#box values {*}[select bbox]
#paint metal1
#paint metal2
#load $cell
#select top cell

set tolerance 1
lef write $lef $add_opts
exit
