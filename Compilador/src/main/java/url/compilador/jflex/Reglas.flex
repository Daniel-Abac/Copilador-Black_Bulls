/* Seccion 1*/
package url.compilador;
import url.compilador.jflex.Guardado;
%%

%class Lexico
%standalone
%line
%column
%char

/*Signos*/
cadena = {Comillas}.*{Comillas}
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

m = [a-z]
M = [A-Z]

real= 0 {Punto} {parteDerecha} | [1-9][0-9]*{Punto} {parteDerecha}
parteDerecha= [0-9]*[1-9]
NumeroMalo= 0 {Punto} {derechaMala} | [1-9][0-9]*{Punto} {derechaMala} | {izquierdaMala}{Punto} {parteDerecha} | {izquierdaMala}| {izquierdaMala}{Punto} {derechaMala} 
derechaMala= [0-9]* 0
izquierdaMala =  0 [0-9]+
numeroEntero= 0 | [1-9][0-9]*
ID= {m}({M}|{m}|{Guion}|{numeroEntero})*   
ID_Metodo= {M}({m}|{M}|{Guion}|{numeroEntero})*

/*Comentarios*/
cmI="/*"
cmD="*/"
cmDD="//"
SaltoDeLinea = \n|\r|\r\n
/*comentario de una linea*/
ComenA={cmDD}.*
ComenB= {cmI}.*{cmD} |{cmI}.*{SaltoDeLinea}.*{cmD}

%%
/* Seccion 3*/
{cadena} { 
    System.out.println("encontre una cadena: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    Guardado g = new Guardado();
    g.LexLuthor("Cadena",yytext());
}
{ComenA} { 
    System.out.println("encontre un comentario A: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    Guardado g = new Guardado();
    g.LexLuthor("Comentario tipo A",yytext());
}
{ComenB} { 
    System.out.println("encontre un comentario B: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    Guardado g = new Guardado();
    g.LexLuthor("Comentario tipo B",yytext());
}
/*Palabras Reservadas*/

{V} {
    System.out.println("encontre un verdadero ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    Guardado g = new Guardado();
    g.LexLuthor("Verdadero",yytext());
 }
{F} {
    System.out.println("encontre un falso ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    Guardado g = new Guardado();
    g.LexLuthor("Falso",yytext());
}
{incluir} {
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    Guardado g = new Guardado();
    g.LexLuthor("Incluir",yytext());
}
{clase} { 
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    Guardado g = new Guardado();
    g.LexLuthor("Clase",yytext());
}
{extiende} { 
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    Guardado g = new Guardado();
    g.LexLuthor("Extiende",yytext());
}
{enteroR} { 
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    Guardado g = new Guardado();
    g.LexLuthor("Entero",yytext());
}
{realR} {
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    Guardado g = new Guardado();
    g.LexLuthor("Real",yytext());
}
{cadenaR} { 
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    Guardado g = new Guardado();
    g.LexLuthor("Cadena",yytext());
}
{boleanoR} {
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    Guardado g = new Guardado();
    g.LexLuthor("Booleano",yytext());
}
{nulo} {
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    Guardado g = new Guardado();
    g.LexLuthor("Nulo",yytext());
}
{propiedades} {
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    Guardado g = new Guardado();
    g.LexLuthor("Propiedades",yytext());
}
{metodos} {
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    Guardado g = new Guardado();
    g.LexLuthor("Metodos",yytext());
}
{publicas} {
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    Guardado g = new Guardado();
    g.LexLuthor("Publicas",yytext());
}
{privadas} {
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    Guardado g = new Guardado();
    g.LexLuthor("Privadas",yytext());
}
{protegidas} {
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    Guardado g = new Guardado();
    g.LexLuthor("Protegidas",yytext());
}
{publicos} {
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    Guardado g = new Guardado();
    g.LexLuthor("Publicos",yytext());
}
{privados} {
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    Guardado g = new Guardado();
    g.LexLuthor("Privados",yytext());
}
{protegidos} {
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    Guardado g = new Guardado();
    g.LexLuthor("Protegidos",yytext());
}
/*Signos*/
{DosPuntos} {
    System.out.println("encontre un signo: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    Guardado g = new Guardado();
    g.LexLuthor("Dos Puntos",yytext());
}
{PuntoComa} {
    System.out.println("encontre un signo: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    Guardado g = new Guardado();
    g.LexLuthor("Punto Coma",yytext());
}
{Coma} {
    System.out.println("encontre un signo: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    Guardado g = new Guardado();
    g.LexLuthor("Coma",yytext());
}
{Parentesis1} {
    System.out.println("encontre un signo: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    Guardado g = new Guardado();
    g.LexLuthor("Parentesis Izquierdo",yytext());
}
{Parentesis2} {
    System.out.println("encontre un signo: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    Guardado g = new Guardado();
    g.LexLuthor("Parentesis Derecho",yytext());
}
{Comillas} {
    System.out.println("encontre un signo: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    Guardado g = new Guardado();
    g.LexLuthor("Comillas",yytext());
}
{espacio} {
    System.out.println("encontre un espacio en blanco: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    Guardado g = new Guardado();
    g.LexLuthor("Espacio",yytext());
}
/* Expresiones delcaradas  */
{real} {
    System.out.println("encontre una real: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    Guardado g = new Guardado();
    g.LexLuthor("Numero Real",yytext());
    }
{NumeroMalo} {
    System.out.println("encontre una Numero Malo: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    Guardado g = new Guardado();
    g.LexLuthorErr("Numero malo",yytext());
    }
{numeroEntero} {
    System.out.println("encontre un numero: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    Guardado g = new Guardado();
    g.LexLuthor("Numero Entero",yytext());
    }
{ID} {
    System.out.println("encontre una variable: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    Guardado g = new Guardado();
    g.LexLuthor("Varibale",yytext());
    }
{ID_Metodo} {
    System.out.println("encontre una var de Metodo: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    Guardado g = new Guardado();
    g.LexLuthor("Varibale de Metodo",yytext());
    }



.    {System.out.println("error: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    Guardado g = new Guardado();
    g.LexLuthorErr("Error",yytext());
}