#include "blocks/battery.h"
#include "blocks/cputemp.h"
#include "blocks/mail.h"
#include "blocks/time.h"
#include "blocks/volume.h"

#define SLEEPINTERVAL                   1

/* If interval of a block is set to 0, the block will only be updated once at startup.
 * If interval is set to a negative value, the block will never be updated in the main loop.
 * Set pathc to NULL if clickability is not required for the block.
 * Set signal to 0 if both clickability and signaling are not required for the block.
 * Signal must be less than 10 for clickable blocks.
 * If multiple signals are pending, then the lowest numbered one will be delivered first. */

/* funcu - function responsible for updating what is shown on the status
 * funcc - function responsible for handling clicks on the block */

static Block blocks[] = {
  /* funcu                 funcc                   interval        signal */
  /* {  music,                music,                  0,             11       }, */
  /* {  news,                 news,                   0,              6       }, */
  /* {  cputempu,             cputempc,               2,              6       }, */
  /* {  mailu,                mailc,                  300,            2       }, */
  /* {  kdeconnect,           kdeconnect,             15,             0       }, */
  /* {  wifistatus,           wifistatus,             5,              0       }, */
  /* {  ethernet,             ethernet,               5,              0       }, */
  {  volumeu,              volumec,                0,              1       },
  {  batteryu,             batteryc,               5,              4       },
  {  timeu,                NULL,                   1,              10      },
  {  NULL                                                                  },
};

static const char *delim =  " ";
