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
// -1: if val1 > val2
//  0: if val1 == val2
//  1: if val1 < val2
int compare(string val1, string val2)
{
  int val2Length = val2.length();
  int val1Length = val1.length();

  for (int i = 0; i < val1Length; i++)
  {
    if (i == val2Length)
    {
      return 1;
    }

    if (val1[i] == val2[i])
      continue;

    return val1[i] - val2[i];
  }

  return 0;
}