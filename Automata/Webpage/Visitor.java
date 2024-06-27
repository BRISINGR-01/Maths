import java.util.HashMap;
import java.util.Map;

import antlr_generated.WebpageBaseVisitor;
import antlr_generated.WebpageParser;

import org.antlr.v4.runtime.*;


public class Visitor extends WebpageBaseVisitor<String> {
	@Override public String visitElement(WebpageParser.ElementContext ctx) { 
    System.out.println(ctx.startTag().OPEN_TAG().getText());

    if (ctx.content() != null) {
      for (var content : ctx.content()) {
        visitContent(content);
      }
    }
  
    return null;
  }
}
