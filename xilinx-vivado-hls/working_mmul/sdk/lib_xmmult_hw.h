
#ifndef H_LIB_EXAMPLE_HW_H
#define H_LIB_EXAMPLE_HW_H

#define DIM    32
#define SIZE  ((DIM)*(DIM))

int Setup_HW_Accelerator(float A[DIM][DIM], float B[DIM][DIM], float res_hw[DIM][DIM], int dma_size);

int Run_HW_Accelerator(float A[DIM][DIM], float B[DIM][DIM], float res_hw[DIM][DIM], int dma_size);

int Start_HW_Accelerator(void);

void matrix_multiply_ref(float a[DIM][DIM], float b[DIM][DIM], float out[DIM][DIM]);

#endif
