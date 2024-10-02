#define NUMBER 257
#define PERC 258
#define PLUS 259
#define MINUS 260
#define DIV 261
#define PROD 262
#define RBRA 263
#define LBRA 264
#ifdef YYSTYPE
#undef  YYSTYPE_IS_DECLARED
#define YYSTYPE_IS_DECLARED 1
#endif
#ifndef YYSTYPE_IS_DECLARED
#define YYSTYPE_IS_DECLARED 1
typedef union YYSTYPE{
    int dvalue;
    char *strvalue;
    struct syntax_tree * tree;
} YYSTYPE;
#endif /* !YYSTYPE_IS_DECLARED */
extern YYSTYPE yylval;
