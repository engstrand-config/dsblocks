#include <limits.h>
#include <X11/Xlib.h>

#define CMDLENGTH                       75
#define NILL                            INT_MIN

extern Display *dpy;
extern pid_t pid;

typedef struct {
  Display *dpy;
  char *kdedbusobj;
} BlockData;
