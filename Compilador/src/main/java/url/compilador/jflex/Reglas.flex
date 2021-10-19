/* Seccion 1*/
package url.compilador;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.util.logging.Level;
import java.util.logging.Logger;
%%

%class Lexico
%standalone
%line
%column
%char
%init{
        /* Se inicializa el txt de LEXEMAS.txt, se sobreescribe el archivo para dejarlo vacio*/
       try {
            RandomAccessFile traductor= new RandomAccessFile("LEXEMAS.txt","rw");
            traductor.setLength(0);
        } catch (FileNotFoundException ex) {
            Logger.getLogger(Lexico.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(Lexico.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        /* Se inicializa el txt de ERRORES.txt, se sobreescribe el archivo para dejarlo vacio*/
        try {
            RandomAccessFile errores= new RandomAccessFile("ERRORES.txt","rw");
            errores.setLength(0);
        } catch (FileNotFoundException ex) {
            Logger.getLogger(Lexico.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(Lexico.class.getName()).log(Level.SEVERE, null, ex);
        }

%init}
%{

    /* Funcion para pasar los errores al archivo ERRORES.txt*/
    void LexLuthorErr(String Token, String Valor)
    {
        try {
            char enter=13;
            String regreso=Token+"  "+Valor;
            RandomAccessFile errores= new RandomAccessFile("ERRORES.txt","rw");
            errores.seek(errores.length());
            errores.writeBytes(regreso);
            errores.writeChar(enter);
            errores.close();
        } catch (FileNotFoundException ex) {
            Logger.getLogger(Lexico.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(Lexico.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /* Funcion para pasar los tokens al archivo LEXEMAS.txt*/
    void LexLuthor(String Token, String Valor)
    {
        try {
            char enter=13;
            String regreso=Token+"  "+Valor;
            RandomAccessFile traductor= new RandomAccessFile("LEXEMAS.txt","rw");
            traductor.seek(traductor.length());
            traductor.writeBytes(regreso);
            traductor.writeChar(enter);
            traductor.close();
        } catch (FileNotFoundException ex) {
            Logger.getLogger(Lexico.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(Lexico.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
%}
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
tabulador = "\t"

/* Aquí van a ir las palabras reservadas */

v= "verdadero"
f= "falso"
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
cadenaAEntero= "cadenaAEntero"
cadenaAReal= "cadenaAReal"
cadenaABoleano= "cadenaABoleano"
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

/*OPERADORES*/
igual = "="
operadorA = "*"|"/"|"^"|"%"
mas = "+"
menos = "-"
menor = "<"
mayor = ">"
noIgual = "!="

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
    LexLuthor("CADENA ----- ",yytext());
}
{ComenA} { 
    System.out.println("encontre un comentario A: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("COMENTARIOA ----- ",yytext());
}
{ComenB} { 
    System.out.println("encontre un comentario B: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("COMENTARIOB ----- ",yytext());
}
/*Palabras Reservadas*/

{v} {
    System.out.println("encontre un verdadero ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("VERDADERO ----- ",yytext());
 }
{f} {
    System.out.println("encontre un falso ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("FALSO ----- ",yytext());
}
{si} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("SI ----- ",yytext());
}
{escribir} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("ESCRIBIR ----- ",yytext());
}
{leer} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("LEER ----- ",yytext());
}
{sino} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("SINO ----- ",yytext());
}
{entonces} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("ENTONCES ----- ",yytext());
}
{desde} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("DESDE ----- ",yytext());
}
{mientras} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("MIENTRAS ----- ",yytext());
}
{devolver} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("DEVOLVER ----- ",yytext());
}
{hacer} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("HACER ----- ",yytext());
}
{instanciar} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("INSTANCIAR ----- ",yytext());
}
{eliminar} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("ELIMINAR ----- ",yytext());
}
{contructor} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("CONSTRUCTOR ----- ",yytext());
}
{destructor} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("DESTRUCTOR ----- ",yytext());
}
{and} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("AND ----- ",yytext());
}
{or} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("OR ----- ",yytext());
}
{Principal} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("PRINCIPAL ----- ",yytext());
}
{incluir} {
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("INCLUIR ----- ",yytext());
}
{clase} { 
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("CLASE ----- ",yytext());
}
{extiende} { 
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("EXTIENDE ----- ",yytext());
}
{enteroR} { 
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("ENTERO ----- ",yytext());
}
{realR} {
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("REAL ----- ",yytext());
}
{cadenaR} { 
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("CADENA ----- ",yytext());
}
{boleanoR} {
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("BOOLEANO ----- ",yytext());
}
{nulo} {
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("NULO ----- ",yytext());
}
{propiedades} {
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("PROPIEDADES ----- ",yytext());
}
{metodos} {
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("METODOS ----- ",yytext());
}
{publicas} {
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("PUBLICAS ----- ",yytext());
}
{privadas} {
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("PRIVADAS ----- ",yytext());
}
{protegidas} {
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("PROTEGIDAS ----- ",yytext());
}
{publicos} {
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("PUBLICOS ----- ",yytext());
}
{privados} {
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("PRIVADOS ----- ",yytext());
}
{protegidos} {
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("PROTEGIDOS ----- ",yytext());
}
/* Funciones especiales */
/* Funciones Matematicas */
{seno} {
    System.out.println("encontre una función especial (matemática): ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("SENO ----- ",yytext());
}
{coseno} {
    System.out.println("encontre una función especial (matemática): ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("COSENO ----- ",yytext());
}
{tangente} {
    System.out.println("encontre una función especial (matemática): ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("TANGENTE ----- ",yytext());
}
{logaritmo} {
    System.out.println("encontre una función especial (matemática): ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("LOGARITMO ----- ",yytext());
}
{raiz} {
    System.out.println("encontre una función especial (matemática): ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("RAIZ ----- ",yytext());
}
/* Funciones de conversión de tipos */
{cadenaAEntero} {
    System.out.println("encontre una función especial (conversion): ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("CADENAAENTERO ----- ",yytext());
}
{cadenaAReal} {
    System.out.println("encontre una función especial (conversion): ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("CADENAAREAL ----- ",yytext());
}
{cadenaABoleano} {
    System.out.println("encontre una función especial (conversion): ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("CADENAABOOLEANO ----- ",yytext());
}
/*Signos*/
{DosPuntos} {
    System.out.println("encontre un signo: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("DOSPUNTOS ----- ",yytext());
}
{PuntoComa} {
    System.out.println("encontre un signo: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("PUNTOCOMA ----- ",yytext());
}
{Coma} {
    System.out.println("encontre un signo: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("COMA ----- ",yytext());
}
{Parentesis1} {
    System.out.println("encontre un signo: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("PARENTESIS1 ----- ",yytext());
}
{Parentesis2} {
    System.out.println("encontre un signo: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("PARENTESIS2 ----- ",yytext());
}
{Comillas} {
    System.out.println("encontre un signo: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("COMILLAS ----- ",yytext());
}
{espacio} {
    System.out.println("encontre un espacio en blanco: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("ESPACIO ----- ",yytext());
}
{tabulador} {
    System.out.println("encontre un tabulador: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("TABULADOR ----- ",yytext());
}
/*OPERADORES*/
{igual} {
    System.out.println("encontre un operador: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("IGUAL ----- ",yytext());
}
{operadorA} {
    System.out.println("encontre un operador: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("OPERADORA ----- ",yytext());
}
{mas} {
    System.out.println("encontre un operador: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("MAS ----- ",yytext());
}
{menos} {
    System.out.println("encontre un operador: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("MENOS ----- ",yytext());
}
{menor} {
    System.out.println("encontre un operador: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("MENOR ----- ",yytext());
}
{mayor} {
    System.out.println("encontre un operador: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("MAYOR ----- ",yytext());
}
{noIgual} {
    System.out.println("encontre un operador: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("NOIGUAL ----- ",yytext());
}

/* Expresiones delcaradas  */
{real} {
    System.out.println("encontre una real: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("REAL ----- ",yytext());
}
{NumeroMalo} {
    System.out.println("encontre una Numero Malo: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthorErr("NUMEROMALO ----- ",yytext());
    }
{numeroEntero} {
    System.out.println("encontre un numero: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("NUMEROENTERO ----- ",yytext());
    }
{ID} {
    System.out.println("encontre una variable: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("ID ----- ",yytext());
    }
{ID_Metodo} {
    System.out.println("encontre una var de Metodo: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("ID_METODO ----- ",yytext());
    }

.    {System.out.println("error: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthorErr("ERROR ---- ",yytext());
}
