%{
#include <stdio.h>
#include "part3_helpers.hpp"
#include "part3.tab.hpp"
void printLexErrorAndExit();
%}

%option yylineno noyywrap
%option outfile="flex_part3.cpp" header-file="flex_part3.h"


letter        [a-zA-Z]
digit         [0-9]
comment       #(.*)
whitespace    [\t\n\r ]
id            {letter}({letter}|{digit}|_)*
integernum    {digit}+
realnum       {digit}+(\.{digit}+)
str           \"(\\n|\\t|\\\"|[^"\r\n\\])*\"
sign          \(|\)|\{|\}|:|;|,
ellipsis      \.\.\.
relop         ==|<>|<|<=|>|>=
addop         \+|\-
mulop         \*|\/
assign        =
and           &&
or            \|\|
not           !

%%

{whitespace}    { /*do nothing*/                                                          }
{comment}       { /*do nothing*/                                                          }
int             { return token_int;        }
float           { return token_float;      }
void            { return token_void;       }
write           { return token_write;      }
read            { return token_read;       }
va_arg          { return token_va_arg;     }
while           { return token_while;      }
do              { return token_do;         }
if              { return token_if;         }
then            { return token_then;       }
else            { return token_else;       }
return          { return token_return;     }
{id}            { yylval.name = yytext; return token_id;         }
{integernum}    { yylval.name = yytext; return token_integernum; }
{realnum}       { yylval.name = yytext; return token_realnum;    }
{str}           { yytext[yyleng-1] = '\0';
                  yytext += 1;
                  yylval.name = yytext;
                  return token_str;        }
{sign}          { return yytext[0];        }
{ellipsis}      { return token_ellipsis;   }
{relop}         { yylval.name = yytext; return token_relop; }
{addop}         { yylval.name = yytext; return token_addop;      }
{mulop}         { yylval.name = yytext; return token_mulop;      }
{assign}        { return token_assign;     }
{and}           { return token_and;        }
{or}            { return token_or;         }
{not}           { return token_not;        }
.               { printLexErrorAndExit();                                                 }

%%

/* Functions Implementation */
void printLexErrorAndExit()
{
    cerr << "Lexical error: " <<  yytext << " in line number " << yylineno << endl;
    exit(LEXICAL_ERROR);
}

