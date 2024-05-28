class BST : public DataStructure
{
private:
  bool hasLeftChild();
  bool hasRightChild();

public:
  BST *leftChild = nullptr;
  BST *rightChild = nullptr;

  BST();
  BST(string value);
  virtual ~BST();

  virtual void add(string val);
  virtual BST *find(string val);
  virtual void fill(string fileName);
  void remove(string val);
  void display(int indent = 0);
};