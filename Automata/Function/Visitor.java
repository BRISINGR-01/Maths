import antlr_generated.FunctionBaseVisitor;
import antlr_generated.FunctionParser;
import java.util.HashMap;
import java.util.Map;


public class Visitor extends FunctionBaseVisitor<String> {
  private Map<String, Integer> variables = new HashMap<>();

  @Override public String visitAssignment(FunctionParser.AssignmentContext ctx) {
    String identifier = ctx.identifier().getText();
    if (ctx.value() != null) {
      variables.put(identifier, Integer.parseInt((visitValue(ctx.value()))));
    } else {
      variables.put(identifier, Integer.parseInt((visitExpression(ctx.expression()))));
    }

    return null;
  }

  @Override public String visitValue(FunctionParser.ValueContext ctx) {
    
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

  @Override public String visitExpression(FunctionParser.ExpressionContext ctx) {
    if (ctx.OPERATOR() == null) {
      return visitValue(ctx.value().get(0));
    }

    int res = 0;

    for (int i = 0; i < ctx.OPERATOR().size(); i++) {
      int val = Integer.parseInt(visitValue(ctx.value().get(i + 1)));
      switch (ctx.OPERATOR().get(i).getText()) {
        case "+":
          res += val;
          break;
        case "-":
          res -= val;
          break;
        case "*":
          res *= val;
          break;
        case "/":
          res /= val;
          break;
        case "^":
          res = (int) (Math.pow(res, val));
          break;
      }
    }

    return String.valueOf(res);
  }

  @Override public String visitWriteStatement(FunctionParser.WriteStatementContext ctx) {
    System.out.println(visitValue(ctx.value()));
    return null;
  }

	// @Override public String visitConditionStatement(FunctionParser.ConditionStatementContext ctx) { 
  //   boolean isTrue = Integer.parseInt(visitCondition(ctx.condition())) != 0;
    

  //   if (isTrue) {
  //     visitCodeBlock(ctx.codeBlock().get(0));
  //   } else if (ctx.codeBlock().get(1) != null) {
  //     visitCodeBlock(ctx.codeBlock().get(1));
  //   }

  //   return null;
  // }

  // @Override public String visitCondition(FunctionParser.ConditionContext ctx) {


  //   if (ctx.conditionStart().expression() != null) {isTrue = Integer.parseInt(visitExpression(ctx.conditionStart().expression())) != 0;} else {
  //     isTrue = Integer.parseInt(visitValue(ctx.conditionStart().value())) != 0;
  //   }
  //   return  null;
  // }

}
