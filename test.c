#include <stdio.h>

#define TEST_MACRO

void dummyFunction (int);

void dummyFunction (int dummyVariable){
    printf("This is the input: %d\n", dummyVariable);
}

int main (){
    // Make the dummy call
    dummyFunction(TEST_MACRO);
    printf("This is a dummy line.");
}