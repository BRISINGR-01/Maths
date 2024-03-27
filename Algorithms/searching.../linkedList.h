class LinkedList : public DataStructure
{
public:
  LinkedList *child;
  LinkedList();
  LinkedList(string val);
  ~LinkedList();

  LinkedList *add(string val);
  LinkedList *find(string val);
};
