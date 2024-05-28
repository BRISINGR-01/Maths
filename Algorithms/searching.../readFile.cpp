#include "algorithm.h"
#include "readFile.h"
#include <filesystem>

ReadFile::ReadFile(string fileName)
{
  if (!filesystem::exists(fileName))
  {
    cout << "No such file" << endl;
    exit(1);
  }

  fileStream.open(fileName, ios::in);
}

ReadFile::~ReadFile()
{
  if (fileStream.is_open())
    fileStream.close();
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