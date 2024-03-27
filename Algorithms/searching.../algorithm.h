#include "iostream"
#include "fstream"
using namespace std;

int compare(string val1, string val2);
int isLetter(char ch);
void run_tests();

class DataStructure
{
public:
  string value;
  virtual DataStructure *find(string val) = 0;
};
