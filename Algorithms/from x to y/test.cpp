#include <chrono>
#include "iostream"
#include <stdlib.h>
using namespace std;

#include "algorithm"

struct Data
{
  long int X;
  int Y;
  int m;
};
int algorithm(Data *data);

void assert(int val, int works, Data *data)
{
  if (val != works)
  {
    cout << "Test failed with X: " << data->X << ", Y: " << data->Y << ", m: " << data->m << endl;
    exit(1);
  }
}

void check(int X, int Y, int m, int works)
{
  Data data;
  data.X = X;
  data.Y = Y;
  data.m = m;

  assert(algorithm(&data), works, &data);
}

int main()
{
  auto start = chrono::steady_clock::now();

  check(30, 500, 5, 1);
  check(-10, 50, -10, 1);
  check(0, 8, 10000, -1);
  check(12, 55, -9, 1);
  check(12, 5, -9, 1);
  check(243, -552, 43, 1);
  check(143, -502, -63, 1);
  check(-10, -5, 2, -1);
  check(-67, -12, -7, -1);
  check(-5, -15, 2, 1);
  check(-12, -75, -7, 1);

  cout << "Tests successful!" << endl;
  auto end = chrono::steady_clock::now();
  chrono::duration<double> elapsed_secondsL = end - start;
  cout << "average time: " << elapsed_secondsL.count() / 11 << endl;
  return 0;
}