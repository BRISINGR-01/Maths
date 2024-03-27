class BST : public DataStructure
{

public:
  BST();
  BST(string value);

  BST *leftChild;
  BST *rightChild;
  void add(string val);
  BST *find(string val);

  void remove(string val);

  void display(int indent = 0);

private:
  bool hasLeftChild();
  bool hasRightChild();
};