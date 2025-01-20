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

EF_DRIVER_STATUS EF_SPI_setGclkEnable (EF_SPI_TYPE_PTR spi, uint32_t value){
    
    EF_DRIVER_STATUS status = EF_DRIVER_OK;

    if (spi == NULL){
        status = EF_DRIVER_ERROR_PARAMETER;    // Return EF_DRIVER_ERROR_PARAMETER if spi is NULL
    }else if (value > (uint32_t)0x1) {  
        status = EF_DRIVER_ERROR_PARAMETER;    // Return EF_DRIVER_ERROR_PARAMETER if value is out of range
    }else {
        spi->GCLK = value;                     // Set the GCLK enable bit to the given value
    }

    return status;
}

EF_DRIVER_STATUS EF_SPI_writeData(EF_SPI_TYPE_PTR spi, uint32_t data){
    
    EF_DRIVER_STATUS status = EF_DRIVER_OK;

    if (spi == NULL){
        status = EF_DRIVER_ERROR_PARAMETER;     // Return EF_DRIVER_ERROR_PARAMETER if spi is NULL
    }else if (data > EF_SPI_TXDATA_MAX_VALUE) {
        status = EF_DRIVER_ERROR_PARAMETER;     // Return EF_DRIVER_ERROR_PARAMETER if data is out of range
    }else {
        spi->TXDATA = data;                     // Write the data to the TXDATA register
    }
    return status;
}

EF_DRIVER_STATUS EF_SPI_readData(EF_SPI_TYPE_PTR spi, uint32_t *data){

    EF_DRIVER_STATUS status = EF_DRIVER_OK;

    if (spi == NULL){
        status = EF_DRIVER_ERROR_PARAMETER;     // Return EF_DRIVER_ERROR_PARAMETER if spi is NULL
    }else if (data == NULL){
        status = EF_DRIVER_ERROR_PARAMETER;     // Return EF_DRIVER_ERROR_PARAMETER if data is NULL
                                                // i.e. there is no memory location to store the value
    }else{
        *data = spi->RXDATA;
    }
    return status;
}

EF_DRIVER_STATUS EF_SPI_setpolarity(EF_SPI_TYPE_PTR spi, bool polarity){
    
    EF_DRIVER_STATUS status = EF_DRIVER_OK;
    if (spi == NULL){
        status = EF_DRIVER_ERROR_PARAMETER;     // Return EF_DRIVER_ERROR_PARAMETER if spi is NULL
    }else{
        uint32_t config = spi->CFG;
        if (polarity)
            {config |= EF_SPI_CFG_REG_CPOL_MASK;}
        else
            {config &= ~EF_SPI_CFG_REG_CPOL_MASK;}
        spi->CFG = config; 
    }
    return status;
}

EF_DRIVER_STATUS EF_SPI_setPhase(EF_SPI_TYPE_PTR spi, bool phase){
    
    EF_DRIVER_STATUS status = EF_DRIVER_OK;
    if (spi == NULL){
        status = EF_DRIVER_ERROR_PARAMETER;     // Return EF_DRIVER_ERROR_PARAMETER if spi is NULL
    }else{

        uint32_t config = spi->CFG;
        if (phase)
            {config |= EF_SPI_CFG_REG_CPHA_MASK;}
        else
            {config &= ~EF_SPI_CFG_REG_CPHA_MASK;}
        spi->CFG = config;
    }
    return status;
}


EF_DRIVER_STATUS EF_SPI_isTxFifoEmpty(EF_SPI_TYPE_PTR spi, uint32_t *TXfifo_state){

    EF_DRIVER_STATUS status = EF_DRIVER_OK;

    if (spi == NULL){
        status = EF_DRIVER_ERROR_PARAMETER;     // Return EF_DRIVER_ERROR_PARAMETER if spi is NULL
    }else if (TXfifo_state == NULL){
        status = EF_DRIVER_ERROR_PARAMETER;     // Return EF_DRIVER_ERROR_PARAMETER if TXfifo_state is NULL
                                                // i.e. there is no memory location to store the value
    }else{
        *TXfifo_state = spi->STATUS & EF_SPI_STATUS_REG_TX_E_MASK;
    }

    return status;
}

EF_DRIVER_STATUS EF_SPI_isRxFifoEmpty(EF_SPI_TYPE_PTR spi, uint32_t *RXfifo_state){

    EF_DRIVER_STATUS status = EF_DRIVER_OK;

    if (spi == NULL){
        status = EF_DRIVER_ERROR_PARAMETER;     // Return EF_DRIVER_ERROR_PARAMETER if spi is NULL
    }else if (RXfifo_state == NULL){
        status = EF_DRIVER_ERROR_PARAMETER;     // Return EF_DRIVER_ERROR_PARAMETER if RXfifo_state is NULL
                                                // i.e. there is no memory location to store the value
    }else{ 
        *RXfifo_state = (spi->STATUS & EF_SPI_STATUS_REG_RX_E_MASK) >> EF_SPI_STATUS_REG_RX_E_BIT;
    }
    return status;
}


EF_DRIVER_STATUS EF_SPI_waitTxFifoEmpty(EF_SPI_TYPE_PTR spi){
    
    EF_DRIVER_STATUS status = EF_DRIVER_OK;

    if (spi == NULL){
        status = EF_DRIVER_ERROR_PARAMETER;     // Return EF_DRIVER_ERROR_PARAMETER if spi is NULL
    }else{
        uint32_t TXfifo_state;
        do {    
            status = EF_SPI_isTxFifoEmpty(spi, &TXfifo_state);
        } while((status == EF_DRIVER_OK) && (TXfifo_state == (uint32_t)0));
    }
    return status;
}

EF_DRIVER_STATUS EF_SPI_waitRxFifoNotEmpty(EF_SPI_TYPE_PTR spi){
    
    EF_DRIVER_STATUS status = EF_DRIVER_OK;

    if (spi == NULL){
        status = EF_DRIVER_ERROR_PARAMETER;     // Return EF_DRIVER_ERROR_PARAMETER if spi is NULL
    }else{
        uint32_t RXfifo_state;
        do {
            status = EF_SPI_isRxFifoEmpty(spi, &RXfifo_state);
        } while((status == EF_DRIVER_OK) && (RXfifo_state == (uint32_t)1));
    }
    return status;
}

EF_DRIVER_STATUS EF_SPI_FifoRxFlush(EF_SPI_TYPE_PTR spi){

    EF_DRIVER_STATUS status = EF_DRIVER_OK;

    if (spi == NULL){
        status = EF_DRIVER_ERROR_PARAMETER;     // Return EF_DRIVER_ERROR_PARAMETER if spi is NULL
    }else{
        spi->RX_FIFO_FLUSH = 1;
    }
    return status;
}

EF_DRIVER_STATUS EF_SPI_enable(EF_SPI_TYPE_PTR spi){

    EF_DRIVER_STATUS status = EF_DRIVER_OK;

    if (spi == NULL){
        status = EF_DRIVER_ERROR_PARAMETER;     // Return EF_DRIVER_ERROR_PARAMETER if spi is NULL
    }else{
        spi->CTRL |= EF_SPI_CTRL_REG_ENABLE_MASK;
    }
    return status;
}

EF_DRIVER_STATUS EF_SPI_disable(EF_SPI_TYPE_PTR spi){

    EF_DRIVER_STATUS status = EF_DRIVER_OK;

    if (spi == NULL){
        status = EF_DRIVER_ERROR_PARAMETER;     // Return EF_DRIVER_ERROR_PARAMETER if spi is NULL
    }else{
        spi->CTRL &= ~EF_SPI_CTRL_REG_ENABLE_MASK;
    }
    return status;
}

EF_DRIVER_STATUS EF_SPI_enableRx(EF_SPI_TYPE_PTR spi){
    
    EF_DRIVER_STATUS status = EF_DRIVER_OK;

    if (spi == NULL){
        status = EF_DRIVER_ERROR_PARAMETER;     // Return EF_DRIVER_ERROR_PARAMETER if spi is NULL
    }else{
        spi->CTRL |= EF_SPI_CTRL_REG_RX_EN_MASK;
    }
    return status;
}

EF_DRIVER_STATUS EF_SPI_disableRx(EF_SPI_TYPE_PTR spi){
    
    EF_DRIVER_STATUS status = EF_DRIVER_OK;

    if (spi == NULL){
        status = EF_DRIVER_ERROR_PARAMETER;     // Return EF_DRIVER_ERROR_PARAMETER if spi is NULL
    }else{
        spi->CTRL &= ~EF_SPI_CTRL_REG_RX_EN_MASK;
    }
    return status;
}

EF_DRIVER_STATUS EF_SPI_assertCs(EF_SPI_TYPE_PTR spi){
    
    EF_DRIVER_STATUS status = EF_DRIVER_OK;

    if (spi == NULL){
        status = EF_DRIVER_ERROR_PARAMETER;     // Return EF_DRIVER_ERROR_PARAMETER if spi is NULL
    }else{
        spi->CTRL |= EF_SPI_CTRL_REG_SS_MASK;
    }
    return status;
}

EF_DRIVER_STATUS EF_SPI_deassertCs(EF_SPI_TYPE_PTR spi){
    
    EF_DRIVER_STATUS status = EF_DRIVER_OK;

    if (spi == NULL){
        status = EF_DRIVER_ERROR_PARAMETER;     // Return EF_DRIVER_ERROR_PARAMETER if spi is NULL
    }else{
        spi->CTRL &= ~EF_SPI_CTRL_REG_SS_MASK;
    }
    return status;
}


EF_DRIVER_STATUS EF_SPI_setIM(EF_SPI_TYPE_PTR spi, uint32_t mask){

    EF_DRIVER_STATUS status = EF_DRIVER_OK;

    if (spi == NULL){
        status = EF_DRIVER_ERROR_PARAMETER;     // Return EF_DRIVER_ERROR_PARAMETER if spi is NULL
    }else{
        
        spi->IM = mask;
    }
    return status;
}

EF_DRIVER_STATUS EF_SPI_getIM(EF_SPI_TYPE_PTR spi, uint32_t *mask){

    EF_DRIVER_STATUS status = EF_DRIVER_OK;

    if (spi == NULL){
        status = EF_DRIVER_ERROR_PARAMETER;     // Return EF_DRIVER_ERROR_PARAMETER if spi is NULL
    }else if (mask == NULL){
        status = EF_DRIVER_ERROR_PARAMETER;     // Return EF_DRIVER_ERROR_PARAMETER if mask is NULL
                                                // i.e. there is no memory location to store the value
    }else{
        *mask = spi->IM;
    }
    return status;
}


EF_DRIVER_STATUS EF_SPI_getRIS(EF_SPI_TYPE_PTR spi, uint32_t *mask){

    EF_DRIVER_STATUS status = EF_DRIVER_OK;

    if (spi == NULL){
        status = EF_DRIVER_ERROR_PARAMETER;     // Return EF_DRIVER_ERROR_PARAMETER if spi is NULL
    }else if (mask == NULL){
        status = EF_DRIVER_ERROR_PARAMETER;     // Return EF_DRIVER_ERROR_PARAMETER if mask is NULL
                                                // i.e. there is no memory location to store the value
    }else{
        *mask = spi->STATUS;
    }
    return status;
}

EF_DRIVER_STATUS EF_SPI_getMIS(EF_SPI_TYPE_PTR spi, uint32_t *mask){

    EF_DRIVER_STATUS status = EF_DRIVER_OK;

    if (spi == NULL){
        status = EF_DRIVER_ERROR_PARAMETER;     // Return EF_DRIVER_ERROR_PARAMETER if spi is NULL
    }else if (mask == NULL){
        status = EF_DRIVER_ERROR_PARAMETER;     // Return EF_DRIVER_ERROR_PARAMETER if mask is NULL
                                                // i.e. there is no memory location to store the value
    }else{
        *mask = spi->STATUS & spi->IM;
    }
    return status;
}


EF_DRIVER_STATUS EF_SPI_setICR(EF_SPI_TYPE_PTR spi, uint32_t mask){

    EF_DRIVER_STATUS status = EF_DRIVER_OK;

    if (spi == NULL){
        status = EF_DRIVER_ERROR_PARAMETER;    // Return EF_DRIVER_ERROR_PARAMETER if spi is NULL
    }else {
        spi->IC = mask;                       // Set the IC register with the required mask value
    }
    return status;
}



/******************************************************************************
* Static Function Definitions
******************************************************************************/




#endif // EF_SPI_C

/******************************************************************************
* End of File
******************************************************************************/
