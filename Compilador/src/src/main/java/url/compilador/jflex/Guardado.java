/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package url.compilador.jflex;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author HP15DA0023LA
 */
public class Guardado {
    public void LexLuthor(String Token, String Valor) throws IOException
    {
        try {
            char enter=13;
            String regreso=Token+"  "+Valor;
            RandomAccessFile traductor= new RandomAccessFile("LEXEMAS.txt","rw");
            traductor.seek(traductor.length());
            traductor.writeBytes(regreso);
            traductor.writeChar(enter);
        } catch (FileNotFoundException ex) {
            Logger.getLogger(Guardado.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    public void LexLuthorErr(String Token, String Valor) throws IOException
    {
        try {
            char enter=13;
            String regreso=Token+"  "+Valor;
            RandomAccessFile traductor= new RandomAccessFile("ERRORES.txt","rw");
            traductor.seek(traductor.length());
            traductor.writeBytes(regreso);
            traductor.writeChar(enter);
        } catch (FileNotFoundException ex) {
            Logger.getLogger(Guardado.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}


