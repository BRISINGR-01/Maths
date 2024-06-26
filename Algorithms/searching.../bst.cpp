#include "algorithm.h"
#include "readFile.h"
#include "bst.h"

BST::BST()
{
  value = "";
}
BST::BST(string val)
{
  value = val;
}

void BST::add(string val)
{
  if (compare(this->value, val) > 0)
  {
    if (!hasLeftChild())
    {
      this->leftChild = new BST(val);
      return;
    }

    return leftChild->add(val);
  }
  else
  {
    if (!hasRightChild())
    {
      this->rightChild = new BST(val);
      return;
    }

    return rightChild->add(val);
  }
  cout << 10 << endl;
}

BST *BST::find(string val)
{
  if (compare(this->value, val) > 0)
  {
    if (!hasLeftChild())
      return nullptr;

    if (compare(this->leftChild->value, val) == 0)
      return this->leftChild;

    return this->leftChild->find(val);
  }
  else
  {
    if (!hasRightChild())
      return nullptr;

    if (compare(this->rightChild->value, val) == 0)
      return this->rightChild;

    return this->rightChild->find(val);
  }

  return this;
}

void BST::remove(string val)
{
  int comparission = compare(this->value, val);
  if (comparission > 0)
  {
    if (hasLeftChild())
    {
      leftChild->remove(val);
      if (leftChild->value == val)
      {
        delete leftChild;
        leftChild = nullptr;
      }
    }
    return;
  }

  if (comparission < 0)
  {
    if (hasRightChild())
    {
      rightChild->remove(val);
      if (rightChild->value == val)
      {
        delete rightChild;
        rightChild = nullptr;
      }
    }
    return;
  }

  if (!hasLeftChild() && !hasRightChild())
  {
    return;
  }

  if (!hasRightChild() && hasLeftChild())
  {
    val = leftChild->value;
    delete leftChild;
    leftChild = nullptr;
    return;
  }

  if (hasRightChild() && !hasLeftChild())
  {
    val = rightChild->value;
    delete rightChild;
    rightChild = nullptr;
    return;
  }

  BST *child = rightChild;

  while (child->leftChild != nullptr)
  {
    child = child->leftChild;
  }

  string value = child->value;
  remove(child->value);
  this->value = value;
}

void BST::fill(string fileName)
{
  ReadFile *stream = new ReadFile(fileName);

  string word = " ";
  while (stream->next(word))
  {
    add(word);
  }
}

void BST::display(int indent)
{
  string indentStr = "";
  for (int i = 0; i < indent; i++)
  {
    if (i == indent - 1)
      indentStr += " |";

    indentStr += " ";
  }

  if (indent == 0)
  {
    cout << indentStr << "<ROOT>" << endl;
  }
  else
  {
    cout << indentStr << value << endl;
  }
  if (hasLeftChild())
  {
    cout << indentStr << "Left:" << endl;
    leftChild->display(indent + 1);
  }

  if (hasRightChild())
  {
    cout << indentStr << "Right:" << endl;
    rightChild->display(indent + 1);
  }
}

bool BST::hasLeftChild()
{
  return leftChild != nullptr;
}

bool BST::hasRightChild()
{
  return rightChild != nullptr;
}

BST::~BST()
{
  delete rightChild;
  delete leftChild;
}