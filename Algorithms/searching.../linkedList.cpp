#include "algorithm.h"
#include "linkedList.h"
#include "readFile.h"

LinkedList::LinkedList()
{
  value = "";
}

LinkedList::LinkedList(string val)
{
  value = val;
}

void LinkedList::add(string val)
{
  if (child == nullptr)
  {
    child = new LinkedList(val);
    return;
  }

  child->add(val);
}

LinkedList *LinkedList::find(string val)
{
  if (child == nullptr)
    return nullptr;

  if (child->value.compare(val) == 0)
    return child;

  return child->find(val);
}

void LinkedList::fill(string fileName)
{
  ReadFile *stream = new ReadFile(fileName);

  string val = " ";
  int count = 0;
  add("");
  LinkedList *tail = this->child;
  while (stream->next(val))
  {
    count += 1;
    if (count == 200000)
    {
      cout << "Too many" << endl;
      break;
    }
    tail->add(val);
    tail = tail->child;
  }

  cout << count << endl;
}

LinkedList::~LinkedList()
{
  delete child;
}
