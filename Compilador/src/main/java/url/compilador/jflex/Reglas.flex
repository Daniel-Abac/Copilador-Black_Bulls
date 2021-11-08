/* Seccion 1*/
package url.compilador;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.util.logging.Level;
import java.util.logging.Logger;
import java_cup.runtime.Symbol;
%%

%class Lexico
%standalone
%line
%column
%char
%cup
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
Llave1 = "{"
Llave2 = "}"
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
nuevo="nuevo"
/*OPERADORES*/
igual = "="
operadorA = "*"|"/"|"^"|"%"
mas = "+"
menos = "-"
menor = "<"
mayor = ">"
noIgual = "!="
mayorIgual= ">="
menorIgual= "<="
incremento="++"
decremento="--"
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
{decremento} { 
    System.out.println("encontre un decremento: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("DECREMENTO ----- ",yytext());
    return new Symbol (sym.DECREMENTO);
}
{incremento} { 
    System.out.println("encontre un incremento: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("INCREMENTO ----- ",yytext());
    return new Symbol (sym.INCREMENTO);
}
{cadena} { 
    System.out.println("encontre una cadena: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("CADENA ----- ",yytext());
    return new Symbol (sym.CADENA);
}
{ComenA} { 
    System.out.println("encontre un comentario A: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("COMENTARIOA ----- ",yytext());
    return new Symbol (sym.COMENTARIOA);
}
{ComenB} { 
    System.out.println("encontre un comentario B: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("COMENTARIOB ----- ",yytext());
    return new Symbol (sym.COMENTARIOB);
}
/*Palabras Reservadas*/

{v} {
    System.out.println("encontre un verdadero ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("VERDADERO ----- ",yytext());
    return new Symbol (sym.VERDADERO);
 }
{f} {
    System.out.println("encontre un falso ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("FALSO ----- ",yytext());
    return new Symbol (sym.FALSO);
}
{si} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("SI ----- ",yytext());
    return new Symbol (sym.SI);
}
{escribir} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("ESCRIBIR ----- ",yytext());
    return new Symbol (sym.ESCRIBIR);
}
{leer} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("LEER ----- ",yytext());
    return new Symbol (sym.LEER);
}
{sino} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("SINO ----- ",yytext());
    return new Symbol (sym.SINO);
}
{entonces} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("ENTONCES ----- ",yytext());
    return new Symbol (sym.ENTONCES);
}
{desde} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("DESDE ----- ",yytext());
    return new Symbol (sym.DESDE);
}
{mientras} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("MIENTRAS ----- ",yytext());
    return new Symbol (sym.MIENTRAS);
}
{devolver} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("DEVOLVER ----- ",yytext());
    return new Symbol (sym.DEVOLVER);
}
{hacer} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("HACER ----- ",yytext());
    return new Symbol (sym.HACER);
}
{instanciar} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("INSTANCIAR ----- ",yytext());
    return new Symbol (sym.INSTANCIAR);
}
{eliminar} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("ELIMINAR ----- ",yytext());
    return new Symbol (sym.ELIMINAR);
}
{contructor} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("CONSTRUCTOR ----- ",yytext());
    return new Symbol (sym.CONSTRUCTOR);
}
{destructor} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("DESTRUCTOR ----- ",yytext());
    return new Symbol (sym.DESTRUCTOR);
}
{and} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("AND ----- ",yytext());
    return new Symbol (sym.AND);
}
{or} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("OR ----- ",yytext());
    return new Symbol (sym.OR);
}
{Principal} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("PRINCIPAL ----- ",yytext());
    return new Symbol (sym.PRINCIPAL);
}
{incluir} {
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("INCLUIR ----- ",yytext());
    return new Symbol (sym.INCLUIR);
}
{clase} { 
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("CLASE ----- ",yytext());
    return new Symbol (sym.CLASE);
}
{extiende} { 
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("EXTIENDE ----- ",yytext());
    return new Symbol (sym.EXTIENDE);
}
{nuevo} {
    System.out.println("encontre una palabra reservada ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("NUEVO ----- ",yytext());
    return new Symbol (sym.NUEVO);
}
{enteroR} { 
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("ENTERO ----- ",yytext());
    return new Symbol (sym.ENTEROR);
}
{realR} {
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("REAL ----- ",yytext());
    return new Symbol (sym.REALR);
}
{cadenaR} { 
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("CADENA ----- ",yytext());
    return new Symbol (sym.CADENAR);
}
{boleanoR} {
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("BOOLEANO ----- ",yytext());
    return new Symbol (sym.BOOLEANOR);
}
{nulo} {
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("NULO ----- ",yytext());
    return new Symbol (sym.NULO);
}
{propiedades} {
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("PROPIEDADES ----- ",yytext());
    return new Symbol (sym.PROPIEDADES);
}
{metodos} {
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("METODOS ----- ",yytext());
    return new Symbol (sym.METODOS);
}
{publicas} {
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("PUBLICAS ----- ",yytext());
    return new Symbol (sym.PUBLICAS);
}
{privadas} {
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("PRIVADAS ----- ",yytext());
    return new Symbol (sym.PRIVADAS);
}
{protegidas} {
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("PROTEGIDAS ----- ",yytext());
    return new Symbol (sym.PROTEGIDAS);
}
{publicos} {
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("PUBLICOS ----- ",yytext());
    return new Symbol (sym.PUBLICOS);
}
{privados} {
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("PRIVADOS ----- ",yytext());
    return new Symbol (sym.PRIVADOS);
}
{protegidos} {
    System.out.println("encontre una palabra reservada: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("PROTEGIDOS ----- ",yytext());
    return new Symbol (sym.PROTEGIDOS);
}
/* Funciones especiales */
/* Funciones Matematicas */
{seno} {
    System.out.println("encontre una función especial (matemática): ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("SENO ----- ",yytext());
    return new Symbol (sym.SENO);
}
{coseno} {
    System.out.println("encontre una función especial (matemática): ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("COSENO ----- ",yytext());
    return new Symbol (sym.COSENO);
}
{tangente} {
    System.out.println("encontre una función especial (matemática): ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("TANGENTE ----- ",yytext());
    return new Symbol (sym.TANGENTE);
}
{logaritmo} {
    System.out.println("encontre una función especial (matemática): ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("LOGARITMO ----- ",yytext());
    return new Symbol (sym.LOGARITMO);
}
{raiz} {
    System.out.println("encontre una función especial (matemática): ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("RAIZ ----- ",yytext());
    return new Symbol (sym.RAIZ);
}
/* Funciones de conversión de tipos */
{cadenaAEntero} {
    System.out.println("encontre una función especial (conversion): ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("CADENAAENTERO ----- ",yytext());
    return new Symbol (sym.CADENAAENTERO);
}
{cadenaAReal} {
    System.out.println("encontre una función especial (conversion): ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("CADENAAREAL ----- ",yytext());
    return new Symbol (sym.CADENAAREAL);
}
{cadenaABoleano} {
    System.out.println("encontre una función especial (conversion): ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("CADENAABOOLEANO ----- ",yytext());
    return new Symbol (sym.CADENAABOOLEANO);
}
/*Signos*/
{DosPuntos} {
    System.out.println("encontre un signo: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("DOSPUNTOS ----- ",yytext());
    return new Symbol (sym.DOSPUNTOS);
}
{PuntoComa} {
    System.out.println("encontre un signo: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("PUNTOCOMA ----- ",yytext());
    return new Symbol (sym.PUNTOCOMA);
}
{Coma} {
    System.out.println("encontre un signo: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("COMA ----- ",yytext());
    return new Symbol (sym.COMA);
}
{Parentesis1} {
    System.out.println("encontre un signo: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("PARENTESIS1 ----- ",yytext());
    return new Symbol (sym.PARENTESIS1);
}
{Parentesis2} {
    System.out.println("encontre un signo: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("PARENTESIS2 ----- ",yytext());
    return new Symbol (sym.PARENTESIS2);
}
{Llave1} {
    System.out.println("encontre un signo: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("LLAVE1 ----- ",yytext());
    return new Symbol (sym.LLAVE1);
}
{Llave2} {
    System.out.println("encontre un signo: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("LLAVE2 ----- ",yytext());
    return new Symbol (sym.LLAVE2);
}
{Comillas} {
    System.out.println("encontre un signo: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("COMILLAS ----- ",yytext());
    return new Symbol (sym.COMILLAS);
}
{espacio} {
    System.out.println("encontre un espacio en blanco: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
}
{tabulador} {
    System.out.println("encontre un tabulador: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    return new Symbol (sym.TABULADOR);
}
/*OPERADORES*/
{igual} {
    System.out.println("encontre un operador: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("IGUAL ----- ",yytext());
    return new Symbol (sym.IGUAL);
}
{operadorA} {
    System.out.println("encontre un operador: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("OPERADOR ----- ",yytext());
    return new Symbol (sym.OPERADORA);
}
{mas} {
    System.out.println("encontre un operador: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("MAS ----- ",yytext());
    return new Symbol (sym.MAS);
}
{menos} {
    System.out.println("encontre un operador: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("MENOS ----- ",yytext());
    return new Symbol (sym.MENOS);
}
{menor} {
    System.out.println("encontre un operador: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("MENOR ----- ",yytext());
    return new Symbol (sym.MENOR);
}
{mayor} {
    System.out.println("encontre un operador: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("MAYOR ----- ",yytext());
    return new Symbol (sym.MAYOR);
}
{noIgual} {
    System.out.println("encontre un operador: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("NOIGUAL ----- ",yytext());
    return new Symbol (sym.NOIGUAL);
}

/* Expresiones delcaradas  */
{real} {
    System.out.println("encontre una real: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("REAL ----- ",yytext());
    return new Symbol (sym.REAL);
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
    return new Symbol (sym.NUMEROENTERO);
    }
{ID} {
    System.out.println("encontre una variable: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("ID ----- ",yytext());
    return new Symbol (sym.ID);
    }
{ID_Metodo} {
    System.out.println("encontre una var de Metodo: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("ID_METODO ----- ",yytext());
    return new Symbol (sym.ID_METODO);
    }
{mayorIgual} {
    System.out.println("encontre un mayorIgual: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("MAYORIGUAL ----- ",yytext());
    return new Symbol (sym.MAYORIGUAL);
    }
{menorIgual} {
    System.out.println("encontre un mayorIgual: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthor("MENORIGUAL ----- ",yytext());
    return new Symbol (sym.MENORIGUAL);
    }

.    {System.out.println("error: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthorErr("ERROR ---- ",yytext());
}
