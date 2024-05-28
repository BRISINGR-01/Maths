#include "iostream"
#include <stdlib.h>
using namespace std;

struct Data
{
  long long int X;
  int Y;
  int m;
};

int min(long long int a, long long int b)
{
  if (a <= b)
  {
    return a;
  }
  else
  {
    return b;
  }
}

void decrement(Data *data)
{
  long long int xMin1 = data->X - 1;

  if (data->Y == xMin1 || data->Y == min(xMin1 * data->m, data->Y * 2))
  {
    data->X = xMin1;
    cout << "X = X - 1";
  }
  else
  {
    data->X = xMin1 - 1;
    cout << "X = X - 2";
  }

  cout << ": X = " << data->X << ", Y = " << data->Y << endl;
}

void swap(Data *data)
{
  data->X = min(data->X * data->m, data->Y * 2);
  cout << "X = min(X*m, Y*2)";
  cout << ": X = " << data->X << ", Y = " << data->Y << endl;
}

long long int closestToY(Data *data)
{
  long long int X = abs(data->X - data->Y);
  long long int Xm = abs(data->X * data->m - data->Y);
  int Y2 = abs(data->Y); // Y*2 - Y = Y

  long long int smallestDistance = min(X, min(Xm, Y2));

  if (smallestDistance == X)
  {
    return data->X;
  }
  else if (smallestDistance == Xm)
  {
    return data->X * data->m;
  }
  else
  {
    return data->Y * 2;
  }
}

int check(Data *data)
{
  if (data->X == data->Y)
    return 1;

  if (data->X > data->Y)
    return 0; // always a solution

  long long int minV = min(data->X * data->m, data->Y * 2);
  if (minV < data->Y && data->Y < 0)
  {
    cout << "Unsolvable" << endl;
    return -1;
  }

  if (data->X * data->m == 0 && data->Y > 0)
  {
    cout << "Unsolvable" << endl;
    return -1;
  }

  return 0;
}

int algorithm(Data *data)
{
  int val = check(data);
  if (val != 0)
    return val;

  long long int closest = closestToY(data);
  long long int minV = min(data->X * data->m, data->Y * 2);
  if (data->X > data->Y)
  {
    if (closest == data->X || minV < data->Y)
    {
      decrement(data);
      return algorithm(data);
    }
  }

  swap(data);
  return algorithm(data);
}
