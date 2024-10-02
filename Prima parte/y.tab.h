#define NUM 257
#define UP 258
#define DOWN 259
#define RIGHT 260
#define LEFT 261
#define DEST 262
#ifdef YYSTYPE
#undef  YYSTYPE_IS_DECLARED
#define YYSTYPE_IS_DECLARED 1
#endif
#ifndef YYSTYPE_IS_DECLARED
#define YYSTYPE_IS_DECLARED 1

struct node_t{

		int value;
		int brackets;
		struct node_t * prev;
		struct node_t * right;
		struct node_t * left;
	};

	typedef struct node_t node_t;

typedef union YYSTYPE  {

    node_t * node;
    char* strvalue;
    int dvalue;
} YYSTYPE;
#endif /* !YYSTYPE_IS_DECLARED */
extern YYSTYPE yylval;
