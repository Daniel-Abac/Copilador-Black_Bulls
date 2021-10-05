/* Seccion 1*/
package url.compilador;
%%

%class Lexico
%standalone
%line
%column
%char

/*Signos*/

Punto = "."
DosPuntos = ":"
PuntoComa = ";"
Coma = ","
Parentesis1 = "("
Parentesis2 = ")"
Guion = "_"
Comillas = "\""
espacio= " "

/* Aquí van a ir las palabras reservadas */

V= "Verdadero"
F= "Falso"
si= "si"
escribir = "escribir"
leer = "leer"
sino= "sino"
entonces= "entonces"
desde = "desde"
mientras = "mientras"
devolver = "devolver"
enteroR="entero"
realR= "real"
cadenaR= "cadena"
boleanoR= "boleano"
nulo= "nulo"
hacer= "hacer"
cadenaEntero= "cadenaEntero"
cadenaReal= "cadenaReal"
cadenaBoleano= "CadenaBoleano"
seno= "seno"
coseno= "coseno"
tangente= "tangente"
logaritmo= "logaritmo"
raiz= "raiz"
clase= "clase"
extiende= "extiende"
propiedades= "propiedades"
metodos= "metodos"
publicas= "publicas"
privadas= "privadas"
protegidas= "protegidas"
publicos= "publicos"
privados= "privados"
protegidos= "protegidos"
instanciar= "instanciar"
eliminar= "eliminar"
contructor= "constructor"
destructor= "destructor"
incluir= "incluir"
Principal= "Principal"
and="AND"
or="OR"

/*EXPRESIONES DECLARADAS*/

cero= 0
digito = [1-9]+
m = [a-z]+
M = [A-Z]+
numeroEntero= ({digito}({digito}|{cero})+) | {cero}
cadena= {Comillas}({m}|{M}|{espacio}|{Guion})+ {Comillas}
variable= {m}({m}|{M}|{espacio}|{Guion}|{numeroEntero})*
var_Metodo= {M}({m}|{M}|{espacio}|{Guion}|{numeroEntero})*

%%
/* Seccion 3*/
{F} {
    System.out.println("encontre un falso ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    }

{numeroEntero} {
    System.out.println("encontre un numero: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    }
{cadena} {
    System.out.println("encontre una cadena: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    }
{variable} {
    System.out.println("encontre una variable: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    }
{var_Metodo} {
    System.out.println("encontre una var de Metodo: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    }