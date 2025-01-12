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

void EF_SPI_setGclkEnable (EF_SPI_TYPE_PTR spi, uint32_t value);
void EF_SPI_writeData(EF_SPI_TYPE_PTR spi, uint32_t data);
void EF_SPI_readData(EF_SPI_TYPE_PTR spi, uint32_t *data);
void EF_SPI_writepolarity(EF_SPI_TYPE_PTR spi, bool polarity);
void EF_SPI_writePhase(EF_SPI_TYPE_PTR spi, bool phase);
void EF_SPI_readTxFifoEmpty(EF_SPI_TYPE_PTR spi, uint32_t *TXfifo_state);
void EF_SPI_readRxFifoEmpty(EF_SPI_TYPE_PTR spi, uint32_t *RXfifo_state);
void EF_SPI_waitTxFifoEmpty(EF_SPI_TYPE_PTR spi);
void EF_SPI_waitRxFifoNotEmpty(EF_SPI_TYPE_PTR spi);
void EF_SPI_FifoRxFlush(EF_SPI_TYPE_PTR spi);
void EF_SPI_enable(EF_SPI_TYPE_PTR spi);
void EF_SPI_disable(EF_SPI_TYPE_PTR spi);
void EF_SPI_enableRx(EF_SPI_TYPE_PTR spi);
void EF_SPI_disableRx(EF_SPI_TYPE_PTR spi);
void EF_SPI_assertCs(EF_SPI_TYPE_PTR spi);
void EF_SPI_deassertCs(EF_SPI_TYPE_PTR spi);
void EF_SPI_setInterruptMask(EF_SPI_TYPE_PTR spi, uint32_t mask);


/******************************************************************************
* External Variables
******************************************************************************/




#endif // EF_SPI_H

/******************************************************************************
* End of File
******************************************************************************/