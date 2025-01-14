/*
	Copyright 2024 Efabless Corp.

	Author: Efabless Corp. (ip_admin@efabless.com)

	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

	    http://www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.

*/

#ifndef EF_SPIREGS_H
#define EF_SPIREGS_H

#ifndef IO_TYPES
#define IO_TYPES
#define   __R     volatile const unsigned int
#define   __W     volatile       unsigned int
#define   __RW    volatile       unsigned int
#endif

#define EF_SPI_CFG_REG_CPOL_BIT	0
#define EF_SPI_CFG_REG_CPOL_MASK	0x1
#define EF_SPI_CFG_REG_CPHA_BIT	1
#define EF_SPI_CFG_REG_CPHA_MASK	0x2
#define EF_SPI_CTRL_REG_SS_BIT	0
#define EF_SPI_CTRL_REG_SS_MASK	0x1
#define EF_SPI_CTRL_REG_ENABLE_BIT	1
#define EF_SPI_CTRL_REG_ENABLE_MASK	0x2
#define EF_SPI_CTRL_REG_RX_EN_BIT	2
#define EF_SPI_CTRL_REG_RX_EN_MASK	0x4
#define EF_SPI_STATUS_REG_TX_E_BIT	0
#define EF_SPI_STATUS_REG_TX_E_MASK	0x1
#define EF_SPI_STATUS_REG_TX_F_BIT	1
#define EF_SPI_STATUS_REG_TX_F_MASK	0x2
#define EF_SPI_STATUS_REG_RX_E_BIT	2
#define EF_SPI_STATUS_REG_RX_E_MASK	0x4
#define EF_SPI_STATUS_REG_RX_F_BIT	3
#define EF_SPI_STATUS_REG_RX_F_MASK	0x8
#define EF_SPI_STATUS_REG_TX_B_BIT	4
#define EF_SPI_STATUS_REG_TX_B_MASK	0x10
#define EF_SPI_STATUS_REG_RX_A_BIT	5
#define EF_SPI_STATUS_REG_RX_A_MASK	0x20
#define EF_SPI_STATUS_REG_BUSY_BIT	6
#define EF_SPI_STATUS_REG_BUSY_MASK	0x40
#define EF_SPI_STATUS_REG_DONE_BIT	7
#define EF_SPI_STATUS_REG_DONE_MASK	0x80
#define EF_SPI_RX_FIFO_LEVEL_REG_LEVEL_BIT	0
#define EF_SPI_RX_FIFO_LEVEL_REG_LEVEL_MASK	0xf
#define EF_SPI_RX_FIFO_THRESHOLD_REG_THRESHOLD_BIT	0
#define EF_SPI_RX_FIFO_THRESHOLD_REG_THRESHOLD_MASK	0xf
#define EF_SPI_RX_FIFO_FLUSH_REG_FLUSH_BIT	0
#define EF_SPI_RX_FIFO_FLUSH_REG_FLUSH_MASK	0x1
#define EF_SPI_TX_FIFO_LEVEL_REG_LEVEL_BIT	0
#define EF_SPI_TX_FIFO_LEVEL_REG_LEVEL_MASK	0xf
#define EF_SPI_TX_FIFO_THRESHOLD_REG_THRESHOLD_BIT	0
#define EF_SPI_TX_FIFO_THRESHOLD_REG_THRESHOLD_MASK	0xf
#define EF_SPI_TX_FIFO_FLUSH_REG_FLUSH_BIT	0
#define EF_SPI_TX_FIFO_FLUSH_REG_FLUSH_MASK	0x1

#define EF_SPI_TXE_FLAG	0x1
#define EF_SPI_TXF_FLAG	0x2
#define EF_SPI_RXE_FLAG	0x4
#define EF_SPI_RXF_FLAG	0x8
#define EF_SPI_TXB_FLAG	0x10
#define EF_SPI_RXA_FLAG	0x20

typedef struct _EF_SPI_TYPE_ {
	__R 	RXDATA;
	__W 	TXDATA;
	__W 	CFG;
	__W 	CTRL;
	__W 	PR;
	__R 	STATUS;
	__R 	reserved_0[16250];
	__R 	RX_FIFO_LEVEL;
	__W 	RX_FIFO_THRESHOLD;
	__W 	RX_FIFO_FLUSH;
	__R 	reserved_1[1];
	__R 	TX_FIFO_LEVEL;
	__W 	TX_FIFO_THRESHOLD;
	__W 	TX_FIFO_FLUSH;
	__R 	reserved_2[57];
	__RW	IM;
	__R 	MIS;
	__R 	RIS;
	__W 	IC;
	__W 	GCLK;
} EF_SPI_TYPE;

#endif

