#include <stdio.h>
#include <stdlib.h> 
#include <string.h>
#include <time.h>

// вариант 24

char *get(char *a, char *b, FILE* file) {
    char c;
    int step = 0;
    int size = 1;
    if (!file) {
        while ((c = getchar()) != '\n') {
            a[step] = c;
            step++;
            if (step == size) {
                size *= 2;
                a = realloc(a, size);
            }
        }
        step = 0;
        size = 1;
        while ((c = getchar()) != EOF) {
            b[step] = c;
            step++;
            if (step == size) {
                size *= 2;
                b = realloc(b, size);
            }
        }
    } else {
        while ((c = fgetc(file)) != '\n') {
            a[step] = c;
            step++;
            if (step == size) {
                size *= 2;
                a = realloc(a, size);
            }
        }
        step = 0;
        size = 1;
        while ((c = fgetc(file)) != EOF) {
            if (step == size) {
                size *= 2;
                b = realloc(b, size);
            }
            b[step] = c;
            step++;
        }
        fclose(file);
    }
    return b;
}

void form(char *str, char *instr, int file) {
    int start = clock();
    char *istr = strstr (str, instr);
    if (!file) {
        while (istr != NULL) {
            printf("%ld ", istr - str + 1);
            istr = strstr (istr + 1, instr);
        }
    } else {
        for (int i = 0; i < 100000; i++) {
            FILE *output;
            output = fopen("output.txt", "w");
            while (istr != NULL) {
                fprintf(output,"%ld ", istr - str + 1);
                istr = strstr (istr + 1, instr);
            }
            fclose(output);
        }
    }
    int end = clock();
    printf("%lf", (double)(end - start) / CLOCKS_PER_SEC);
}

char *generate(char *str, char *instr) {
    srand(time(NULL));
    int instrn = 1 + rand() % 5;
    int strn = 10000 + rand() % 10000;
    
    instr = realloc(instr, instrn);
    str = realloc(str, strn);

    for (int i = 0; i < instrn; i++) {
        instr[i] = rand() % 127 + '0';
    }
    for (int i = 0; i < strn; i++) {
        str[i] = rand() % 127 + '0';
    }
    printf("%s\n%s\n", instr, str);
    return str;
}

int main(int argc, char *argv[]) {
    char *str = malloc(1);
    char *instr = malloc(1);
    int file = 0;

    if (argc != 1) {
        if (!strcmp(argv[1], "File")) {
            FILE *File;
            File = fopen("File.txt", "r");
            if (File == NULL) {
                perror("Error opening file");
                return(-1);
            }
            str = get(instr, str, File);
            file = 1;
        } else if (!strcmp(argv[1], "gen")) {
            str = generate(str, instr);
        }
    } else {
        get(instr, str, 0);
    }

    form(str, instr, file);
    
    free(str);
    free(instr);
    
    return 0;
} 
