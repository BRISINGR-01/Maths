class LinkedList : public DataStructure
{
public:
  LinkedList *child = nullptr;
  LinkedList();
  LinkedList(string val);
  ~LinkedList();

  virtual void add(string val);
  virtual LinkedList *find(string val);
  virtual void fill(string fileName);
};
