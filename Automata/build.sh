name=$1

cd $name
java -jar ../lib/antlr-4.13.1-complete.jar -Dlanguage=Java -visitor -package antlr_generated $name.g4 -o antlr_generated

javac -d out antlr_generated/$name*.java
