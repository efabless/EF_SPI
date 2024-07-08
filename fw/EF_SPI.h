#ifndef EF_SPI_H
#define EF_SPI_H

#include <EF_SPI_regs.h>
#include <stdint.h>
#include <stdbool.h>
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

#endif