import java.util.HashMap;
import java.util.Map;

import antlr_generated.ConditionBaseVisitor;
import antlr_generated.ConditionParser;


public class Visitor extends ConditionBaseVisitor<String> {
  private Map<String, Integer> variables = new HashMap<>();

  @Override public String visitAssignment(ConditionParser.AssignmentContext ctx) {
    String identifier = ctx.identifier().getText();
    if (ctx.value() != null) {
      variables.put(identifier, Integer.parseInt((visitValue(ctx.value()))));
    } else {
      variables.put(identifier, Integer.parseInt((visitExpression(ctx.expression()))));
    }

    return null;
  }

  @Override public String visitValue(ConditionParser.ValueContext ctx) {
    
    if (ctx.identifier() != null) {
      return variables.get(ctx.identifier().getText()).toString();
    } else if (ctx.string() != null) {
      String val = ctx.string().getText();
      return val.substring(1, val.length() - 1);
    } else if (ctx.INT() != null) {
      String val = "";
      for (int i = 0; i < ctx.INT().size(); i++) {
        val += ctx.INT(i).toString();
      }
      return val;
    }

    return null;
  }

  @Override public String visitExpression(ConditionParser.ExpressionContext ctx) {
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

  @Override public String visitWriteStatement(ConditionParser.WriteStatementContext ctx) {
    System.out.println(visitValue(ctx.value()));
    return null;
  }

	@Override public String visitCondition(ConditionParser.ConditionContext ctx) { 
    boolean isTrue;
    
    if (ctx.conditionStart().expression() != null) {isTrue = Integer.parseInt(visitExpression(ctx.conditionStart().expression())) != 0;} else {
      isTrue = Integer.parseInt(visitValue(ctx.conditionStart().value())) != 0;
    }

    if (isTrue) {
      visitCodeBlock(ctx.codeBlock().get(0));
    } else if (ctx.conditionElse() != null) {
      visitCodeBlock(ctx.codeBlock().get(1));
    }

    return null;
  }

}
