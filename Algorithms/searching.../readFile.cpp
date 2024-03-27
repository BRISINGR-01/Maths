#include "algorithm.h"
#include "readFile.h"

ReadFile::ReadFile(string fileName)
{
  fileStream.open(fileName, ios::in);

  if (!fileStream)
  {
    throw "No such file";
  }
}

ReadFile::~ReadFile()
{
  cout << "die fstraem" << endl;
}

int ReadFile::next(string &output)
{
  char ch;
  output.clear();
  while (1)
  {
    fileStream.get(ch);

    if (fileStream.eof())
    {
      fileStream.close();
      return 0;
    }

    if (!isLetter(ch))
    {
      if (output.length() == 0)
      {
        output.clear();
        continue;
      }

      break;
    }

    output = output + ch;
  };

  return 1;
}