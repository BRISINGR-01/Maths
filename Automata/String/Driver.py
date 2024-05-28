import sys
from antlr4 import *
from StringLexer import StringLexer
from StringParser import StringParser
from VisitorInterp import VisitorInterp

def main(argv):
    input_stream = FileStream(argv[1])
    lexer = StringLexer(input_stream)
    stream = CommonTokenStream(lexer)
    parser = StringParser(stream)
    tree = parser.start_()

if __name__ == '__main__':
    main(sys.argv)