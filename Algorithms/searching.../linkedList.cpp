#include "algorithm.h"
#include "linkedList.h"

LinkedList::LinkedList()
{
  value = "";
}

LinkedList::LinkedList(string val)
{
  value = val;
}

LinkedList *LinkedList::add(string val)
{
  if (child == nullptr)
    return child = new LinkedList(val);

  return child->add(val);
}

LinkedList *LinkedList::find(string val)
{
  if (child == nullptr)
    return nullptr;

  if (child->value.compare(val) == 0)
    return child;

  return child->find(val);
}

LinkedList::~LinkedList()
{
  cout << "remove: " << value << endl;
}
