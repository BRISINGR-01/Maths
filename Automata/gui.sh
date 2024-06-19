name=$1
rule="program" #$2

./build.sh $name

cd $name
cp $name.g4 out/$name.g4
cd out

if [ -e ../data.txt ]; then
  java org.antlr.v4.gui.TestRig antlr_generated.$name $rule -gui ../data.txt
else
  java org.antlr.v4.gui.TestRig antlr_generated.$name $rule -gui
fi