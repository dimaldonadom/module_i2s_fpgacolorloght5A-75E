#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int main() {
    
    double pi = 3.1415926535;

    FILE *wavFile = fopen("A_mono.wav", "rb"); // Abre el archivo WAV en modo lectura binaria
    if (wavFile == NULL) {
        printf("No se pudo abrir el archivo WAV\n");
        return 1;
    }

    FILE *hexFile = fopen("A.hex", "w"); // Abre un archivo para escribir el formato hexadecimal
    if (hexFile == NULL) {
        printf("No se pudo crear el archivo de salida\n");
        return 1;
    }

    unsigned char buffer[1]; // Buffer para leer cada byte del archivo WAV
    unsigned short pasado;
    for(unsigned int i = 1 ; i < 2000001; i++) {
        fread(buffer, sizeof(buffer), 1, wavFile);

        //fprintf(hexFile, "%02X", buffer[0]); // Escribe el byte en formato hexadecimal en el archivo de salida
        //fprintf(hexFile, "%02X", buffer[0]);
        if (i%2==0){
            fprintf(hexFile, "%s", "0x");
            fprintf(hexFile, "%02X", buffer[0]);
            fprintf(hexFile, "%02X", pasado);
            fprintf(hexFile, "%s", ",\n");
            
        } 
        pasado=buffer[0];

    }

    fclose(wavFile);
    fclose(hexFile);

    printf("Archivo WAV convertido a formato hexadecimal con éxito.\n");
    return 0;
}
