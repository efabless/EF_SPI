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


void EF_SPI_setGclkEnable (EF_SPI_TYPE_PTR spi, uint32_t value){
    
    spi->GCLK = value;
}

void EF_SPI_writeData(EF_SPI_TYPE_PTR spi, uint32_t data){

    spi->TXDATA = data;
}

void EF_SPI_readData(EF_SPI_TYPE_PTR spi, uint32_t *data){

    *data = spi->RXDATA;
}

void EF_SPI_writepolarity(EF_SPI_TYPE_PTR spi, bool polarity){
    
    uint32_t config = spi->CFG;
    if (polarity == true)
        config |= EF_SPI_CFG_REG_CPOL_MASK;
    else
        config &= ~EF_SPI_CFG_REG_CPOL_MASK;
    spi->CFG = config; 
}

void EF_SPI_writePhase(EF_SPI_TYPE_PTR spi, bool phase){

    uint32_t config = spi->CFG;
    if (phase == true)
        config |= EF_SPI_CFG_REG_CPHA_MASK;
    else
        config &= ~EF_SPI_CFG_REG_CPHA_MASK;
    spi->CFG = config;
}


void EF_SPI_readTxFifoEmpty(EF_SPI_TYPE_PTR spi, uint32_t *TXfifo_state){

    *TXfifo_state = spi->STATUS & EF_SPI_STATUS_REG_TX_E_MASK;
}

void EF_SPI_readRxFifoEmpty(EF_SPI_TYPE_PTR spi, uint32_t *RXfifo_state){

    *RXfifo_state = (spi->STATUS & EF_SPI_STATUS_REG_RX_E_MASK) >> EF_SPI_STATUS_REG_RX_E_BIT;
}


void EF_SPI_waitTxFifoEmpty(EF_SPI_TYPE_PTR spi){
    uint32_t TXfifo_state;
    do {    
        EF_SPI_readTxFifoEmpty(spi, &TXfifo_state);
    } while(TXfifo_state == 0);
}

void EF_SPI_waitRxFifoNotEmpty(EF_SPI_TYPE_PTR spi){
    uint32_t RXfifo_state;
    do {
        EF_SPI_readRxFifoEmpty(spi, &RXfifo_state);
    } while(RXfifo_state == 1);
}
void EF_SPI_FifoRxFlush(EF_SPI_TYPE_PTR spi){
    
    spi->RX_FIFO_FLUSH = 1;
}

void EF_SPI_enable(EF_SPI_TYPE_PTR spi){
    
    uint32_t control = spi->CTRL;
    control |= EF_SPI_CTRL_REG_ENABLE_MASK;
    spi->CTRL = control;
    // control &= ~1;
    // spi->CTRL = control;
}

void EF_SPI_disable(EF_SPI_TYPE_PTR spi){
    
    uint32_t control = spi->CTRL;
    control &= ~EF_SPI_CTRL_REG_ENABLE_MASK;
    spi->CTRL = control;
}

void EF_SPI_enableRx(EF_SPI_TYPE_PTR spi){
    
    uint32_t control = spi->CTRL;
    control |= EF_SPI_CTRL_REG_RX_EN_MASK;
    spi->CTRL = control;
}

void EF_SPI_disableRx(EF_SPI_TYPE_PTR spi){
    
    uint32_t control = spi->CTRL;
    control &= ~EF_SPI_CTRL_REG_RX_EN_MASK;
    spi->CTRL = control;
}


void EF_SPI_assertCs(EF_SPI_TYPE_PTR spi){
    
    uint32_t control = spi->CTRL;
    control |= EF_SPI_CTRL_REG_SS_MASK;
    spi->CTRL = control;
}

void EF_SPI_deassertCs(EF_SPI_TYPE_PTR spi){
    
    uint32_t control = spi->CTRL;
    control &= ~EF_SPI_CTRL_REG_SS_MASK;
    spi->CTRL = control;
}

void EF_SPI_setInterruptMask(EF_SPI_TYPE_PTR spi, uint32_t mask){
    
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
