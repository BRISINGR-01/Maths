#include "algorithm.h"
#include "bst.h"
#include "linkedList.h"
#include "readFile.h"

int count(string word, DataStructure *list);

int main(int argc, char *argv[])
{
  string word = "";
  if (argc == 1)
  {
    word = "iure";
  }
  else
  {
    word = argv[1];
  }

  cout << word << endl;

  BST *bst = new BST();
  LinkedList *linkedList = new LinkedList();

  // ReadFile *stream = new ReadFile("text.txt");

  // string val = " ";
  // while (stream->next(val))
  // {
  //   bst->add(val);
  //   linkedList->add(val);
  // }

  run_tests();
  // cout << count(word, linkedList) << endl;

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
