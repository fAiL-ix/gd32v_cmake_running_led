// Standard library includes.
#include <stdint.h>
#include <string.h>

// Device header files.
#include "gd32vf103.h"
#include "riscv_encoding.h"

// Pre-defined memory locations for program initialization.
extern uint32_t _sidata, _sdata, _edata, _sbss, _ebss;
// Current system core clock speed.
volatile uint32_t SystemCoreClock = 8000000;

// Simple 'busy loop' delay method.
__attribute__( ( optimize( "O0" ) ) )
void delay_cycles( uint32_t cyc ) {
  uint32_t d_i;
  for ( d_i = 0; d_i < cyc; ++d_i ) { __asm__( "nop" );
  }
}

// 'main' method which gets called from the boot code.
int main( void ) {
  // Copy initialized data from .sidata (Flash) to .data (RAM)
  memcpy( &_sdata, &_sidata, ( ( void* )&_edata - ( void* )&_sdata ) );
  // Clear the .bss RAM section.
  memset( &_sbss, 0x00, ( ( void* )&_ebss - ( void* )&_sbss ) );

  // Enable the GPIOA and GPIOC peripherals.
  RCC->APB2ENR |=  ( RCC_APB2ENR_IOPBEN );

  // Configure pins A1, A2, and C13 as low-speed push-pull outputs.
  GPIOB->CRL   &= ~( GPIO_CRL_MODE0 | GPIO_CRL_CNF0 |
                     GPIO_CRL_MODE1 | GPIO_CRL_CNF1 |
                     GPIO_CRL_MODE5 | GPIO_CRL_CNF5 );
  GPIOB->CRL   |=  ( ( 0x2 << GPIO_CRL_MODE0_Pos ) |
                     ( 0x2 << GPIO_CRL_MODE1_Pos ) |
                     ( 0x2 << GPIO_CRL_MODE5_Pos ) );

  // Turn all three LEDs off.
  // The pins are connected to the LED cathodes, so pulling
  // the pin high turns the LED off, and low turns it on.
  GPIOB->ODR   |=  ( 0x1 << 0 |
                     0x1 << 1 |
                     0x1 << 5 );

  // Cycle the RGB LED through a pattern of colors.
  #define DELAY_CYCLES ( 50000 )
  while( 1 ) {
    // Green on (Green)
    GPIOB->ODR &= ~( 0x1 << 0 );
    delay_cycles( DELAY_CYCLES );
    // Red on (Yellow)
    GPIOB->ODR &= ~( 0x1 << 1 );
    delay_cycles( DELAY_CYCLES );
    // Blue on (White)
    GPIOB->ODR &= ~( 0x1 << 5 );
    delay_cycles( DELAY_CYCLES );
    // Green off (Purple)
    GPIOB->ODR |=  ( 0x1 << 0 );
    delay_cycles( DELAY_CYCLES );
    // Red off (Blue)
    GPIOB->ODR |=  ( 0x1 << 1 );
    delay_cycles( DELAY_CYCLES );
    // Blue off (Off)
    GPIOB->ODR |=  ( 0x1 << 5 );
    delay_cycles( DELAY_CYCLES );
  }
  return 0;
}
