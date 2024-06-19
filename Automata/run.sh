name=$1

cd $name

javac *.java -d out

cd out

java Main