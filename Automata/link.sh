name='Webpage'
rule='htmlDocument'

link=$1


if [ -z "$rule" ]; then
  rule="program"
fi

node ./html.js $link &

./build.sh $name

cd $name
cp $name.g4 out/$name.g4
cd out

if [ -e ../data.txt ]; then
  java org.antlr.v4.gui.TestRig antlr_generated.$name $rule -gui ../data.txt
elif [ -e ../index.html ]; then
  java org.antlr.v4.gui.TestRig antlr_generated.$name $rule -gui ../index.html
else
  java org.antlr.v4.gui.TestRig antlr_generated.$name $rule -gui
fi