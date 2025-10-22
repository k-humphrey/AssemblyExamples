//Kayla Humphrey CSC 3410-002, BackandForth functions between c and asm
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//functions
int addstr(char *a, char *b);
int is_palindromeA(char *s);
int factstr(char *s);
int fact(int n);
extern void palindrome_check();
int is_palindromeC(char *s);

int main(){
    int choice = 0;
    int result = 0;
    char * input1 = malloc(2);
    char * input2 = malloc(2);
    char str[1024];

    do{
        printf("\n\n-------MENU-------");
        printf("\n1) Add two numbers together");
        printf("\n2) Test if string is a palindrome (C-> ASM)");
        printf("\n3) Print the factorial of a number");
        printf("\n4) Test if a string is a palindrome (ASM -> C)");
        printf("\n5) Exit Program");

        printf("\nEnter an integer 1 to 5: ");
        scanf("%d", &choice);
        getchar();
        switch(choice){
            case 1:
                printf("Enter a number: ");
                scanf("%1s", input1);
                printf("Enter a number: ");
                scanf("%1s", input2);
                result = addstr(input1, input2);

                printf("\nThe result is: %d \n", result);
            break;
            case 2:
                printf("Enter a string: ");
                fgets(str, 1024, stdin);
                str[strcspn(str, "\n")] = '\0';
                result = is_palindromeA(str);
                if(result == 1){
                    printf("It is a palindrome.\n");
                }
                else{
                    printf("It is NOT a palindrome.\n");
                }
                
            break;
            case 3:
                printf("Please enter a number: ");
                scanf("%1s", input1);
                result = factstr(input1);

                printf("\nThe result is: %d \n", result);
            break;
            case 4:
                palindrome_check();

            break;
            case 5:
            printf("\nYou have chosen to end the program. Goodbye!");
            break;
            default:
            printf("\ninvalid input");
            break;
        }

    }while(choice != 5);

    //free allocated memory
    free(input1);
    free(input2);

    return 0;
}
//Function: fact
//Parameters: an integer n
//output: an integer that represents n!
int fact(int n){
    if (n < 0) return 0;
    int result = 1;
    for (int i = 2; i <= n; i++){
        result *= i;
    }
    return result;
}

//Function is_palindromeC
//parameters: a char * s that holds a string to be evaluated
//output: 0 if not a palindrome and 1 if palindrome
int is_palindromeC(char *s){
    int i = 0;
    int j = strlen(s) - 1;
    while (i < j){
        if(s[i] != s[j])
        return 0;
        i++;
        j--;
    }
    return 1;
}