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
incrementar = "incrementar"
decrementar = "decrementar"
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
usoMetodo= "()"
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
    LexLuthor("DECREMENTO ----- ",yytext());
    return new Symbol (sym.DECREMENTO);
}
{incremento} { 
    LexLuthor("INCREMENTO ----- ",yytext());
    return new Symbol (sym.INCREMENTO);
}
{cadena} { 
    LexLuthor("CADENA ----- ",yytext());
    return new Symbol (sym.CADENA);
}
{ComenA} { 
    LexLuthor("COMENTARIOA ----- ",yytext());
    return new Symbol (sym.COMENTARIOA);
}
{ComenB} { 
    LexLuthor("COMENTARIOB ----- ",yytext());
    return new Symbol (sym.COMENTARIOB);
}
/*Palabras Reservadas*/
{incrementar} {
    LexLuthor("INCREMENTAR ----- ",yytext());
    return new Symbol (sym.INCREMENTAR);
    }
{decrementar} {
    LexLuthor("DECREMENTAR ----- ",yytext());
    return new Symbol (sym.DECREMENTAR);
    }
{v} {
    LexLuthor("VERDADERO ----- ",yytext());
    return new Symbol (sym.VERDADERO);
 }
{f} {
    LexLuthor("FALSO ----- ",yytext());
    return new Symbol (sym.FALSO);
}
{si} {
    LexLuthor("SI ----- ",yytext());
    return new Symbol (sym.SI);
}
{escribir} {
    LexLuthor("ESCRIBIR ----- ",yytext());
    return new Symbol (sym.ESCRIBIR);
}
{leer} {
    LexLuthor("LEER ----- ",yytext());
    return new Symbol (sym.LEER);
}
{sino} {
    LexLuthor("SINO ----- ",yytext());
    return new Symbol (sym.SINO);
}
{entonces} {
    LexLuthor("ENTONCES ----- ",yytext());
    return new Symbol (sym.ENTONCES);
}
{desde} {
    LexLuthor("DESDE ----- ",yytext());
    return new Symbol (sym.DESDE);
}
{mientras} {
    LexLuthor("MIENTRAS ----- ",yytext());
    return new Symbol (sym.MIENTRAS);
}
{devolver} {
    LexLuthor("DEVOLVER ----- ",yytext());
    return new Symbol (sym.DEVOLVER);
}
{hacer} {
    LexLuthor("HACER ----- ",yytext());
    return new Symbol (sym.HACER);
}
{instanciar} {
    LexLuthor("INSTANCIAR ----- ",yytext());
    return new Symbol (sym.INSTANCIAR);
}
{eliminar} {
    LexLuthor("ELIMINAR ----- ",yytext());
    return new Symbol (sym.ELIMINAR);
}
{contructor} {
    LexLuthor("CONSTRUCTOR ----- ",yytext());
    return new Symbol (sym.CONSTRUCTOR);
}
{destructor} {
    LexLuthor("DESTRUCTOR ----- ",yytext());
    return new Symbol (sym.DESTRUCTOR);
}
{and} {
    LexLuthor("AND ----- ",yytext());
    return new Symbol (sym.AND);
}
{or} {
    LexLuthor("OR ----- ",yytext());
    return new Symbol (sym.OR);
}
{Principal} {
    LexLuthor("PRINCIPAL ----- ",yytext());
    return new Symbol (sym.PRINCIPAL);
}
{incluir} {
    LexLuthor("INCLUIR ----- ",yytext());
    return new Symbol (sym.INCLUIR);
}
{clase} { 
    LexLuthor("CLASE ----- ",yytext());
    return new Symbol (sym.CLASE);
}
{extiende} { 
    LexLuthor("EXTIENDE ----- ",yytext());
    return new Symbol (sym.EXTIENDE);
}
{nuevo} {
    LexLuthor("NUEVO ----- ",yytext());
    return new Symbol (sym.NUEVO);
}
{enteroR} { 
    LexLuthor("ENTERO ----- ",yytext());
    return new Symbol (sym.ENTEROR);
}
{realR} {
    LexLuthor("REAL ----- ",yytext());
    return new Symbol (sym.REALR);
}
{cadenaR} { 
    LexLuthor("CADENA ----- ",yytext());
    return new Symbol (sym.CADENAR);
}
{boleanoR} {
    LexLuthor("BOOLEANO ----- ",yytext());
    return new Symbol (sym.BOOLEANOR);
}
{nulo} {
    LexLuthor("NULO ----- ",yytext());
    return new Symbol (sym.NULO);
}
{propiedades} {
    LexLuthor("PROPIEDADES ----- ",yytext());
    return new Symbol (sym.PROPIEDADES);
}
{metodos} {
    LexLuthor("METODOS ----- ",yytext());
    return new Symbol (sym.METODOS);
}
{publicas} {
    LexLuthor("PUBLICAS ----- ",yytext());
    return new Symbol (sym.PUBLICAS);
}
{privadas} {
    LexLuthor("PRIVADAS ----- ",yytext());
    return new Symbol (sym.PRIVADAS);
}
{protegidas} {
    LexLuthor("PROTEGIDAS ----- ",yytext());
    return new Symbol (sym.PROTEGIDAS);
}
{publicos} {
    LexLuthor("PUBLICOS ----- ",yytext());
    return new Symbol (sym.PUBLICOS);
}
{privados} {
    LexLuthor("PRIVADOS ----- ",yytext());
    return new Symbol (sym.PRIVADOS);
}
{protegidos} {
    LexLuthor("PROTEGIDOS ----- ",yytext());
    return new Symbol (sym.PROTEGIDOS);
}
/* Funciones especiales */
/* Funciones Matematicas */
{seno} {
    LexLuthor("SENO ----- ",yytext());
    return new Symbol (sym.SENO);
}
{coseno} {
    LexLuthor("COSENO ----- ",yytext());
    return new Symbol (sym.COSENO);
}
{tangente} {
    LexLuthor("TANGENTE ----- ",yytext());
    return new Symbol (sym.TANGENTE);
}
{logaritmo} {
    LexLuthor("LOGARITMO ----- ",yytext());
    return new Symbol (sym.LOGARITMO);
}
{raiz} {
    LexLuthor("RAIZ ----- ",yytext());
    return new Symbol (sym.RAIZ);
}
/* Funciones de conversión de tipos */
{cadenaAEntero} {
    LexLuthor("CADENAAENTERO ----- ",yytext());
    return new Symbol (sym.CADENAAENTERO);
}
{cadenaAReal} {
    LexLuthor("CADENAAREAL ----- ",yytext());
    return new Symbol (sym.CADENAAREAL);
}
{cadenaABoleano} {
    LexLuthor("CADENAABOOLEANO ----- ",yytext());
    return new Symbol (sym.CADENAABOOLEANO);
}
/*Signos*/
{usoMetodo} {
    LexLuthor("USOMETODO ----- ",yytext());
    return new Symbol (sym.USOMETODO);
}
{Punto} {
    LexLuthor("PUNTO ----- ",yytext());
    return new Symbol (sym.PUNTO);
}
{DosPuntos} {
    LexLuthor("DOSPUNTOS ----- ",yytext());
    return new Symbol (sym.DOSPUNTOS);
}
{PuntoComa} {
    LexLuthor("PUNTOCOMA ----- ",yytext());
    return new Symbol (sym.PUNTOCOMA);
}
{Coma} {
    LexLuthor("COMA ----- ",yytext());
    return new Symbol (sym.COMA);
}
{Parentesis1} {
    LexLuthor("PARENTESIS1 ----- ",yytext());
    return new Symbol (sym.PARENTESIS1);
}
{Parentesis2} {
    LexLuthor("PARENTESIS2 ----- ",yytext());
    return new Symbol (sym.PARENTESIS2);
}
{Llave1} {
    LexLuthor("LLAVE1 ----- ",yytext());
    return new Symbol (sym.LLAVE1);
}
{Llave2} {
    LexLuthor("LLAVE2 ----- ",yytext());
    return new Symbol (sym.LLAVE2);
}
{Comillas} {
    LexLuthor("COMILLAS ----- ",yytext());
    return new Symbol (sym.COMILLAS);
}
{espacio} {
}
{tabulador} {
    return new Symbol (sym.TABULADOR);
}
/*OPERADORES*/
{igual} {
    LexLuthor("IGUAL ----- ",yytext());
    return new Symbol (sym.IGUAL);
}
{operadorA} {
    LexLuthor("OPERADOR ----- ",yytext());
    return new Symbol (sym.OPERADORA);
}
{mas} {
    LexLuthor("MAS ----- ",yytext());
    return new Symbol (sym.MAS);
}
{menos} {
    LexLuthor("MENOS ----- ",yytext());
    return new Symbol (sym.MENOS);
}
{menor} {
    LexLuthor("MENOR ----- ",yytext());
    return new Symbol (sym.MENOR);
}
{mayor} {
    LexLuthor("MAYOR ----- ",yytext());
    return new Symbol (sym.MAYOR);
}
{noIgual} {
    LexLuthor("NOIGUAL ----- ",yytext());
    return new Symbol (sym.NOIGUAL);
}

/* Expresiones delcaradas  */
{real} {
    LexLuthor("REAL ----- ",yytext());
    return new Symbol (sym.REAL);
}
{NumeroMalo} {
    LexLuthorErr("NUMEROMALO ----- ",yytext());
    }
{numeroEntero} {
    LexLuthor("NUMEROENTERO ----- ",yytext());
    return new Symbol (sym.NUMEROENTERO);
    }
{ID} {
    LexLuthor("ID ----- ",yytext());
    return new Symbol (sym.ID);
    }
{ID_Metodo} {
    LexLuthor("ID_METODO ----- ",yytext());
    return new Symbol (sym.ID_METODO);
    }
{mayorIgual} {
    LexLuthor("MAYORIGUAL ----- ",yytext());
    return new Symbol (sym.MAYORIGUAL);
    }
{menorIgual} {
    LexLuthor("MENORIGUAL ----- ",yytext());
    return new Symbol (sym.MENORIGUAL);
    }
{SaltoDeLinea} { 
    LexLuthor("ENTER ----- ",yytext());
    return new Symbol (sym.ENTER);
}

.    {System.out.println("error: ["+ yytext() + "] en linea: " 
    + (yyline+1)  + " columna: " + (yycolumn+1));
    LexLuthorErr("ERROR ---- ",yytext());
}
