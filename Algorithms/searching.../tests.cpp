#include "algorithm.h"
#include "linkedList.h"
#include "bst.h"

void assert(int val)
{
  if (!val)
  {
    cout << "Function returned wrong output: " << (val ? "true" : "false") << endl;
    exit(1);
  }
}

void assertNum(int num1, int num2)
{
  if (num1 != num2)
  {
    cout << num1 << " is not " << num2 << "!" << endl;
    exit(1);
  }
}

void assertWord(DataStructure *dt, string val)
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
  bst->add("fa");
  //     a
  //      d
  //     c fa

  auto testValue = bst->rightChild;
  assertWord(testValue, "a");
  testValue = testValue->rightChild;
  assertWord(testValue, "d");
  assertWord(testValue->rightChild, "fa");
  assertWord(testValue->leftChild, "c");
  assertWord(bst->find("fa"), "fa");
  assertWord(bst->find("c"), "c");
}

void testLinkedList()
{
  auto linkedList = new LinkedList();

  linkedList->add("word");
  linkedList->add("another");

  assertWord(linkedList->child, "word");
  assertWord(linkedList->child->child, "another");
}

void testCount()
{
  auto bst = new BST();

  bst->add("and");
  bst->add("I");
  bst->add("am");
  bst->add("and");
  bst->add("a");
  bst->add("boy");
  bst->add("and");
  bst->add("hi");
  bst->add("and");
  bst->add("-");
  bst->add("and");

  assertNum(count("and", bst), 5);
  auto linkedList = new LinkedList();

  linkedList->add("and");
  linkedList->add("I");
  linkedList->add("am");
  linkedList->add("and");
  linkedList->add("a");
  linkedList->add("boy");
  linkedList->add("and");
  linkedList->add("hi");
  linkedList->add("and");
  linkedList->add("-");
  linkedList->add("and");

  assertNum(count("and", linkedList), 5);
}

void testUtilities()
{
  assert(!isLetter('1'));
  assert(!isLetter('.'));
  assert(!isLetter(' '));
  assert(!isLetter('-'));
  assert(isLetter('a'));
  assert(isLetter('r'));
  assert(isLetter('F'));
  assert(isLetter('Z'));

  assertNum(compare("a", "aa"), -1);
  assertNum(compare("aa", "a"), 1);
  assertNum(compare("a", "ab"), -1);
  assertNum(compare("b", "a"), 1);
  assertNum(compare("fa", "a"), 1);
  assertNum(compare("a", "fa"), -1);
  assertNum(compare("a", "a"), 0);
  assertNum(compare("A", "a"), 0);
  assertNum(compare("", ""), 0);
  assertNum(compare("g", ""), 1);
  assertNum(compare("", "d"), -1);
}

void runTests()
{
  testUtilities();
  testBst();
  testLinkedList();
  testCount();

  cout << "All tests passed" << endl;
}
