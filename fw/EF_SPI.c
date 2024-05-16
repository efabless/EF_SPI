#ifndef EF_SPI_C
#define EF_SPI_C

#include <EF_SPI.h>


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

int EF_SPI_readDTRUE(uint32_t spi_base){
    EF_SPI_TYPE* spi = (EF_SPI_TYPE*)spi_base;

    return spi->STATUS & 1;
}

int EF_SPI_readBusyTRUE(uint32_t spi_base){

    EF_SPI_TYPE* spi = (EF_SPI_TYPE*)spi_base;

    return (spi->STATUS & 0x2) >> 1;
}

void EF_SPI_waitForDone(uint32_t spi_base){
    EF_SPI_TYPE* spi = (EF_SPI_TYPE*)spi_base;

    while(EF_SPI_readDTRUE(spi_base) == 0);
}
void EF_SPI_waitForNotDone(uint32_t spi_base){
    EF_SPI_TYPE* spi = (EF_SPI_TYPE*)spi_base;
    while(EF_SPI_readDTRUE(spi_base) == 1);
}
void EF_SPI_waitForBusy(uint32_t spi_base){
    EF_SPI_TYPE* spi = (EF_SPI_TYPE*)spi_base;
    while(EF_SPI_readBusyTRUE(spi_base) == 1);
}
void EF_SPI_assertStart(uint32_t spi_base){
    EF_SPI_TYPE* spi = (EF_SPI_TYPE*)spi_base;
    int control = spi->CTRL;
    control |= 1;
    spi->CTRL = control;
    // control &= ~1;
    // spi->CTRL = control;
}

void SPI_deassertStart(uint32_t spi_base){
    EF_SPI_TYPE* spi = (EF_SPI_TYPE*)spi_base;
    int control = spi->CTRL;
    control &= ~1;
    spi->CTRL = control;
}
void SPI_assertCs(uint32_t spi_base){
    EF_SPI_TYPE* spi = (EF_SPI_TYPE*)spi_base;
    int control = spi->CTRL;
    control |= 2;
    spi->CTRL = control;
}

void SPI_deassertCs(uint32_t spi_base){
    EF_SPI_TYPE* spi = (EF_SPI_TYPE*)spi_base;
    int control = spi->CTRL;
    control &= ~2;
    spi->CTRL = control;
}

void SPI_setInterruptMask(uint32_t spi_base, int mask){
    EF_SPI_TYPE* spi = (EF_SPI_TYPE*)spi_base;
    // bit 0: Done
    spi->IC = mask;
}

#endif