import java.util.HashMap;
import java.util.Map;

import antlr_generated.ExpressionsBaseVisitor;
import antlr_generated.ExpressionsParser;

import org.antlr.v4.runtime.*;


public class Visitor extends ExpressionsBaseVisitor<String> {
  private Map<String, Integer> variables = new HashMap<>();

  @Override public String visitAssignment(ExpressionsParser.AssignmentContext ctx) {
    String identifier = ctx.identifier().getText();
    if (ctx.value() != null) {
      variables.put(identifier, Integer.parseInt((visitValue(ctx.value()))));
    } else {
      variables.put(identifier, Integer.parseInt((visitExpression(ctx.expression()))));
    }

    return null;
  }

  @Override public String visitValue(ExpressionsParser.ValueContext ctx) {
    if (ctx.identifier() != null) {
      return variables.get(ctx.identifier().getText()).toString();
    } else if (ctx.INT() != null) {
      String val = "";
      for (int i = 0; i < ctx.INT().size(); i++) {
          val += ctx.INT(i).getText();
      }
      return val;
    }

    return null;
  }



  @Override public String visitExpression(ExpressionsParser.ExpressionContext ctx) {
    int val1 = Integer.parseInt(visitValue(ctx.value(0)));
    int val2 = Integer.parseInt(visitValue(ctx.value(1)));

    switch (ctx.OPERATOR().getText()) {
      case "+":
        val1 += val2;
        break;
      case "-":
        val1 -= val2;
        break;
      case "*":
        val1 *= val2;
        break;
      case "/":
        val1 /= val2;
        break;
      case "^":
        val1 = (int) (Math.pow(val1, val2));
        break;
    }

    return String.valueOf(val1);
  }


  @Override public String visitWriteStatement(ExpressionsParser.WriteStatementContext ctx) {
    System.out.println(variables.get(ctx.identifier().getText()));
    return null;
  }
}
