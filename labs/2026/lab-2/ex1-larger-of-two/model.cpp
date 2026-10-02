#include <iostream>
using namespace std;
int main() {
    int first = 17, second = 29;
    int larger = first;
    if (second > first) larger = second;
    cout << "Larger: " << larger << '\n';
}
