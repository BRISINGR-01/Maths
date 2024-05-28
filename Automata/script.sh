name=$1
rule=$2

cd $name
java -jar /home/alex/Documents/antlr-4.13.1-complete.jar $name.g4 -o build
cd build
# javac $name*.java
# java org.antlr.v4.gui.TestRig $name $rule -gui