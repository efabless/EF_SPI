#ifndef EF_SPI_H
#define EF_SPI_H

#include <EF_SPI_regs.h>
#include <stdint.h>
#include <stdbool.h>

void EF_SPI_writeData(uint32_t spi_base, int data);
int EF_SPI_readData(uint32_t spi_base);
void EF_SPI_writepolarity(uint32_t spi_base, bool polarity);
void EF_SPI_writePhase(uint32_t spi_base, bool phase);
int EF_SPI_readDTRUE(uint32_t spi_base);
int EF_SPI_readBusyTRUE(uint32_t spi_base);
void EF_SPI_waitForDone(uint32_t spi_base);
void EF_SPI_waitForNotDone(uint32_t spi_base);
void EF_SPI_waitForBusy(uint32_t spi_base);
void EF_SPI_assertStart(uint32_t spi_base);
void SPI_deassertStart(uint32_t spi_base);
void SPI_assertCs(uint32_t spi_base);
void SPI_deassertCs(uint32_t spi_base);
void SPI_setInterruptMask(uint32_t spi_base, int mask);

#endif