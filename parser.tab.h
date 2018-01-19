
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
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


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     PROGRAM = 258,
     FUNCTION = 259,
     END_FUNCTION = 260,
     END_PROCEDURE = 261,
     PROCEDURE = 262,
     CONSTANT = 263,
     MAIN = 264,
     IDENTIFICADOR = 265,
     NUMERO = 266,
     TIPO = 267,
     PRODUCE = 268,
     DECLARE = 269,
     TEXTO = 270,
     END_WHILE = 271,
     WHILE = 272,
     END_IF = 273,
     ELSE_IF = 274,
     THEN = 275,
     ELSE = 276,
     IF = 277,
     OP_AND = 278,
     OP_OR = 279,
     OP_CONCATENACAO = 280,
     OP_MENORIGUALQUE = 281,
     OP_MAIORIGUALQUE = 282,
     OP_MENORQUE = 283,
     OP_MAIORQUE = 284,
     OP_DIFERENTE = 285,
     OP_IGUAL = 286,
     OP_ATRIBUICAO = 287,
     OP_SUBTRACAO = 288,
     OP_SOMA = 289,
     OP_DIVISAO = 290,
     OP_MULTIPLICACAO = 291,
     OP_MODULO = 292
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


