class ReadFile
{
public:
  ReadFile(string fileName);
  ~ReadFile();
  int next(string &word);

private:
  fstream fileStream;
};
