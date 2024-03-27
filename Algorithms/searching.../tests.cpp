#include "algorithm.h"
#include "bst.h"

void assert(DataStructure *dt, string val)
{
  if (dt->value != val)
  {
    cout << dt->value + " is not " + val + "!" << endl;
    exit(1);
  }
}

void testBst()
{
  auto bst = new BST();

  bst->add("a");
  bst->add("d");
  bst->add("c");
  bst->add("f");

  auto testValue = bst->rightChild;
  assert(testValue, "a");
  testValue = testValue->rightChild;
  assert(testValue, "d");
  assert(testValue->rightChild, "f");
  assert(testValue->leftChild, "c");
}

void run_tests()
{
  testBst();
}
