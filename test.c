#include <string.h>

__attribute__((visibility("default")))
void
test_get_str(char *buf, int len)
{
    static char test[] = "GRUMPY STEFAN";
    strncpy(buf,test,len);
}
