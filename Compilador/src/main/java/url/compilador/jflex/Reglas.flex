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
       try {
            RandomAccessFile traductor= new RandomAccessFile("LEXEMAS.txt","rw");
            traductor.setLength(0);
        } catch (FileNotFoundException ex) {
            Logger.getLogger(Lexico.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(Lexico.class.getName()).log(Level.SEVERE, null, ex);
        }

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
    LexLuthor("Cadena ----- ",yytext());
}
{ComenA} { 
    System.out.println("encontre un comentario A: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Comentario tipo A ----- ",yytext());
}
{ComenB} { 
    System.out.println("encontre un comentario B: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Comentario tipo B ----- ",yytext());
}
/*Palabras Reservadas*/

{v} {
    System.out.println("encontre un verdadero ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Palabra Reservada ---- Verdadero ----- ",yytext());
 }
{f} {
    System.out.println("encontre un falso ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Palabra Reservada ---- Falso ----- ",yytext());
}
{si} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Palabra Reservada ---- Si ----- ",yytext());
}
{escribir} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Palabra Reservada ---- Escribir ----- ",yytext());
}
{leer} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Palabra Reservada ---- Leer ----- ",yytext());
}
{sino} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Palabra Reservada ---- Sino ----- ",yytext());
}
{entonces} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Palabra Reservada ---- Entonces ----- ",yytext());
}
{desde} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Palabra Reservada ---- Desde ----- ",yytext());
}
{mientras} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Palabra Reservada ---- Mientras ----- ",yytext());
}
{devolver} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Palabra Reservada ---- Devolver ----- ",yytext());
}
{hacer} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Palabra Reservada ---- Hacer ----- ",yytext());
}
{instanciar} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Palabra Reservada ---- Instanciar ----- ",yytext());
}
{eliminar} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Palabra Reservada ---- Eliminar ----- ",yytext());
}
{contructor} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Palabra Reservada ---- Contructor ----- ",yytext());
}
{destructor} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Palabra Reservada ---- Destructor ----- ",yytext());
}
{and} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Palabra Reservada ---- AND ----- ",yytext());
}
{or} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Palabra Reservada ---- OR ----- ",yytext());
}
{Principal} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Palabra Reservada ---- Principal ----- ",yytext());
}
{incluir} {
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Palabra Reservada ---- Incluir ----- ",yytext());
}
{clase} { 
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Palabra Reservada ---- Clase ----- ",yytext());
}
{extiende} { 
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Palabra Reservada ---- Extiende ----- ",yytext());
}
{enteroR} { 
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Palabra Reservada ---- Entero ----- ",yytext());
}
{realR} {
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Palabra Reservada ---- Real ----- ",yytext());
}
{cadenaR} { 
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Palabra Reservada ---- Cadena ----- ",yytext());
}
{boleanoR} {
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Palabra Reservada ---- Booleano ----- ",yytext());
}
{nulo} {
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Palabra Reservada ---- Nulo ----- ",yytext());
}
{propiedades} {
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Palabra Reservada ---- Propiedades ----- ",yytext());
}
{metodos} {
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Palabra Reservada ---- Metodos ----- ",yytext());
}
{publicas} {
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Palabra Reservada ---- Publicas ----- ",yytext());
}
{privadas} {
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Palabra Reservada ---- Privadas ----- ",yytext());
}
{protegidas} {
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Palabra Reservada ---- Protegidas ----- ",yytext());
}
{publicos} {
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Palabra Reservada ---- Publicos ----- ",yytext());
}
{privados} {
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Palabra Reservada ---- Privados ----- ",yytext());
}
{protegidos} {
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Protegidos ----- ",yytext());
}
/* Funciones especiales */
/* Funciones Matematicas */
{seno} {
    System.out.println("encontre una función especial (matemática): ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Funcion especial ----- ",yytext());
}
{coseno} {
    System.out.println("encontre una función especial (matemática): ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Funcion especial ----- ",yytext());
}
{tangente} {
    System.out.println("encontre una función especial (matemática): ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Funcion especial ----- ",yytext());
}
{logaritmo} {
    System.out.println("encontre una función especial (matemática): ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Funcion especial ----- ",yytext());
}
{raiz} {
    System.out.println("encontre una función especial (matemática): ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Funcion especial ----- ",yytext());
}
/* Funciones de conversión de tipos */
{cadenaAEntero} {
    System.out.println("encontre una función especial (conversion): ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Funcion especial ----- ",yytext());
}
{cadenaAReal} {
    System.out.println("encontre una función especial (conversion): ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Funcion especial ----- ",yytext());
}
{cadenaABoleano} {
    System.out.println("encontre una función especial (conversion): ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Funcion especial ----- ",yytext());
}
/*Signos*/
{DosPuntos} {
    System.out.println("encontre un signo: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Signo ---- Dos Puntos ----- ",yytext());
}
{PuntoComa} {
    System.out.println("encontre un signo: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Signo ---- Punto Coma ----- ",yytext());
}
{Coma} {
    System.out.println("encontre un signo: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Signo ---- Coma ----- ",yytext());
}
{Parentesis1} {
    System.out.println("encontre un signo: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Signo ---- Parentesis Izquierdo ----- ",yytext());
}
{Parentesis2} {
    System.out.println("encontre un signo: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Signo ---- Parentesis Derecho ----- ",yytext());
}
{Comillas} {
    System.out.println("encontre un signo: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Signo ---- Comillas ----- ",yytext());
}
{espacio} {
    System.out.println("encontre un espacio en blanco: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Signo ---- Espacio ----- ",yytext());
}
{tabulador} {
    System.out.println("encontre un tabulador: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
}
/*OPERADORES*/
{igual} {
    System.out.println("encontre un operador: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Operador ---- Igual ----- ",yytext());
}
{operadorA} {
    System.out.println("encontre un operador: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Operador ---- OPERADOR ----- ",yytext());
}
{mas} {
    System.out.println("encontre un operador: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Operador ---- Mas ----- ",yytext());
}
{menos} {
    System.out.println("encontre un operador: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Operador ---- Menos ----- ",yytext());
}
{menor} {
    System.out.println("encontre un operador: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Operador ---- Menor ----- ",yytext());
}
{mayor} {
    System.out.println("encontre un operador: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Operador ---- Mayor ----- ",yytext());
}
{noIgual} {
    System.out.println("encontre un operador: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Operador ---- NO Igual ----- ",yytext());
}

/* Expresiones delcaradas  */
{real} {
    System.out.println("encontre una real: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Numero Real ----- ",yytext());
}
{NumeroMalo} {
    System.out.println("encontre una Numero Malo: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthorErr("Numero malo ----- ",yytext());
    }
{numeroEntero} {
    System.out.println("encontre un numero: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Numero Entero ----- ",yytext());
    }
{ID} {
    System.out.println("encontre una variable: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Varibale ----- ",yytext());
    }
{ID_Metodo} {
    System.out.println("encontre una var de Metodo: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("Varibale de Metodo ----- ",yytext());
    }

.    {System.out.println("error: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthorErr("Error ---- ",yytext());
}
