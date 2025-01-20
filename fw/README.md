# API Reference

## Header files

- [EF_Driver_Common.h](#file-ef_driver_commonh)
- [EF_SPI.h](#file-ef_spih)
- [EF_SPI_regs.h](#file-ef_spi_regsh)

## File EF_Driver_Common.h

_C header file for common driver definitions and types._



## Structures and Types

| Type | Name |
| ---: | :--- |
| typedef uint32\_t | [**EF\_DRIVER\_STATUS**](#typedef-ef_driver_status)  <br>_A type that is used to return the status of the driver functions._ |


## Macros

| Type | Name |
| ---: | :--- |
| define  | [**EF\_DRIVER\_ERROR**](#define-ef_driver_error)  ((uint32\_t)1)<br>_Unspecified error._ |
| define  | [**EF\_DRIVER\_ERROR\_BUSY**](#define-ef_driver_error_busy)  ((uint32\_t)2)<br>_Driver is busy._ |
| define  | [**EF\_DRIVER\_ERROR\_PARAMETER**](#define-ef_driver_error_parameter)  ((uint32\_t)5)<br>_Parameter error._ |
| define  | [**EF\_DRIVER\_ERROR\_SPECIFIC**](#define-ef_driver_error_specific)  ((uint32\_t)6)<br>_Start of driver specific errors._ |
| define  | [**EF\_DRIVER\_ERROR\_TIMEOUT**](#define-ef_driver_error_timeout)  ((uint32\_t)3)<br>_Timeout occurred._ |
| define  | [**EF\_DRIVER\_ERROR\_UNSUPPORTED**](#define-ef_driver_error_unsupported)  ((uint32\_t)4)<br>_Operation not supported._ |
| define  | [**EF\_DRIVER\_OK**](#define-ef_driver_ok)  ((uint32\_t)0)<br>_Operation succeeded._ |

## Structures and Types Documentation

### typedef `EF_DRIVER_STATUS`

_A type that is used to return the status of the driver functions._
```c
typedef uint32_t EF_DRIVER_STATUS;
```



## Macros Documentation

### define `EF_DRIVER_ERROR`

_Unspecified error._
```c
#define EF_DRIVER_ERROR ((uint32_t)1)
```

### define `EF_DRIVER_ERROR_BUSY`

_Driver is busy._
```c
#define EF_DRIVER_ERROR_BUSY ((uint32_t)2)
```

### define `EF_DRIVER_ERROR_PARAMETER`

_Parameter error._
```c
#define EF_DRIVER_ERROR_PARAMETER ((uint32_t)5)
```

### define `EF_DRIVER_ERROR_SPECIFIC`

_Start of driver specific errors._
```c
#define EF_DRIVER_ERROR_SPECIFIC ((uint32_t)6)
```

### define `EF_DRIVER_ERROR_TIMEOUT`

_Timeout occurred._
```c
#define EF_DRIVER_ERROR_TIMEOUT ((uint32_t)3)
```

### define `EF_DRIVER_ERROR_UNSUPPORTED`

_Operation not supported._
```c
#define EF_DRIVER_ERROR_UNSUPPORTED ((uint32_t)4)
```

### define `EF_DRIVER_OK`

_Operation succeeded._
```c
#define EF_DRIVER_OK ((uint32_t)0)
```


## File EF_SPI.h

_C header file for SPI APIs which contains the function prototypes._




## Functions

| Type | Name |
| ---: | :--- |
|  [**EF\_DRIVER\_STATUS**](#typedef-ef_driver_status) | [**EF\_SPI\_FifoRxFlush**](#function-ef_spi_fiforxflush) ([**EF\_SPI\_TYPE\_PTR**](#typedef-ef_spi_type_ptr) spi) <br>_flushes the RX FIFO by writing to the RX FIFO FLUSH register_ |
|  [**EF\_DRIVER\_STATUS**](#typedef-ef_driver_status) | [**EF\_SPI\_assertCs**](#function-ef_spi_assertcs) ([**EF\_SPI\_TYPE\_PTR**](#typedef-ef_spi_type_ptr) spi) <br>_asserts the CS line by setting the SS bit in the CTRL register to 1, asserts the CS line to start a transaction with the slave_ |
|  [**EF\_DRIVER\_STATUS**](#typedef-ef_driver_status) | [**EF\_SPI\_deassertCs**](#function-ef_spi_deassertcs) ([**EF\_SPI\_TYPE\_PTR**](#typedef-ef_spi_type_ptr) spi) <br>_deasserts the CS line by setting the SS bit in the CTRL register to 0, deasserts the CS line to end a transaction with the slave_ |
|  [**EF\_DRIVER\_STATUS**](#typedef-ef_driver_status) | [**EF\_SPI\_disable**](#function-ef_spi_disable) ([**EF\_SPI\_TYPE\_PTR**](#typedef-ef_spi_type_ptr) spi) <br>_disables the SPI by setting the enable bit in the CTRL register to 0, disables spi master pulse generation_ |
|  [**EF\_DRIVER\_STATUS**](#typedef-ef_driver_status) | [**EF\_SPI\_disableRx**](#function-ef_spi_disablerx) ([**EF\_SPI\_TYPE\_PTR**](#typedef-ef_spi_type_ptr) spi) <br>_disables the RX by setting the RX enable bit in the CTRL register to 0, disables storing bytes recieved from slave in RX FIFO_ |
|  [**EF\_DRIVER\_STATUS**](#typedef-ef_driver_status) | [**EF\_SPI\_enable**](#function-ef_spi_enable) ([**EF\_SPI\_TYPE\_PTR**](#typedef-ef_spi_type_ptr) spi) <br>_enables the SPI by setting the enable bit in the CTRL register to 1, enables spi master pulse generation_ |
|  [**EF\_DRIVER\_STATUS**](#typedef-ef_driver_status) | [**EF\_SPI\_enableRx**](#function-ef_spi_enablerx) ([**EF\_SPI\_TYPE\_PTR**](#typedef-ef_spi_type_ptr) spi) <br>_enables the RX by setting the RX enable bit in the CTRL register to 1, enables storing bytes recieved from slave in RX FIFO_ |
|  [**EF\_DRIVER\_STATUS**](#typedef-ef_driver_status) | [**EF\_SPI\_getIM**](#function-ef_spi_getim) ([**EF\_SPI\_TYPE\_PTR**](#typedef-ef_spi_type_ptr) spi, uint32\_t \*mask) <br> |
|  [**EF\_DRIVER\_STATUS**](#typedef-ef_driver_status) | [**EF\_SPI\_getMIS**](#function-ef_spi_getmis) ([**EF\_SPI\_TYPE\_PTR**](#typedef-ef_spi_type_ptr) spi, uint32\_t \*mask) <br> |
|  [**EF\_DRIVER\_STATUS**](#typedef-ef_driver_status) | [**EF\_SPI\_getRIS**](#function-ef_spi_getris) ([**EF\_SPI\_TYPE\_PTR**](#typedef-ef_spi_type_ptr) spi, uint32\_t \*mask) <br> |
|  [**EF\_DRIVER\_STATUS**](#typedef-ef_driver_status) | [**EF\_SPI\_isRxFifoEmpty**](#function-ef_spi_isrxfifoempty) ([**EF\_SPI\_TYPE\_PTR**](#typedef-ef_spi_type_ptr) spi, uint32\_t \*RXfifo\_state) <br>_reads the RX FIFO empty flag from the STATUS register_ |
|  [**EF\_DRIVER\_STATUS**](#typedef-ef_driver_status) | [**EF\_SPI\_isTxFifoEmpty**](#function-ef_spi_istxfifoempty) ([**EF\_SPI\_TYPE\_PTR**](#typedef-ef_spi_type_ptr) spi, uint32\_t \*TXfifo\_state) <br>_reads the TX FIFO empty flag from the STATUS register_ |
|  [**EF\_DRIVER\_STATUS**](#typedef-ef_driver_status) | [**EF\_SPI\_readData**](#function-ef_spi_readdata) ([**EF\_SPI\_TYPE\_PTR**](#typedef-ef_spi_type_ptr) spi, uint32\_t \*data) <br>_reads a byte of data from the RXDATA register_ |
|  [**EF\_DRIVER\_STATUS**](#typedef-ef_driver_status) | [**EF\_SPI\_setGclkEnable**](#function-ef_spi_setgclkenable) ([**EF\_SPI\_TYPE\_PTR**](#typedef-ef_spi_type_ptr) spi, uint32\_t value) <br>_sets the GCLK enable bit in the SPI register to a certain value_ |
|  [**EF\_DRIVER\_STATUS**](#typedef-ef_driver_status) | [**EF\_SPI\_setICR**](#function-ef_spi_seticr) ([**EF\_SPI\_TYPE\_PTR**](#typedef-ef_spi_type_ptr) spi, uint32\_t mask) <br> |
|  [**EF\_DRIVER\_STATUS**](#typedef-ef_driver_status) | [**EF\_SPI\_setIM**](#function-ef_spi_setim) ([**EF\_SPI\_TYPE\_PTR**](#typedef-ef_spi_type_ptr) spi, uint32\_t mask) <br> |
|  [**EF\_DRIVER\_STATUS**](#typedef-ef_driver_status) | [**EF\_SPI\_setPhase**](#function-ef_spi_setphase) ([**EF\_SPI\_TYPE\_PTR**](#typedef-ef_spi_type_ptr) spi, bool phase) <br>_sets the clock phase of the SPI in the CFG register to a certain value_ |
|  [**EF\_DRIVER\_STATUS**](#typedef-ef_driver_status) | [**EF\_SPI\_setpolarity**](#function-ef_spi_setpolarity) ([**EF\_SPI\_TYPE\_PTR**](#typedef-ef_spi_type_ptr) spi, bool polarity) <br>_sets the clock polarity of the SPI in the CFG register to a certain value_ |
|  [**EF\_DRIVER\_STATUS**](#typedef-ef_driver_status) | [**EF\_SPI\_waitRxFifoNotEmpty**](#function-ef_spi_waitrxfifonotempty) ([**EF\_SPI\_TYPE\_PTR**](#typedef-ef_spi_type_ptr) spi) <br>_waits for the RX FIFO to be not empty by polling the RX FIFO empty flag in the STATUS register_ |
|  [**EF\_DRIVER\_STATUS**](#typedef-ef_driver_status) | [**EF\_SPI\_waitTxFifoEmpty**](#function-ef_spi_waittxfifoempty) ([**EF\_SPI\_TYPE\_PTR**](#typedef-ef_spi_type_ptr) spi) <br>_waits for the TX FIFO to be empty by polling the TX FIFO empty flag in the STATUS register_ |
|  [**EF\_DRIVER\_STATUS**](#typedef-ef_driver_status) | [**EF\_SPI\_writeData**](#function-ef_spi_writedata) ([**EF\_SPI\_TYPE\_PTR**](#typedef-ef_spi_type_ptr) spi, uint32\_t data) <br>_writes a byte of data to the TXDATA register_ |

## Macros

| Type | Name |
| ---: | :--- |
| define  | [**EF\_SPI\_TXDATA\_MAX\_VALUE**](#define-ef_spi_txdata_max_value)  ((uint32\_t)0x000000FF)<br> |


## Functions Documentation

### function `EF_SPI_FifoRxFlush`

_flushes the RX FIFO by writing to the RX FIFO FLUSH register_
```c
EF_DRIVER_STATUS EF_SPI_FifoRxFlush (
    EF_SPI_TYPE_PTR spi
) 
```


**Parameters:**


* `spi` An [**EF\_SPI\_TYPE**](#typedef-ef_spi_type) pointer, which points to the base memory address of SPI registers.[**EF\_SPI\_TYPE**](#typedef-ef_spi_type) is a structure that contains the SPI registers.


**Returns:**

status A value of type [**EF\_DRIVER\_STATUS**](#typedef-ef_driver_status) : returns a success or error code
### function `EF_SPI_assertCs`

_asserts the CS line by setting the SS bit in the CTRL register to 1, asserts the CS line to start a transaction with the slave_
```c
EF_DRIVER_STATUS EF_SPI_assertCs (
    EF_SPI_TYPE_PTR spi
) 
```


**Parameters:**


* `spi` An [**EF\_SPI\_TYPE**](#typedef-ef_spi_type) pointer, which points to the base memory address of SPI registers.[**EF\_SPI\_TYPE**](#typedef-ef_spi_type) is a structure that contains the SPI registers.


**Returns:**

status A value of type [**EF\_DRIVER\_STATUS**](#typedef-ef_driver_status) : returns a success or error code
### function `EF_SPI_deassertCs`

_deasserts the CS line by setting the SS bit in the CTRL register to 0, deasserts the CS line to end a transaction with the slave_
```c
EF_DRIVER_STATUS EF_SPI_deassertCs (
    EF_SPI_TYPE_PTR spi
) 
```


**Parameters:**


* `spi` An [**EF\_SPI\_TYPE**](#typedef-ef_spi_type) pointer, which points to the base memory address of SPI registers.[**EF\_SPI\_TYPE**](#typedef-ef_spi_type) is a structure that contains the SPI registers.


**Returns:**

status A value of type [**EF\_DRIVER\_STATUS**](#typedef-ef_driver_status) : returns a success or error code
### function `EF_SPI_disable`

_disables the SPI by setting the enable bit in the CTRL register to 0, disables spi master pulse generation_
```c
EF_DRIVER_STATUS EF_SPI_disable (
    EF_SPI_TYPE_PTR spi
) 
```


**Parameters:**


* `spi` An [**EF\_SPI\_TYPE**](#typedef-ef_spi_type) pointer, which points to the base memory address of SPI registers.[**EF\_SPI\_TYPE**](#typedef-ef_spi_type) is a structure that contains the SPI registers.


**Returns:**

status A value of type [**EF\_DRIVER\_STATUS**](#typedef-ef_driver_status) : returns a success or error code
### function `EF_SPI_disableRx`

_disables the RX by setting the RX enable bit in the CTRL register to 0, disables storing bytes recieved from slave in RX FIFO_
```c
EF_DRIVER_STATUS EF_SPI_disableRx (
    EF_SPI_TYPE_PTR spi
) 
```


**Parameters:**


* `spi` An [**EF\_SPI\_TYPE**](#typedef-ef_spi_type) pointer, which points to the base memory address of SPI registers.[**EF\_SPI\_TYPE**](#typedef-ef_spi_type) is a structure that contains the SPI registers.


**Returns:**

status A value of type [**EF\_DRIVER\_STATUS**](#typedef-ef_driver_status) : returns a success or error code
### function `EF_SPI_enable`

_enables the SPI by setting the enable bit in the CTRL register to 1, enables spi master pulse generation_
```c
EF_DRIVER_STATUS EF_SPI_enable (
    EF_SPI_TYPE_PTR spi
) 
```


**Parameters:**


* `spi` An [**EF\_SPI\_TYPE**](#typedef-ef_spi_type) pointer, which points to the base memory address of SPI registers.[**EF\_SPI\_TYPE**](#typedef-ef_spi_type) is a structure that contains the SPI registers.


**Returns:**

status A value of type [**EF\_DRIVER\_STATUS**](#typedef-ef_driver_status) : returns a success or error code
### function `EF_SPI_enableRx`

_enables the RX by setting the RX enable bit in the CTRL register to 1, enables storing bytes recieved from slave in RX FIFO_
```c
EF_DRIVER_STATUS EF_SPI_enableRx (
    EF_SPI_TYPE_PTR spi
) 
```


**Parameters:**


* `spi` An [**EF\_SPI\_TYPE**](#typedef-ef_spi_type) pointer, which points to the base memory address of SPI registers.[**EF\_SPI\_TYPE**](#typedef-ef_spi_type) is a structure that contains the SPI registers.


**Returns:**

status A value of type [**EF\_DRIVER\_STATUS**](#typedef-ef_driver_status) : returns a success or error code
### function `EF_SPI_getIM`

```c
EF_DRIVER_STATUS EF_SPI_getIM (
    EF_SPI_TYPE_PTR spi,
    uint32_t *mask
) 
```


gets the value of the Interrupts Masking Register; which enable and disables interrupts The mask value is a 6-bit value, where each bit corresponds to a specific interrupt

* bit 0 TXE : Transmit FIFO is Empty.
* bit 1 TXF : Transmit FIFO is Full.
* bit 2 RXE : Receive FIFO is Empty.
* bit 3 RXF : Receive FIFO is Full.
* bit 4 TXB : Transmit FIFO level is Below Threshold.
* bit 5 RXA : Receive FIFO level is Above Threshold.



**Parameters:**


* `spi` An [**EF\_SPI\_TYPE**](#typedef-ef_spi_type) pointer, which points to the base memory address of SPI registers.[**EF\_SPI\_TYPE**](#typedef-ef_spi_type) is a structure that contains the SPI registers.
* `mask` The required mask value


**Returns:**

status A value of type [**EF\_DRIVER\_STATUS**](#typedef-ef_driver_status) : returns a success or error code
### function `EF_SPI_getMIS`

```c
EF_DRIVER_STATUS EF_SPI_getMIS (
    EF_SPI_TYPE_PTR spi,
    uint32_t *mask
) 
```


gets the value of the Masked Interrupt Status Register; which shows the status of the interrupts after masking (ANDing) RIS by IM. The mask value is a 6-bit value, where each bit corresponds to a specific interrupt

* bit 0 TXE : Transmit FIFO is Empty.
* bit 1 TXF : Transmit FIFO is Full.
* bit 2 RXE : Receive FIFO is Empty.
* bit 3 RXF : Receive FIFO is Full.
* bit 4 TXB : Transmit FIFO level is Below Threshold.
* bit 5 RXA : Receive FIFO level is Above Threshold.



**Parameters:**


* `spi` An [**EF\_SPI\_TYPE**](#typedef-ef_spi_type) pointer, which points to the base memory address of SPI registers.[**EF\_SPI\_TYPE**](#typedef-ef_spi_type) is a structure that contains the SPI registers.
* `mask` The required mask value


**Returns:**

status A value of type [**EF\_DRIVER\_STATUS**](#typedef-ef_driver_status) : returns a success or error code
### function `EF_SPI_getRIS`

```c
EF_DRIVER_STATUS EF_SPI_getRIS (
    EF_SPI_TYPE_PTR spi,
    uint32_t *mask
) 
```


gets the value of the Raw Interrupt Status Register; which shows the status of the interrupts The mask value is a 6-bit value, where each bit corresponds to a specific interrupt

* bit 0 TXE : Transmit FIFO is Empty.
* bit 1 TXF : Transmit FIFO is Full.
* bit 2 RXE : Receive FIFO is Empty.
* bit 3 RXF : Receive FIFO is Full.
* bit 4 TXB : Transmit FIFO level is Below Threshold.
* bit 5 RXA : Receive FIFO level is Above Threshold.



**Parameters:**


* `spi` An [**EF\_SPI\_TYPE**](#typedef-ef_spi_type) pointer, which points to the base memory address of SPI registers.[**EF\_SPI\_TYPE**](#typedef-ef_spi_type) is a structure that contains the SPI registers.
* `mask` The required mask value


**Returns:**

status A value of type [**EF\_DRIVER\_STATUS**](#typedef-ef_driver_status) : returns a success or error code
### function `EF_SPI_isRxFifoEmpty`

_reads the RX FIFO empty flag from the STATUS register_
```c
EF_DRIVER_STATUS EF_SPI_isRxFifoEmpty (
    EF_SPI_TYPE_PTR spi,
    uint32_t *RXfifo_state
) 
```


**Parameters:**


* `spi` An [**EF\_SPI\_TYPE**](#typedef-ef_spi_type) pointer, which points to the base memory address of SPI registers.[**EF\_SPI\_TYPE**](#typedef-ef_spi_type) is a structure that contains the SPI registers.
* `RXfifo_state` The RX FIFO empty flag value


**Returns:**

status A value of type [**EF\_DRIVER\_STATUS**](#typedef-ef_driver_status) : returns a success or error code
### function `EF_SPI_isTxFifoEmpty`

_reads the TX FIFO empty flag from the STATUS register_
```c
EF_DRIVER_STATUS EF_SPI_isTxFifoEmpty (
    EF_SPI_TYPE_PTR spi,
    uint32_t *TXfifo_state
) 
```


**Parameters:**


* `spi` An [**EF\_SPI\_TYPE**](#typedef-ef_spi_type) pointer, which points to the base memory address of SPI registers.[**EF\_SPI\_TYPE**](#typedef-ef_spi_type) is a structure that contains the SPI registers.
* `TXfifo_state` The TX FIFO empty flag value


**Returns:**

status A value of type [**EF\_DRIVER\_STATUS**](#typedef-ef_driver_status) : returns a success or error code
### function `EF_SPI_readData`

_reads a byte of data from the RXDATA register_
```c
EF_DRIVER_STATUS EF_SPI_readData (
    EF_SPI_TYPE_PTR spi,
    uint32_t *data
) 
```


**Parameters:**


* `spi` An [**EF\_SPI\_TYPE**](#typedef-ef_spi_type) pointer, which points to the base memory address of SPI registers.[**EF\_SPI\_TYPE**](#typedef-ef_spi_type) is a structure that contains the SPI registers.
* `data` The data read from the RXDATA register


**Returns:**

status A value of type [**EF\_DRIVER\_STATUS**](#typedef-ef_driver_status) : returns a success or error code
### function `EF_SPI_setGclkEnable`

_sets the GCLK enable bit in the SPI register to a certain value_
```c
EF_DRIVER_STATUS EF_SPI_setGclkEnable (
    EF_SPI_TYPE_PTR spi,
    uint32_t value
) 
```


**Parameters:**


* `spi` An [**EF\_SPI\_TYPE**](#typedef-ef_spi_type) pointer, which points to the base memory address of SPI registers.[**EF\_SPI\_TYPE**](#typedef-ef_spi_type) is a structure that contains the SPI registers.
* `value` The value of the GCLK enable bit


**Returns:**

status A value of type [**EF\_DRIVER\_STATUS**](#typedef-ef_driver_status) : returns a success or error code
### function `EF_SPI_setICR`

```c
EF_DRIVER_STATUS EF_SPI_setICR (
    EF_SPI_TYPE_PTR spi,
    uint32_t mask
) 
```


sets the value of the Interrupt Clear Register; which clears the interrupts The mask value is a 6-bit value, where each bit corresponds to a specific interrupt

* bit 0 TXE : Transmit FIFO is Empty.
* bit 1 TXF : Transmit FIFO is Full.
* bit 2 RXE : Receive FIFO is Empty.
* bit 3 RXF : Receive FIFO is Full.
* bit 4 TXB : Transmit FIFO level is Below Threshold.
* bit 5 RXA : Receive FIFO level is Above Threshold.



**Parameters:**


* `spi` An [**EF\_SPI\_TYPE**](#typedef-ef_spi_type) pointer, which points to the base memory address of SPI registers.[**EF\_SPI\_TYPE**](#typedef-ef_spi_type) is a structure that contains the SPI registers.
* `mask` The required mask value


**Returns:**

status A value of type [**EF\_DRIVER\_STATUS**](#typedef-ef_driver_status) : returns a success or error code
### function `EF_SPI_setIM`

```c
EF_DRIVER_STATUS EF_SPI_setIM (
    EF_SPI_TYPE_PTR spi,
    uint32_t mask
) 
```


sets the value of the Interrupts Masking Register; which enable and disables interrupts The mask value is a 6-bit value, where each bit corresponds to a specific interrupt

* bit 0 TXE : Transmit FIFO is Empty.
* bit 1 TXF : Transmit FIFO is Full.
* bit 2 RXE : Receive FIFO is Empty.
* bit 3 RXF : Receive FIFO is Full.
* bit 4 TXB : Transmit FIFO level is Below Threshold.
* bit 5 RXA : Receive FIFO level is Above Threshold.



**Parameters:**


* `spi` An [**EF\_SPI\_TYPE**](#typedef-ef_spi_type) pointer, which points to the base memory address of SPI registers.[**EF\_SPI\_TYPE**](#typedef-ef_spi_type) is a structure that contains the SPI registers.
* `mask` The required mask value


**Returns:**

status A value of type [**EF\_DRIVER\_STATUS**](#typedef-ef_driver_status) : returns a success or error code
### function `EF_SPI_setPhase`

_sets the clock phase of the SPI in the CFG register to a certain value_
```c
EF_DRIVER_STATUS EF_SPI_setPhase (
    EF_SPI_TYPE_PTR spi,
    bool phase
) 
```


**Parameters:**


* `spi` An [**EF\_SPI\_TYPE**](#typedef-ef_spi_type) pointer, which points to the base memory address of SPI registers.[**EF\_SPI\_TYPE**](#typedef-ef_spi_type) is a structure that contains the SPI registers.
* `phase` The clock phase value


**Returns:**

status A value of type [**EF\_DRIVER\_STATUS**](#typedef-ef_driver_status) : returns a success or error code
### function `EF_SPI_setpolarity`

_sets the clock polarity of the SPI in the CFG register to a certain value_
```c
EF_DRIVER_STATUS EF_SPI_setpolarity (
    EF_SPI_TYPE_PTR spi,
    bool polarity
) 
```


**Parameters:**


* `spi` An [**EF\_SPI\_TYPE**](#typedef-ef_spi_type) pointer, which points to the base memory address of SPI registers.[**EF\_SPI\_TYPE**](#typedef-ef_spi_type) is a structure that contains the SPI registers.
* `polarity` The clock polarity value


**Returns:**

status A value of type [**EF\_DRIVER\_STATUS**](#typedef-ef_driver_status) : returns a success or error code
### function `EF_SPI_waitRxFifoNotEmpty`

_waits for the RX FIFO to be not empty by polling the RX FIFO empty flag in the STATUS register_
```c
EF_DRIVER_STATUS EF_SPI_waitRxFifoNotEmpty (
    EF_SPI_TYPE_PTR spi
) 
```


**Parameters:**


* `spi` An [**EF\_SPI\_TYPE**](#typedef-ef_spi_type) pointer, which points to the base memory address of SPI registers.[**EF\_SPI\_TYPE**](#typedef-ef_spi_type) is a structure that contains the SPI registers.


**Returns:**

status A value of type [**EF\_DRIVER\_STATUS**](#typedef-ef_driver_status) : returns a success or error code
### function `EF_SPI_waitTxFifoEmpty`

_waits for the TX FIFO to be empty by polling the TX FIFO empty flag in the STATUS register_
```c
EF_DRIVER_STATUS EF_SPI_waitTxFifoEmpty (
    EF_SPI_TYPE_PTR spi
) 
```


**Parameters:**


* `spi` An [**EF\_SPI\_TYPE**](#typedef-ef_spi_type) pointer, which points to the base memory address of SPI registers.[**EF\_SPI\_TYPE**](#typedef-ef_spi_type) is a structure that contains the SPI registers.


**Returns:**

status A value of type [**EF\_DRIVER\_STATUS**](#typedef-ef_driver_status) : returns a success or error code
### function `EF_SPI_writeData`

_writes a byte of data to the TXDATA register_
```c
EF_DRIVER_STATUS EF_SPI_writeData (
    EF_SPI_TYPE_PTR spi,
    uint32_t data
) 
```


**Parameters:**


* `spi` An [**EF\_SPI\_TYPE**](#typedef-ef_spi_type) pointer, which points to the base memory address of SPI registers.[**EF\_SPI\_TYPE**](#typedef-ef_spi_type) is a structure that contains the SPI registers.
* `data` The data to be written to the TXDATA register


**Returns:**

status A value of type [**EF\_DRIVER\_STATUS**](#typedef-ef_driver_status) : returns a success or error code

## Macros Documentation

### define `EF_SPI_TXDATA_MAX_VALUE`

```c
#define EF_SPI_TXDATA_MAX_VALUE ((uint32_t)0x000000FF)
```


## File EF_SPI_regs.h





## Structures and Types

| Type | Name |
| ---: | :--- |
| typedef struct [**\_EF\_SPI\_TYPE\_**](#struct-_ef_spi_type_) | [**EF\_SPI\_TYPE**](#typedef-ef_spi_type)  <br> |
| typedef [**EF\_SPI\_TYPE**](#typedef-ef_spi_type) \* | [**EF\_SPI\_TYPE\_PTR**](#typedef-ef_spi_type_ptr)  <br> |
| struct | [**\_EF\_SPI\_TYPE\_**](#struct-_ef_spi_type_) <br> |


## Macros

| Type | Name |
| ---: | :--- |
| define  | [**EF\_SPI\_CFG\_REG\_CPHA\_BIT**](#define-ef_spi_cfg_reg_cpha_bit)  ((uint32\_t)1)<br> |
| define  | [**EF\_SPI\_CFG\_REG\_CPHA\_MASK**](#define-ef_spi_cfg_reg_cpha_mask)  ((uint32\_t)0x2)<br> |
| define  | [**EF\_SPI\_CFG\_REG\_CPOL\_BIT**](#define-ef_spi_cfg_reg_cpol_bit)  ((uint32\_t)0)<br> |
| define  | [**EF\_SPI\_CFG\_REG\_CPOL\_MASK**](#define-ef_spi_cfg_reg_cpol_mask)  ((uint32\_t)0x1)<br> |
| define  | [**EF\_SPI\_CTRL\_REG\_ENABLE\_BIT**](#define-ef_spi_ctrl_reg_enable_bit)  ((uint32\_t)1)<br> |
| define  | [**EF\_SPI\_CTRL\_REG\_ENABLE\_MASK**](#define-ef_spi_ctrl_reg_enable_mask)  ((uint32\_t)0x2)<br> |
| define  | [**EF\_SPI\_CTRL\_REG\_RX\_EN\_BIT**](#define-ef_spi_ctrl_reg_rx_en_bit)  ((uint32\_t)2)<br> |
| define  | [**EF\_SPI\_CTRL\_REG\_RX\_EN\_MASK**](#define-ef_spi_ctrl_reg_rx_en_mask)  ((uint32\_t)0x4)<br> |
| define  | [**EF\_SPI\_CTRL\_REG\_SS\_BIT**](#define-ef_spi_ctrl_reg_ss_bit)  ((uint32\_t)0)<br> |
| define  | [**EF\_SPI\_CTRL\_REG\_SS\_MASK**](#define-ef_spi_ctrl_reg_ss_mask)  ((uint32\_t)0x1)<br> |
| define  | [**EF\_SPI\_RXA\_FLAG**](#define-ef_spi_rxa_flag)  ((uint32\_t)0x20)<br> |
| define  | [**EF\_SPI\_RXE\_FLAG**](#define-ef_spi_rxe_flag)  ((uint32\_t)0x4)<br> |
| define  | [**EF\_SPI\_RXF\_FLAG**](#define-ef_spi_rxf_flag)  ((uint32\_t)0x8)<br> |
| define  | [**EF\_SPI\_RX\_FIFO\_FLUSH\_REG\_FLUSH\_BIT**](#define-ef_spi_rx_fifo_flush_reg_flush_bit)  ((uint32\_t)0)<br> |
| define  | [**EF\_SPI\_RX\_FIFO\_FLUSH\_REG\_FLUSH\_MASK**](#define-ef_spi_rx_fifo_flush_reg_flush_mask)  ((uint32\_t)0x1)<br> |
| define  | [**EF\_SPI\_RX\_FIFO\_LEVEL\_REG\_LEVEL\_BIT**](#define-ef_spi_rx_fifo_level_reg_level_bit)  ((uint32\_t)0)<br> |
| define  | [**EF\_SPI\_RX\_FIFO\_LEVEL\_REG\_LEVEL\_MASK**](#define-ef_spi_rx_fifo_level_reg_level_mask)  ((uint32\_t)0xf)<br> |
| define  | [**EF\_SPI\_RX\_FIFO\_THRESHOLD\_REG\_THRESHOLD\_BIT**](#define-ef_spi_rx_fifo_threshold_reg_threshold_bit)  ((uint32\_t)0)<br> |
| define  | [**EF\_SPI\_RX\_FIFO\_THRESHOLD\_REG\_THRESHOLD\_MASK**](#define-ef_spi_rx_fifo_threshold_reg_threshold_mask)  ((uint32\_t)0xf)<br> |
| define  | [**EF\_SPI\_STATUS\_REG\_RX\_A\_BIT**](#define-ef_spi_status_reg_rx_a_bit)  ((uint32\_t)5)<br> |
| define  | [**EF\_SPI\_STATUS\_REG\_RX\_A\_MASK**](#define-ef_spi_status_reg_rx_a_mask)  ((uint32\_t)0x20)<br> |
| define  | [**EF\_SPI\_STATUS\_REG\_RX\_E\_BIT**](#define-ef_spi_status_reg_rx_e_bit)  ((uint32\_t)2)<br> |
| define  | [**EF\_SPI\_STATUS\_REG\_RX\_E\_MASK**](#define-ef_spi_status_reg_rx_e_mask)  ((uint32\_t)0x4)<br> |
| define  | [**EF\_SPI\_STATUS\_REG\_RX\_F\_BIT**](#define-ef_spi_status_reg_rx_f_bit)  ((uint32\_t)3)<br> |
| define  | [**EF\_SPI\_STATUS\_REG\_RX\_F\_MASK**](#define-ef_spi_status_reg_rx_f_mask)  ((uint32\_t)0x8)<br> |
| define  | [**EF\_SPI\_STATUS\_REG\_TX\_B\_BIT**](#define-ef_spi_status_reg_tx_b_bit)  ((uint32\_t)4)<br> |
| define  | [**EF\_SPI\_STATUS\_REG\_TX\_B\_MASK**](#define-ef_spi_status_reg_tx_b_mask)  ((uint32\_t)0x10)<br> |
| define  | [**EF\_SPI\_STATUS\_REG\_TX\_E\_BIT**](#define-ef_spi_status_reg_tx_e_bit)  ((uint32\_t)0)<br> |
| define  | [**EF\_SPI\_STATUS\_REG\_TX\_E\_MASK**](#define-ef_spi_status_reg_tx_e_mask)  ((uint32\_t)0x1)<br> |
| define  | [**EF\_SPI\_STATUS\_REG\_TX\_F\_BIT**](#define-ef_spi_status_reg_tx_f_bit)  ((uint32\_t)1)<br> |
| define  | [**EF\_SPI\_STATUS\_REG\_TX\_F\_MASK**](#define-ef_spi_status_reg_tx_f_mask)  ((uint32\_t)0x2)<br> |
| define  | [**EF\_SPI\_TXB\_FLAG**](#define-ef_spi_txb_flag)  ((uint32\_t)0x10)<br> |
| define  | [**EF\_SPI\_TXE\_FLAG**](#define-ef_spi_txe_flag)  ((uint32\_t)0x1)<br> |
| define  | [**EF\_SPI\_TXF\_FLAG**](#define-ef_spi_txf_flag)  ((uint32\_t)0x2)<br> |
| define  | [**EF\_SPI\_TX\_FIFO\_FLUSH\_REG\_FLUSH\_BIT**](#define-ef_spi_tx_fifo_flush_reg_flush_bit)  ((uint32\_t)0)<br> |
| define  | [**EF\_SPI\_TX\_FIFO\_FLUSH\_REG\_FLUSH\_MASK**](#define-ef_spi_tx_fifo_flush_reg_flush_mask)  ((uint32\_t)0x1)<br> |
| define  | [**EF\_SPI\_TX\_FIFO\_LEVEL\_REG\_LEVEL\_BIT**](#define-ef_spi_tx_fifo_level_reg_level_bit)  ((uint32\_t)0)<br> |
| define  | [**EF\_SPI\_TX\_FIFO\_LEVEL\_REG\_LEVEL\_MASK**](#define-ef_spi_tx_fifo_level_reg_level_mask)  ((uint32\_t)0xf)<br> |
| define  | [**EF\_SPI\_TX\_FIFO\_THRESHOLD\_REG\_THRESHOLD\_BIT**](#define-ef_spi_tx_fifo_threshold_reg_threshold_bit)  ((uint32\_t)0)<br> |
| define  | [**EF\_SPI\_TX\_FIFO\_THRESHOLD\_REG\_THRESHOLD\_MASK**](#define-ef_spi_tx_fifo_threshold_reg_threshold_mask)  ((uint32\_t)0xf)<br> |
| define  | [**IO\_TYPES**](#define-io_types)  <br> |
| define  | [**\_\_R**](#define-__r)  volatile const uint32\_t<br> |
| define  | [**\_\_RW**](#define-__rw)  volatile       uint32\_t<br> |
| define  | [**\_\_W**](#define-__w)  volatile       uint32\_t<br> |

## Structures and Types Documentation

### typedef `EF_SPI_TYPE`

```c
typedef struct _EF_SPI_TYPE_ EF_SPI_TYPE;
```

### typedef `EF_SPI_TYPE_PTR`

```c
typedef EF_SPI_TYPE* EF_SPI_TYPE_PTR;
```

### struct `_EF_SPI_TYPE_`


Variables:

-  [**\_\_W**](#define-__w) CFG  

-  [**\_\_W**](#define-__w) CTRL  

-  [**\_\_W**](#define-__w) GCLK  

-  [**\_\_W**](#define-__w) IC  

-  [**\_\_RW**](#define-__rw) IM  

-  [**\_\_R**](#define-__r) MIS  

-  [**\_\_W**](#define-__w) PR  

-  [**\_\_R**](#define-__r) RIS  

-  [**\_\_R**](#define-__r) RXDATA  

-  [**\_\_W**](#define-__w) RX_FIFO_FLUSH  

-  [**\_\_R**](#define-__r) RX_FIFO_LEVEL  

-  [**\_\_W**](#define-__w) RX_FIFO_THRESHOLD  

-  [**\_\_R**](#define-__r) STATUS  

-  [**\_\_W**](#define-__w) TXDATA  

-  [**\_\_W**](#define-__w) TX_FIFO_FLUSH  

-  [**\_\_R**](#define-__r) TX_FIFO_LEVEL  

-  [**\_\_W**](#define-__w) TX_FIFO_THRESHOLD  

-  [**\_\_R**](#define-__r) reserved_0  

-  [**\_\_R**](#define-__r) reserved_1  

-  [**\_\_R**](#define-__r) reserved_2  



## Macros Documentation

### define `EF_SPI_CFG_REG_CPHA_BIT`

```c
#define EF_SPI_CFG_REG_CPHA_BIT ((uint32_t)1)
```

### define `EF_SPI_CFG_REG_CPHA_MASK`

```c
#define EF_SPI_CFG_REG_CPHA_MASK ((uint32_t)0x2)
```

### define `EF_SPI_CFG_REG_CPOL_BIT`

```c
#define EF_SPI_CFG_REG_CPOL_BIT ((uint32_t)0)
```

### define `EF_SPI_CFG_REG_CPOL_MASK`

```c
#define EF_SPI_CFG_REG_CPOL_MASK ((uint32_t)0x1)
```

### define `EF_SPI_CTRL_REG_ENABLE_BIT`

```c
#define EF_SPI_CTRL_REG_ENABLE_BIT ((uint32_t)1)
```

### define `EF_SPI_CTRL_REG_ENABLE_MASK`

```c
#define EF_SPI_CTRL_REG_ENABLE_MASK ((uint32_t)0x2)
```

### define `EF_SPI_CTRL_REG_RX_EN_BIT`

```c
#define EF_SPI_CTRL_REG_RX_EN_BIT ((uint32_t)2)
```

### define `EF_SPI_CTRL_REG_RX_EN_MASK`

```c
#define EF_SPI_CTRL_REG_RX_EN_MASK ((uint32_t)0x4)
```

### define `EF_SPI_CTRL_REG_SS_BIT`

```c
#define EF_SPI_CTRL_REG_SS_BIT ((uint32_t)0)
```

### define `EF_SPI_CTRL_REG_SS_MASK`

```c
#define EF_SPI_CTRL_REG_SS_MASK ((uint32_t)0x1)
```

### define `EF_SPI_RXA_FLAG`

```c
#define EF_SPI_RXA_FLAG ((uint32_t)0x20)
```

### define `EF_SPI_RXE_FLAG`

```c
#define EF_SPI_RXE_FLAG ((uint32_t)0x4)
```

### define `EF_SPI_RXF_FLAG`

```c
#define EF_SPI_RXF_FLAG ((uint32_t)0x8)
```

### define `EF_SPI_RX_FIFO_FLUSH_REG_FLUSH_BIT`

```c
#define EF_SPI_RX_FIFO_FLUSH_REG_FLUSH_BIT ((uint32_t)0)
```

### define `EF_SPI_RX_FIFO_FLUSH_REG_FLUSH_MASK`

```c
#define EF_SPI_RX_FIFO_FLUSH_REG_FLUSH_MASK ((uint32_t)0x1)
```

### define `EF_SPI_RX_FIFO_LEVEL_REG_LEVEL_BIT`

```c
#define EF_SPI_RX_FIFO_LEVEL_REG_LEVEL_BIT ((uint32_t)0)
```

### define `EF_SPI_RX_FIFO_LEVEL_REG_LEVEL_MASK`

```c
#define EF_SPI_RX_FIFO_LEVEL_REG_LEVEL_MASK ((uint32_t)0xf)
```

### define `EF_SPI_RX_FIFO_THRESHOLD_REG_THRESHOLD_BIT`

```c
#define EF_SPI_RX_FIFO_THRESHOLD_REG_THRESHOLD_BIT ((uint32_t)0)
```

### define `EF_SPI_RX_FIFO_THRESHOLD_REG_THRESHOLD_MASK`

```c
#define EF_SPI_RX_FIFO_THRESHOLD_REG_THRESHOLD_MASK ((uint32_t)0xf)
```

### define `EF_SPI_STATUS_REG_RX_A_BIT`

```c
#define EF_SPI_STATUS_REG_RX_A_BIT ((uint32_t)5)
```

### define `EF_SPI_STATUS_REG_RX_A_MASK`

```c
#define EF_SPI_STATUS_REG_RX_A_MASK ((uint32_t)0x20)
```

### define `EF_SPI_STATUS_REG_RX_E_BIT`

```c
#define EF_SPI_STATUS_REG_RX_E_BIT ((uint32_t)2)
```

### define `EF_SPI_STATUS_REG_RX_E_MASK`

```c
#define EF_SPI_STATUS_REG_RX_E_MASK ((uint32_t)0x4)
```

### define `EF_SPI_STATUS_REG_RX_F_BIT`

```c
#define EF_SPI_STATUS_REG_RX_F_BIT ((uint32_t)3)
```

### define `EF_SPI_STATUS_REG_RX_F_MASK`

```c
#define EF_SPI_STATUS_REG_RX_F_MASK ((uint32_t)0x8)
```

### define `EF_SPI_STATUS_REG_TX_B_BIT`

```c
#define EF_SPI_STATUS_REG_TX_B_BIT ((uint32_t)4)
```

### define `EF_SPI_STATUS_REG_TX_B_MASK`

```c
#define EF_SPI_STATUS_REG_TX_B_MASK ((uint32_t)0x10)
```

### define `EF_SPI_STATUS_REG_TX_E_BIT`

```c
#define EF_SPI_STATUS_REG_TX_E_BIT ((uint32_t)0)
```

### define `EF_SPI_STATUS_REG_TX_E_MASK`

```c
#define EF_SPI_STATUS_REG_TX_E_MASK ((uint32_t)0x1)
```

### define `EF_SPI_STATUS_REG_TX_F_BIT`

```c
#define EF_SPI_STATUS_REG_TX_F_BIT ((uint32_t)1)
```

### define `EF_SPI_STATUS_REG_TX_F_MASK`

```c
#define EF_SPI_STATUS_REG_TX_F_MASK ((uint32_t)0x2)
```

### define `EF_SPI_TXB_FLAG`

```c
#define EF_SPI_TXB_FLAG ((uint32_t)0x10)
```

### define `EF_SPI_TXE_FLAG`

```c
#define EF_SPI_TXE_FLAG ((uint32_t)0x1)
```

### define `EF_SPI_TXF_FLAG`

```c
#define EF_SPI_TXF_FLAG ((uint32_t)0x2)
```

### define `EF_SPI_TX_FIFO_FLUSH_REG_FLUSH_BIT`

```c
#define EF_SPI_TX_FIFO_FLUSH_REG_FLUSH_BIT ((uint32_t)0)
```

### define `EF_SPI_TX_FIFO_FLUSH_REG_FLUSH_MASK`

```c
#define EF_SPI_TX_FIFO_FLUSH_REG_FLUSH_MASK ((uint32_t)0x1)
```

### define `EF_SPI_TX_FIFO_LEVEL_REG_LEVEL_BIT`

```c
#define EF_SPI_TX_FIFO_LEVEL_REG_LEVEL_BIT ((uint32_t)0)
```

### define `EF_SPI_TX_FIFO_LEVEL_REG_LEVEL_MASK`

```c
#define EF_SPI_TX_FIFO_LEVEL_REG_LEVEL_MASK ((uint32_t)0xf)
```

### define `EF_SPI_TX_FIFO_THRESHOLD_REG_THRESHOLD_BIT`

```c
#define EF_SPI_TX_FIFO_THRESHOLD_REG_THRESHOLD_BIT ((uint32_t)0)
```

### define `EF_SPI_TX_FIFO_THRESHOLD_REG_THRESHOLD_MASK`

```c
#define EF_SPI_TX_FIFO_THRESHOLD_REG_THRESHOLD_MASK ((uint32_t)0xf)
```

### define `IO_TYPES`

```c
#define IO_TYPES 
```

### define `__R`

```c
#define __R volatile const uint32_t
```

### define `__RW`

```c
#define __RW volatile       uint32_t
```

### define `__W`

```c
#define __W volatile       uint32_t
```


