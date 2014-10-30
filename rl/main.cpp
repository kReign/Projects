#include <curses.h>

int main() {
    initscr();
    printw("hello world");
    int ch = getch();
    endwin();

    return 0;
}
