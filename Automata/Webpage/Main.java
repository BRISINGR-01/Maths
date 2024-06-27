import java.io.File;

import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;

import antlr_generated.WebpageLexer;
import antlr_generated.WebpageParser;

public class Main {
    public static void main(String[] args) throws Exception {
        CharStream input;
        File f = new File("../index.html");
        if(f.exists() && !f.isDirectory()) { 
            input = CharStreams.fromFileName(f.getAbsolutePath());
        } else {
            File f2 = new File("./Webpage/index.html");
            if(f2.exists() && !f2.isDirectory()) { 
                input = CharStreams.fromFileName(f2.getAbsolutePath());
            } else {
                input = CharStreams.fromStream(System.in);
            }
        }
        
        // Create a lexer that feeds off of input CharStream
        WebpageLexer lexer = new WebpageLexer(input);

        // Create a buffer of tokens pulled from the lexer
        CommonTokenStream tokens = new CommonTokenStream(lexer);

        // Create a parser that feeds off the tokens buffer
        WebpageParser parser = new WebpageParser(tokens);

        // Begin parsing at the program rule
        ParseTree tree = parser.program();

        Visitor visitor = new Visitor();

        visitor.visit(tree);
    }
}