#include "duc.h"

int37 mult (
  int18	c,
  int19	d
  ) {
    int37 m = ((int37) c) * ((int37) d);
    return m;
}  

srrc_acc_t srrc_mac (
  int18	c,
  int18	d,
  int40	s
  ) {
    int36 m = ((int36) c) * ((int36) d);
    int40 sum = m + s;
    return sum;
}  

imf1_acc_t mac1 (
  imf1_coef_t c,
  imf1_data_t d,
  imf1_acc_t s
  ) {
    int36 m = ((int36) c) * ((int36) d);
    imf1_acc_t sum = m + s;
    return sum;
}  

imf2_acc_t mac2 (
  imf2_coef_t c,
  imf2_data_t d,
  imf2_acc_t s
  ) {
    int36 m = ((int36) c) * ((int36) d);
    imf2_acc_t sum = m + s;
    return sum;
}  

int48 mac (
  int18	c,
  int18	d,
  int48	s
  ) {
    int36 m = ((int36) c) * ((int36) d);
    return (m+s);
}  

int37 symtap (
  int18 a,
  int18 b,
  int18 c
  ) {
  int19 s = a + b;
  int37 m = mult(c,s);
  return m;
}

