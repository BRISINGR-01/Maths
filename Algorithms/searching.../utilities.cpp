#include <chrono>
#include "algorithm.h"

int isLetter(char ch)
{
  if (ch >= 'a' && ch <= 'z')
    return true;
  if (ch >= 'A' && ch <= 'Z')
    return true;

  return false;
}

// returns:
//  1: if val1 > val2
//  0: if val1 == val2
// -1: if val1 < val2 or val1 is shorter
int compare(string val1, string val2)
{
  int val2Length = val2.length();
  int val1Length = val1.length();

  for (int i = 0; i < val1Length; i++)
  {
    if (i == val2Length)
      return 1;

    if (val1[i] == val2[i])
      continue;

    int diff = val1[i] - val2[i];
    if (diff == 32 || diff == -32)
      return 0;

    return diff > 0 ? 1 : -1;
  }

  if (val2Length > val1Length)
    return -1;

  return 0;
}

int count(string word, DataStructure *dt)
{
  int count = 0;

  while (1)
  {
    dt = dt->find(word);

    if (dt == nullptr)
      break;

    count++;
  }

  return count;
}

void displayMetrics(DataStructure *dt, string word)
{
  auto start = chrono::steady_clock::now();
  count(word, dt);
  auto end = chrono::steady_clock::now();
  chrono::duration<double> elapsed_secondsL = end - start;
  cout << "time: " << elapsed_secondsL.count() << endl;
}