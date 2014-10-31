#include <curses.h>
#include <time.h>
#include <cstdlib>

const int WIDTH = 80;
const int HEIGHT = 25;

int x = 5;
int y = 5;

float noise[WIDTH][HEIGHT];

void GenerateNoise() {

    srand(time(0));

    for (int i = 0; i < WIDTH; ++i) {
        for (int j = 0; j < HEIGHT; ++j) {
            noise[i][j] = rand()/float(RAND_MAX);
        }
    }
}

float Smooth(float x, float y) {
    float fractX = x - (int)x;
    float fractY = y - (int)y;

    int x1 = ((int)x + WIDTH) % WIDTH;
    int y1 = ((int)y + HEIGHT) % HEIGHT;

    int x2 = ((int)x + WIDTH - 1) % WIDTH;
    int y2 = ((int)y + HEIGHT - 1) % HEIGHT;

    float value = 0.0;
	value += fractX * fractY * noise[x1][y1];
	value += fractX * (1-fractY) * noise[x1][y2];
	value += (1-fractX) * fractY * noise[x2][y1];
	value += (1-fractX) * (1-fractY) * noise[x2][y2];

	return value;
}

float Turbulence(float x, float y, int size) {
    float value = 0.0;
    int initial_size = size;

    while (size >= 1) {
        value = value + Smooth(x / size, y / size) * size;
        size = size / 2.0;
    }

    return (value*128) / initial_size;
}

int main() {
    initscr();
    curs_set(0);
    noecho();
    cbreak();

    GenerateNoise();

    start_color();
    init_pair(1, COLOR_WHITE, COLOR_BLUE);
    init_pair(2, COLOR_WHITE, COLOR_CYAN);
    init_pair(3, COLOR_WHITE, COLOR_GREEN);
    init_pair(4, COLOR_WHITE, COLOR_YELLOW);
    init_pair(5, COLOR_WHITE, COLOR_WHITE);

    int color = 1;

    float sea = .45;

    for (int i = 0; i < HEIGHT; ++i) {
        for (int j = 0; j < WIDTH; ++j) {
            float level = Turbulence(i, j, 32)/255.0;
            if (level < sea && level > sea/1.1) {
                color = 2;
            } else if (level < sea/1.05) {
                color = 1;
            } else if (level > .7) {
                color = 5;
            } else if (level > .60) {
                color = 4;
            } else {
                color = 3;
            }

            attron(COLOR_PAIR(color));
            mvaddch(i, j, ' ');
            attroff(COLOR_PAIR(color));
        }
    }

    mvaddch(0, 0, ACS_ULCORNER);
    mvaddch(0, WIDTH-1, ACS_URCORNER);
    mvaddch(HEIGHT-1, 0, ACS_LLCORNER);
    mvaddch(HEIGHT-1, WIDTH-1, ACS_LRCORNER);

    /*for (int i = 1; i < WIDTH-1; ++i) mvaddch(0, i, ACS_HLINE);
    for (int i = 1; i < WIDTH-1; ++i) mvaddch(HEIGHT-1, i, ACS_HLINE);
    for (int i = 1; i < HEIGHT-1; ++i) mvaddch(i, 0, ACS_VLINE);
    for (int i = 1; i < HEIGHT-1; ++i) mvaddch(i, WIDTH-1, ACS_VLINE);
*/
    box( stdscr, ACS_VLINE, ACS_HLINE );

    mvaddch(x, y, '@');


    getch();
    endwin();

    return 0;
}
