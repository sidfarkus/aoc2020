// gcc day12.c -o day12 && ./day12
#include <stdio.h>
#include <stdlib.h>

typedef struct { int x; int y; } vec;
static int s[] = {1, -1, 0, 1};
static int c[] = {1, 0, -1, 0};

void rotate(vec * point, int deg) {
    int degIndex = (deg < 0 ? deg + 360 : deg) / 90;
    int oldX = point->x;
    point->x = point->x * c[degIndex] + point->y * s[degIndex];
    point->y = oldX * -s[degIndex] + point->y * c[degIndex];
}

int main(int argc, char ** argv) {
    FILE * f = fopen(argv[1], "r");
    char buffer[20];
    vec shipPos = {0};
    vec wayPos = {10, 1};

    while (fgets(buffer, 20, f)) {
        char op = buffer[0];
        int data;
        sscanf(buffer + 1, "%d", &data);

        switch(op) {
            case 'N': wayPos.y += data; break;
            case 'S': wayPos.y -= data; break;
            case 'E': wayPos.x += data; break;
            case 'W': wayPos.x -= data; break;
            case 'L': rotate(&wayPos, data); break;
            case 'R': rotate(&wayPos, -data); break;
            case 'F':
                shipPos.x += wayPos.x * data;
                shipPos.y += wayPos.y * data;
                break;
        }
    }

    printf("ship = %d, %d # %d\n\n", shipPos.x, shipPos.y, abs(shipPos.x) + abs(shipPos.y));

    fclose(f);
    return 0;
}