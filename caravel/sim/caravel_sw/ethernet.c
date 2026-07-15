/*
 * SPDX-FileCopyrightText: 2020 Efabless Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * SPDX-License-Identifier: Apache-2.0
 */

#include <defs.h>
#include <utils.h>

// --------------------------------------------------------
/*
CSR_ETHMAC_SRAM_READER_SLOT = 4132
CSR_ETHMAC_SRAM_READER_LENGTH = 4136
CSR_ETHMAC_SRAM_READER_START = 4120
CSR_ETHMAC_SRAM_READER_EV_ENABLE = 4148
CSR_ETHMAC_SRAM_READER_EV_PENDING = 4144
CSR_ETHMAC_SRAM_READER_READY = 4124

TX_BUFFER_BASE = 0x20400
SLOT_SIZE = 2048

    await wb.write(CSR_ETHMAC_SRAM_READER_EV_ENABLE, 1)
    await wb.write(CSR_ETHMAC_SRAM_READER_EV_PENDING, 1)
    for i in range(0, len(frame_data), 4):
        word = int.from_bytes(frame_data[i:i+4].ljust(4, b'\x00'), byteorder='little')
        await wb.write(TX_BUFFER_BASE + i, word)
    dut._log.info("Configuring TX slot and length...")
    await wb.write(CSR_ETHMAC_SRAM_READER_SLOT, 0)
    await wb.write(CSR_ETHMAC_SRAM_READER_LENGTH, frame_len)

    # Start TX
    dut._log.info("Starting TX...")
    await wb.write(CSR_ETHMAC_SRAM_READER_START, 1)
*/

#define ETHMAC_CSR_BASE                     0x30030000

#define CSR_ETHMAC_SRAM_WRITER_LENGTH       (ETHMAC_CSR_BASE + 0x1004)
#define CSR_ETHMAC_SRAM_WRITER_EV_PENDING   (ETHMAC_CSR_BASE + 0x1010)
#define CSR_ETHMAC_SRAM_WRITER_EV_ENABLE    (ETHMAC_CSR_BASE + 0x1014)

#define CSR_ETHMAC_SRAM_READER_START        (ETHMAC_CSR_BASE + 0x1018)
#define CSR_ETHMAC_SRAM_READER_SLOT         (ETHMAC_CSR_BASE + 0x1024)
#define CSR_ETHMAC_SRAM_READER_LENGTH       (ETHMAC_CSR_BASE + 0x1028)
#define CSR_ETHMAC_SRAM_READER_EV_PENDING   (ETHMAC_CSR_BASE + 0x1030)
#define CSR_ETHMAC_SRAM_READER_EV_ENABLE    (ETHMAC_CSR_BASE + 0x1034)

#define ETHMAC_BASE                         0x30000000
#define TX_BUFFER_BASE                      (ETHMAC_BASE + 0x400)
#define RX_BUFFER_BASE                      (ETHMAC_BASE + 0x000)

#define write_byte(off, val) {(*(volatile uint8_t*)((off))) = (val);}
#define write_reg(off, val) {(*(volatile uint32_t*)((off))) = (val);}
#define read_reg(off) (*(volatile uint32_t*)((off)))

void main()
{
    int j;

    reg_wb_enable = 1;

    write_reg(CSR_ETHMAC_SRAM_WRITER_EV_ENABLE, 1);
    write_reg(CSR_ETHMAC_SRAM_READER_EV_ENABLE, 1);
    write_reg(CSR_ETHMAC_SRAM_READER_EV_PENDING, 1);

    int len = 64;
    for (int i = 0; i < len; i++)
        write_byte(TX_BUFFER_BASE+i, i);

    write_reg(CSR_ETHMAC_SRAM_READER_SLOT, 0);
    write_reg(CSR_ETHMAC_SRAM_READER_LENGTH, len);
    write_reg(CSR_ETHMAC_SRAM_READER_START, 1);

    // for (volatile int i; i < 10; i++);
    // wait for incoming
    while (!read_reg(CSR_ETHMAC_SRAM_WRITER_EV_PENDING));

    if (read_reg(CSR_ETHMAC_SRAM_WRITER_LENGTH) == len)
        reg_gpio_out = 1;
}
