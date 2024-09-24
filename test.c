#include <stdio.h>

#define TEST_MACRO

void dummyFunction(int);
void faultyFormatFunction();

void dummyFunction(int dummyVariable) { printf("This is the input: %d\n", dummyVariable); }
void faultyFormatFunction(){
int dummyTask = 10;
}

int main()
{
    // Make the dummy call
    dummyFunction(TEST_MACRO);
    printf("This is a dummy line.");
    printf("Faulty formatting");
    printf("No formatting needed");
    printf("Testing formatting with UI");
}
