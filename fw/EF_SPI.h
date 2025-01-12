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

//! sets the GCLK enable bit in the SPI register to a certain value
    /*!
        \param [in] "spi" An \ref EF_SPI_TYPE pointer, which points to the base memory address of SPI registers. \ref EF_SPI_TYPE is a structure that contains the SPI registers.
        \param [in] "value" The value of the GCLK enable bit

        \return status A value of type \ref EF_DRIVER_STATUS : returns a success or error code 
    */
EF_DRIVER_STATUS EF_SPI_setGclkEnable (EF_SPI_TYPE_PTR spi, uint32_t value);

//! writes a byte of data to the TXDATA register
    /*!
        \param [in] "spi" An \ref EF_SPI_TYPE pointer, which points to the base memory address of SPI registers. \ref EF_SPI_TYPE is a structure that contains the SPI registers.
        \param [in] "data" The data to be written to the TXDATA register

        \return status A value of type \ref EF_DRIVER_STATUS : returns a success or error code 
    */
EF_DRIVER_STATUS EF_SPI_writeData(EF_SPI_TYPE_PTR spi, uint32_t data);

//! reads a byte of data from the RXDATA register
    /*!
        \param [in] "spi" An \ref EF_SPI_TYPE pointer, which points to the base memory address of SPI registers. \ref EF_SPI_TYPE is a structure that contains the SPI registers.
        \param [out] "data" The data read from the RXDATA register

        \return status A value of type \ref EF_DRIVER_STATUS : returns a success or error code 
    */
EF_DRIVER_STATUS EF_SPI_readData(EF_SPI_TYPE_PTR spi, uint32_t *data);

//! sets the clock polarity of the SPI in the CFG register to a certain value
    /*!
        \param [in] "spi" An \ref EF_SPI_TYPE pointer, which points to the base memory address of SPI registers. \ref EF_SPI_TYPE is a structure that contains the SPI registers.
        \param [in] "polarity" The clock polarity value

        \return status A value of type \ref EF_DRIVER_STATUS : returns a success or error code 
    */
EF_DRIVER_STATUS EF_SPI_writepolarity(EF_SPI_TYPE_PTR spi, bool polarity);

//! sets the clock phase of the SPI in the CFG register to a certain value
    /*!
        \param [in] "spi" An \ref EF_SPI_TYPE pointer, which points to the base memory address of SPI registers. \ref EF_SPI_TYPE is a structure that contains the SPI registers.
        \param [in] "phase" The clock phase value

        \return status A value of type \ref EF_DRIVER_STATUS : returns a success or error code 
    */
EF_DRIVER_STATUS EF_SPI_writePhase(EF_SPI_TYPE_PTR spi, bool phase);

//! reads the TX FIFO empty flag from the STATUS register
    /*!
        \param [in] "spi" An \ref EF_SPI_TYPE pointer, which points to the base memory address of SPI registers. \ref EF_SPI_TYPE is a structure that contains the SPI registers.
        \param [out] "TXfifo_state" The TX FIFO empty flag value

        \return status A value of type \ref EF_DRIVER_STATUS : returns a success or error code 
    */
EF_DRIVER_STATUS EF_SPI_readTxFifoEmpty(EF_SPI_TYPE_PTR spi, uint32_t *TXfifo_state);

//! reads the RX FIFO empty flag from the STATUS register
    /*!
        \param [in] "spi" An \ref EF_SPI_TYPE pointer, which points to the base memory address of SPI registers. \ref EF_SPI_TYPE is a structure that contains the SPI registers.
        \param [out] "RXfifo_state" The RX FIFO empty flag value

        \return status A value of type \ref EF_DRIVER_STATUS : returns a success or error code 
    */
EF_DRIVER_STATUS EF_SPI_readRxFifoEmpty(EF_SPI_TYPE_PTR spi, uint32_t *RXfifo_state);

//! waits for the TX FIFO to be empty by polling the TX FIFO empty flag in the STATUS register
    /*!
        \param [in] "spi" An \ref EF_SPI_TYPE pointer, which points to the base memory address of SPI registers. \ref EF_SPI_TYPE is a structure that contains the SPI registers.

        \return status A value of type \ref EF_DRIVER_STATUS : returns a success or error code 
    */
EF_DRIVER_STATUS EF_SPI_waitTxFifoEmpty(EF_SPI_TYPE_PTR spi);

//! waits for the RX FIFO to be not empty by polling the RX FIFO empty flag in the STATUS register
    /*!
        \param [in] "spi" An \ref EF_SPI_TYPE pointer, which points to the base memory address of SPI registers. \ref EF_SPI_TYPE is a structure that contains the SPI registers.

        \return status A value of type \ref EF_DRIVER_STATUS : returns a success or error code 
    */
EF_DRIVER_STATUS EF_SPI_waitRxFifoNotEmpty(EF_SPI_TYPE_PTR spi);

//! flushes the RX FIFO by writing to the RX FIFO FLUSH register
    /*!
        \param [in] "spi" An \ref EF_SPI_TYPE pointer, which points to the base memory address of SPI registers. \ref EF_SPI_TYPE is a structure that contains the SPI registers.

        \return status A value of type \ref EF_DRIVER_STATUS : returns a success or error code 
    */
EF_DRIVER_STATUS EF_SPI_FifoRxFlush(EF_SPI_TYPE_PTR spi);

//! enables the SPI by setting the enable bit in the CTRL register to 1, enables spi master pulse generation
    /*!
        \param [in] "spi" An \ref EF_SPI_TYPE pointer, which points to the base memory address of SPI registers. \ref EF_SPI_TYPE is a structure that contains the SPI registers.

        \return status A value of type \ref EF_DRIVER_STATUS : returns a success or error code 
    */
EF_DRIVER_STATUS EF_SPI_enable(EF_SPI_TYPE_PTR spi);

//! disables the SPI by setting the enable bit in the CTRL register to 0, disables spi master pulse generation
    /*!
        \param [in] "spi" An \ref EF_SPI_TYPE pointer, which points to the base memory address of SPI registers. \ref EF_SPI_TYPE is a structure that contains the SPI registers.

        \return status A value of type \ref EF_DRIVER_STATUS : returns a success or error code 
    */
EF_DRIVER_STATUS EF_SPI_disable(EF_SPI_TYPE_PTR spi);

//! enables the RX by setting the RX enable bit in the CTRL register to 1, enables storing bytes recieved from slave in RX FIFO
    /*!
        \param [in] "spi" An \ref EF_SPI_TYPE pointer, which points to the base memory address of SPI registers. \ref EF_SPI_TYPE is a structure that contains the SPI registers.

        \return status A value of type \ref EF_DRIVER_STATUS : returns a success or error code 
    */
EF_DRIVER_STATUS EF_SPI_enableRx(EF_SPI_TYPE_PTR spi);

//! disables the RX by setting the RX enable bit in the CTRL register to 0, disables storing bytes recieved from slave in RX FIFO
    /*!
        \param [in] "spi" An \ref EF_SPI_TYPE pointer, which points to the base memory address of SPI registers. \ref EF_SPI_TYPE is a structure that contains the SPI registers.

        \return status A value of type \ref EF_DRIVER_STATUS : returns a success or error code 
    */
EF_DRIVER_STATUS EF_SPI_disableRx(EF_SPI_TYPE_PTR spi);

//! asserts the CS line by setting the SS bit in the CTRL register to 1, asserts the CS line to start a transaction with the slave
    /*!
        \param [in] "spi" An \ref EF_SPI_TYPE pointer, which points to the base memory address of SPI registers. \ref EF_SPI_TYPE is a structure that contains the SPI registers.

        \return status A value of type \ref EF_DRIVER_STATUS : returns a success or error code 
    */
EF_DRIVER_STATUS EF_SPI_assertCs(EF_SPI_TYPE_PTR spi);

//! deasserts the CS line by setting the SS bit in the CTRL register to 0, deasserts the CS line to end a transaction with the slave
    /*!
        \param [in] "spi" An \ref EF_SPI_TYPE pointer, which points to the base memory address of SPI registers. \ref EF_SPI_TYPE is a structure that contains the SPI registers.

        \return status A value of type \ref EF_DRIVER_STATUS : returns a success or error code 
    */
EF_DRIVER_STATUS EF_SPI_deassertCs(EF_SPI_TYPE_PTR spi);

//! sets the value of the Interrupts Masking Register; which enable and disables interrupts
//! The mask value is a 6-bit value, where each bit corresponds to a specific interrupt 
//! *  bit 0 TXE  :	Transmit FIFO is Empty.
//! *  bit 1 TXF  :	Transmit FIFO is Full.
//! *  bit 2 RXE  :	Receive FIFO is Empty.
//! *  bit 3 RXF  :	Receive FIFO is Full.
//! *  bit 4 TXB  :	Transmit FIFO level is Below Threshold.
//! *  bit 5 RXA  :	Receive FIFO level is Above Threshold.
    /*!
        \param [in]   spi An \ref EF_SPI_TYPE pointer, which points to the base memory address of SPI registers. \ref EF_SPI_TYPE is a structure that contains the SPI registers.
        \param [in]   "mask" The required mask value

        \return status A value of type \ref EF_DRIVER_STATUS : returns a success or error code 
    */
EF_DRIVER_STATUS EF_SPI_setIM(EF_SPI_TYPE_PTR spi, uint32_t mask);

// The following functions are not verified yet
/******************************************************************************************************************************************/
/******************************************************************************************************************************************/

//! gets the value of the Interrupts Masking Register; which enable and disables interrupts
//! The mask value is a 6-bit value, where each bit corresponds to a specific interrupt
//! *  bit 0 TXE  :	Transmit FIFO is Empty.
//! *  bit 1 TXF  :	Transmit FIFO is Full.
//! *  bit 2 RXE  :	Receive FIFO is Empty.
//! *  bit 3 RXF  :	Receive FIFO is Full.
//! *  bit 4 TXB  :	Transmit FIFO level is Below Threshold.
//! *  bit 5 RXA  :	Receive FIFO level is Above Threshold.
    /*!
        \param [in]   spi An \ref EF_SPI_TYPE pointer, which points to the base memory address of SPI registers. \ref EF_SPI_TYPE is a structure that contains the SPI registers.
        \param [out]  "mask" The required mask value

        \return status A value of type \ref EF_DRIVER_STATUS : returns a success or error code 
    */
EF_DRIVER_STATUS EF_SPI_getIM(EF_SPI_TYPE_PTR spi, uint32_t *mask);

//! gets the value of the Raw Interrupt Status Register; which shows the status of the interrupts
//! The mask value is a 6-bit value, where each bit corresponds to a specific interrupt
//! *  bit 0 TXE  :	Transmit FIFO is Empty.
//! *  bit 1 TXF  :	Transmit FIFO is Full.
//! *  bit 2 RXE  :	Receive FIFO is Empty.
//! *  bit 3 RXF  :	Receive FIFO is Full.
//! *  bit 4 TXB  :	Transmit FIFO level is Below Threshold.
//! *  bit 5 RXA  :	Receive FIFO level is Above Threshold.
    /*!
        \param [in]   spi An \ref EF_SPI_TYPE pointer, which points to the base memory address of SPI registers. \ref EF_SPI_TYPE is a structure that contains the SPI registers.
        \param [out]  "mask" The required mask value

        \return status A value of type \ref EF_DRIVER_STATUS : returns a success or error code 
    */
EF_DRIVER_STATUS EF_SPI_getRIS(EF_SPI_TYPE_PTR spi, uint32_t *mask);



//! gets the value of the Masked Interrupt Status Register; which shows the status of the interrupts after masking (ANDing) RIS by IM.
//! The mask value is a 6-bit value, where each bit corresponds to a specific interrupt
//! *  bit 0 TXE  :	Transmit FIFO is Empty.
//! *  bit 1 TXF  :	Transmit FIFO is Full.
//! *  bit 2 RXE  :	Receive FIFO is Empty.
//! *  bit 3 RXF  :	Receive FIFO is Full.
//! *  bit 4 TXB  :	Transmit FIFO level is Below Threshold.
//! *  bit 5 RXA  :	Receive FIFO level is Above Threshold.
    /*!
        \param [in]   spi An \ref EF_SPI_TYPE pointer, which points to the base memory address of SPI registers. \ref EF_SPI_TYPE is a structure that contains the SPI registers.
        \param [out]  "mask" The required mask value

        \return status A value of type \ref EF_DRIVER_STATUS : returns a success or error code 
    */
EF_DRIVER_STATUS EF_SPI_getMIS(EF_SPI_TYPE_PTR spi, uint32_t *mask);




//! sets the value of the Interrupt Clear Register; which clears the interrupts
//! The mask value is a 6-bit value, where each bit corresponds to a specific interrupt
//! *  bit 0 TXE  :	Transmit FIFO is Empty.
//! *  bit 1 TXF  :	Transmit FIFO is Full.
//! *  bit 2 RXE  :	Receive FIFO is Empty.
//! *  bit 3 RXF  :	Receive FIFO is Full.
//! *  bit 4 TXB  :	Transmit FIFO level is Below Threshold.
//! *  bit 5 RXA  :	Receive FIFO level is Above Threshold.
    /*!
        \param [in]   spi An \ref EF_SPI_TYPE pointer, which points to the base memory address of SPI registers. \ref EF_SPI_TYPE is a structure that contains the SPI registers.
        \param [in]   "mask" The required mask value

        \return status A value of type \ref EF_DRIVER_STATUS : returns a success or error code 
    */
EF_DRIVER_STATUS EF_SPI_setICR(EF_SPI_TYPE_PTR spi, uint32_t mask);


/******************************************************************************
* External Variables
******************************************************************************/




#endif // EF_SPI_H

/******************************************************************************
* End of File
******************************************************************************/