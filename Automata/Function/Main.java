import java.io.File;

import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;

import antlr_generated.FunctionLexer;
import antlr_generated.FunctionParser;

public class Main {
    public static void main(String[] args) throws Exception {
        CharStream input;
        File f = new File("../data.txt");
        if(f.exists() && !f.isDirectory()) { 
            input = CharStreams.fromFileName(f.getAbsolutePath());
        } else {
            input = CharStreams.fromStream(System.in);
        }

        // Create a lexer that feeds off of input CharStream
        FunctionLexer lexer = new FunctionLexer(input);

        // Create a buffer of tokens pulled from the lexer
        CommonTokenStream tokens = new CommonTokenStream(lexer);

        // Create a parser that feeds off the tokens buffer
        FunctionParser parser = new FunctionParser(tokens);

        // Begin parsing at the program rule
        ParseTree tree = parser.program();

        Visitor visitor = new Visitor();

        visitor.visit(tree);
    }
}