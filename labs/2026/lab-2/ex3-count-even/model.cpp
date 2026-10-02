#include <iostream>
using namespace std;
int main() {
    int values[] = {7, 12, -4, 9, 0, 15, 28};
    int n = 7, count = 0;
    for (int i = 0; i < n; ++i)
        if ((values[i] & 1) == 0) ++count;
    cout << "Even count: " << count << '\n';
}
