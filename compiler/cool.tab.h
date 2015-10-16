/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_COOL_TAB_H_INCLUDED
# define YY_YY_COOL_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    ID = 258,
    EXM = 259,
    THIS = 260,
    SUPER = 261,
    OVERRIDE = 262,
    NULLVAL = 263,
    NATIVE = 264,
    EXTENDS = 265,
    IF = 266,
    ELSE = 267,
    WHILE = 268,
    MATCH = 269,
    CASE = 270,
    STRING = 271,
    INTEGER = 272,
    BOOL = 273,
    CLASS = 274,
    TYPE = 275,
    SEMICOLON = 276,
    COLON = 277,
    EQEQ = 278,
    LTEQ = 279,
    LT = 280,
    NEQ = 281,
    EQ = 282,
    NEW = 283,
    DEF = 284,
    PAR_OPEN = 285,
    PAR_CLOSE = 286,
    BRACE_OPEN = 287,
    BRACE_CLOSE = 288,
    BRACK_OPEN = 289,
    BRACK_CLOSE = 290,
    VAR = 291,
    DOT = 292,
    COMMA = 293,
    ARROW = 294,
    ADD = 295,
    SUB = 296,
    MULT = 297,
    DIV = 298,
    UMIN = 299
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_COOL_TAB_H_INCLUDED  */
