import antlr_generated.ExpressionsLexer;
import antlr_generated.ExpressionsParser;
import java.io.File;

public class Main {
    public static void main(String[] args) throws Exception {
        CharStream input;
        File f = new File("../data.txt");
        if(f.exists() && !f.isDirectory()) { 
            input = CharStreams.fromFileName(f.getAbsolutePath());
        } else {
            File f2 = new File("./Expressions/data.txt");
            if(f2.exists() && !f2.isDirectory()) { 
                input = CharStreams.fromFileName(f2.getAbsolutePath());
            } else {
                input = CharStreams.fromStream(System.in);
            }
        }

        // Create a lexer that feeds off of input CharStream
        ExpressionsLexer lexer = new ExpressionsLexer(input);

        // Create a buffer of tokens pulled from the lexer
        CommonTokenStream tokens = new CommonTokenStream(lexer);

        // Create a parser that feeds off the tokens buffer
        ExpressionsParser parser = new ExpressionsParser(tokens);

        // Begin parsing at the program rule
        ParseTree tree = parser.program();

        Visitor visitor = new Visitor();

        visitor.visit(tree);
    }
}