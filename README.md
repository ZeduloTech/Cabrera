# gf180mcu Caravel Template

Project template for wafer.space MPW runs using the gf180mcu PDK with integrated Caravel core. Based on the [gf180mcu-project-template](https://github.com/wafer-space/gf180mcu-project-template) with Caravel core which is essentially a simplified fork of the [GF180MCU Caravel by eFabless](https://github.com/efabless/caravel-gf180mcu) used during OpenMPW GF180MCU runs. This template is intended to be used as a base for wafer.space gf180mcu designs when proven Wishbone-capable CPU core is needed. Please see [TZ-01 testchip from the wafer.space Run-1](https://github.com/ZeduloTech/gf180mcu-testchip2025) as an example of such usage.

## Implement the Design

This repository contains a Nix flake that provides a shell with the [`leo/gf180mcu`](https://github.com/librelane/librelane/tree/leo/gf180mcu) branch of LibreLane.

Simply run `nix-shell` in the root of this repository.

With this shell enabled, run the implementation, first implementing the Caravel core (can be skipped as all required files are already in the repository):

```
make caravel-librelane
```

After Caravel implementation is done run the implementation of the chip top:

```
make librelane
```

To run everything at once:
```
make all
```

For more info, see the original [gf180mcu-project-template](https://github.com/wafer-space/gf180mcu-project-template) and check the GitHub CI scripts in this repo.

## Caravel core

Only a part of Caravel core was ported for this project. VexRiscv management processor, user Wishbone bus, flash & housekeeping SPI, PLL and GPIO config blocks are present, but padframe and user area are not. Also a total number of pads used by Caravel was reduced to 18 of which 13 could be configured for user IO bypass. All Caravel logic including GPIO config blocks are now placed inside the core area. No "frame" is going around the user project, and user project itself should be implemented inside the upper level template (`src\chip_core.sv`) and connected to the remaining pads directly. Caravel uses first 18 bidir pads (0-17) located at the bottom of the template padframe, for the pad assignment see `src/pinout.vh`.

The only major addition to the original Caravel is the `start_mode` input pin. Driving this pin to 1 during Caravel power-up will put the Caravel core into "self-sufficient" mode, in which it will use the clock from the internal ring-oscillator and start code execution from the user Wishbone area instead of SPI flash. For regular Caravel behavior `start_mode` pin should be tied to 0.

## Integrating user design with Caravel

User design located in `chip_core.sv` could be connected to Caravel's Wishbone bus. It will be mapped to the address 0x30000000 in the CPU address space. Most of the pads connected to the Caravel could be connected to the user design signals using user_gpio_\* pins. User IO on these pins is multiplexed with Caravel IO and multiplexing is controlled from Caravel software in a manner similar to the original Caravel. For examples of user designs please see Wishbone counter connected in this repository or more complex case in the [TZ-01 testchip](https://github.com/ZeduloTech/gf180mcu-testchip2025/blob/main/src/chip_core.sv).

## Verification and Simulation

Verification is based on the cocotb using Icarus Verilog as a default simulator and extending original gf180mcu-project-template testbench. To run all provided tests on behavioral RTL please run:
```
make sim
```

To run all the tests on post-implementation gate-level netlist (will be present in the `final` folder after implementation) run:
```
make sim-gl
```

Cocotb testbench is located in `cocotb/chip_top_tb.py` and could be run either directly with python or via pytest. Makefile targets launch all the tests via pytest with the number of parallel runs equivalent to a number of available CPU threads. The list of available tests could be found in `cocotb/test_list.json`. Currently each test consists of a Verilog testbench (`caravel/sim/caravel_tb`) and a Caravel program (`caravel/sim/caravel_sw`), with cocotb testbench acting mostly as a test framework. Extension of this test structure to more complex test cases could be found in the [TZ-01 testchip repository](https://github.com/ZeduloTech/gf180mcu-testchip2025/tree/main/cocotb).

