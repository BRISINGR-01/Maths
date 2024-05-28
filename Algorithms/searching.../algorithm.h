#include "iostream"
#include "fstream"
using namespace std;

class DataStructure
{
public:
  string value;
  virtual void add(string val) = 0;
  virtual DataStructure *find(string val) = 0;
  virtual void fill(string fileName) = 0;
};

int compare(string val1, string val2);
int isLetter(char ch);
int count(string word, DataStructure *dt);
void displayMetrics(DataStructure *dt, string word);

void runTests();
