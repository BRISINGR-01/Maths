#include "algorithm.h"
#include "bst.h"
#include "linkedList.h"
#include "readFile.h"
#include <bits/stdc++.h>

DataStructure *getDataStructure(string type)
{
  if (type.compare("binary") == 0)
  {
    return new BST();
  }
  else if (type.compare("linear") == 0)
  {
    return new LinkedList();
  }
  else
  {
    cout << "Wrong 'type' - possible types are 'binary' or 'linear'" << endl;
    exit(1);
  }
}

int main(int argc, char *argv[])
{
  if (strcmp(argv[1], "test") == 0)
  {
    runTests();
  }
  else if (strcmp(argv[1], "-h") == 0)
  {
    cout << "Usage:" << endl;
    cout << "searcher -h: display this" << endl;
    cout << "searcher test: run tests" << endl;
    cout << "searcher <type> <file> <word>: run the algorithm against a file (type can be 'binary' or 'linear')" << endl;
  }
  else
  {
    DataStructure *dt = getDataStructure(argv[1]);
    string file = argv[2];
    string word = argv[3];

    dt->fill(file);

    displayMetrics(dt, word);
  }

  return 0;
}
