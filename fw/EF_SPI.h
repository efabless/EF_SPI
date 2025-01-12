/*
	Copyright 2025 Efabless Corp.


	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

	    www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.

*/

/*! \file EF_SPI.h
    \brief C header file for SPI APIs which contains the function prototypes 
    
*/

#ifndef EF_SPI_H
#define EF_SPI_H
/******************************************************************************
* Includes
******************************************************************************/
#include "EF_SPI_regs.h"
#include "EF_Driver_Common.h"

/******************************************************************************
* Macros and Constants
******************************************************************************/

/******************************************************************************
* Typedefs and Enums
******************************************************************************/



/******************************************************************************
* Function Prototypes
******************************************************************************/

void EF_SPI_setGclkEnable (uint32_t spi_base, int value);
void EF_SPI_writeData(uint32_t spi_base, int data);
int EF_SPI_readData(uint32_t spi_base);
void EF_SPI_writepolarity(uint32_t spi_base, bool polarity);
void EF_SPI_writePhase(uint32_t spi_base, bool phase);
int EF_SPI_readTxFifoEmpty(uint32_t spi_base);
int EF_SPI_readRxFifoEmpty(uint32_t spi_base);
void EF_SPI_waitTxFifoEmpty(uint32_t spi_base);
void EF_SPI_waitRxFifoNotEmpty(uint32_t spi_base);
void EF_SPI_FifoRxFlush(uint32_t spi_base);
void EF_SPI_enable(uint32_t spi_base);
void EF_SPI_disable(uint32_t spi_base);
void EF_SPI_enableRx(uint32_t spi_base);
void EF_SPI_disableRx(uint32_t spi_base);
void EF_SPI_assertCs(uint32_t spi_base);
void EF_SPI_deassertCs(uint32_t spi_base);
void EF_SPI_setInterruptMask(uint32_t spi_base, int mask);


/******************************************************************************
* External Variables
******************************************************************************/




#endif // EF_SPI_H

/******************************************************************************
* End of File
******************************************************************************/