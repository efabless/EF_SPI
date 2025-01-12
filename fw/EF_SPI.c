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

/*! \file EF_SPI.c
    \brief C file for SPI APIs which contains the function Implementations
    
*/

#ifndef EF_SPI_C
#define EF_SPI_C


/******************************************************************************
* Includes
******************************************************************************/
#include "EF_SPI.h"



/******************************************************************************
* File-Specific Macros and Constants
******************************************************************************/



/******************************************************************************
* Static Variables
******************************************************************************/



/******************************************************************************
* Static Function Prototypes
******************************************************************************/



/******************************************************************************
* Function Definitions
******************************************************************************/


void EF_SPI_setGclkEnable (uint32_t spi_base, int value){
    EF_SPI_TYPE* spi = (EF_SPI_TYPE*)spi_base;
    spi->GCLK = value;
}

void EF_SPI_writeData(uint32_t spi_base, int data){

    EF_SPI_TYPE* spi = (EF_SPI_TYPE*)spi_base;

    spi->TXDATA = data;
}

int EF_SPI_readData(uint32_t spi_base){
    EF_SPI_TYPE* spi = (EF_SPI_TYPE*)spi_base;

    return (spi->RXDATA);
}

void EF_SPI_writepolarity(uint32_t spi_base, bool polarity){

    EF_SPI_TYPE* spi = (EF_SPI_TYPE*)spi_base;

    int config = spi->CFG;
    if (polarity == true)
        config |= EF_SPI_CFG_REG_CPOL_MASK;
    else
        config &= ~EF_SPI_CFG_REG_CPOL_MASK;
    spi->CFG = config; 
}

void EF_SPI_writePhase(uint32_t spi_base, bool phase){

    EF_SPI_TYPE* spi = (EF_SPI_TYPE*)spi_base;

    int config = spi->CFG;
    if (phase == true)
        config |= EF_SPI_CFG_REG_CPHA_MASK;
    else
        config &= ~EF_SPI_CFG_REG_CPHA_MASK;
    spi->CFG = config;
}


int EF_SPI_readTxFifoEmpty(uint32_t spi_base){

    EF_SPI_TYPE* spi = (EF_SPI_TYPE*)spi_base;

    return (spi->STATUS & EF_SPI_STATUS_REG_TX_E_MASK);
}

int EF_SPI_readRxFifoEmpty(uint32_t spi_base){

    EF_SPI_TYPE* spi = (EF_SPI_TYPE*)spi_base;

    return ((spi->STATUS & EF_SPI_STATUS_REG_RX_E_MASK) >> EF_SPI_STATUS_REG_RX_E_BIT);
}


void EF_SPI_waitTxFifoEmpty(uint32_t spi_base){
    EF_SPI_TYPE* spi = (EF_SPI_TYPE*)spi_base;
    while(EF_SPI_readTxFifoEmpty(spi_base) == 0);
}

void EF_SPI_waitRxFifoNotEmpty(uint32_t spi_base){
    EF_SPI_TYPE* spi = (EF_SPI_TYPE*)spi_base;
    while(EF_SPI_readRxFifoEmpty(spi_base) == 1);
}
void EF_SPI_FifoRxFlush(uint32_t spi_base){
    EF_SPI_TYPE* spi = (EF_SPI_TYPE*)spi_base;
    spi->RX_FIFO_FLUSH = 1;
}

void EF_SPI_enable(uint32_t spi_base){
    EF_SPI_TYPE* spi = (EF_SPI_TYPE*)spi_base;
    int control = spi->CTRL;
    control |= EF_SPI_CTRL_REG_ENABLE_MASK;
    spi->CTRL = control;
    // control &= ~1;
    // spi->CTRL = control;
}

void EF_SPI_disable(uint32_t spi_base){
    EF_SPI_TYPE* spi = (EF_SPI_TYPE*)spi_base;
    int control = spi->CTRL;
    control &= ~EF_SPI_CTRL_REG_ENABLE_MASK;
    spi->CTRL = control;
}

void EF_SPI_enableRx(uint32_t spi_base){
    EF_SPI_TYPE* spi = (EF_SPI_TYPE*)spi_base;
    int control = spi->CTRL;
    control |= EF_SPI_CTRL_REG_RX_EN_MASK;
    spi->CTRL = control;
}

void EF_SPI_disableRx(uint32_t spi_base){
    EF_SPI_TYPE* spi = (EF_SPI_TYPE*)spi_base;
    int control = spi->CTRL;
    control &= ~EF_SPI_CTRL_REG_RX_EN_MASK;
    spi->CTRL = control;
}


void EF_SPI_assertCs(uint32_t spi_base){
    EF_SPI_TYPE* spi = (EF_SPI_TYPE*)spi_base;
    int control = spi->CTRL;
    control |= EF_SPI_CTRL_REG_SS_MASK;
    spi->CTRL = control;
}

void EF_SPI_deassertCs(uint32_t spi_base){
    EF_SPI_TYPE* spi = (EF_SPI_TYPE*)spi_base;
    int control = spi->CTRL;
    control &= ~EF_SPI_CTRL_REG_SS_MASK;
    spi->CTRL = control;
}

void EF_SPI_setInterruptMask(uint32_t spi_base, int mask){
    EF_SPI_TYPE* spi = (EF_SPI_TYPE*)spi_base;
    // bit 0: Done
    spi->IM = mask;
}


/******************************************************************************
* Static Function Definitions
******************************************************************************/





#endif // EF_SPI_C

/******************************************************************************
* End of File
******************************************************************************/
