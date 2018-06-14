/*
 * Copyright (c) 2016 BMD Software and University of Aveiro.
 *
 * Neji is a flexible and powerful platform for biomedical information extraction from text.
 *
 * This project is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/.
 *
 * This project is a free software, you are free to copy, distribute, change and transmit it.
 * However, you may not use it for commercial purposes.
 *
 * It is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
 * without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 */

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pt.ua.tm.neji.train.util;

import java.io.*;

/**
 * @author jeronimo
 */
public class ChemnerToBC2 {
    private static void convertAnnotations(String fin, String fout) throws IOException {
        // Verify if file exists
        File file = new File(fin);
        if (!file.exists() || !file.canRead()) {
            System.out.println("File doesn't exist or can't be read.");
            System.exit(0);
        }

        // Read file
        FileInputStream is = new FileInputStream(fin);
        BufferedReader br = new BufferedReader(new InputStreamReader(is));

        // Convert file to BC2
        PrintWriter pwt = new PrintWriter(fout);
        String line;

        while ((line = br.readLine()) != null) {
            String[] parts = line.split("\t");

            String id = parts[0];
            String start = parts[2];
            String end = parts[3];
            String text = parts[4];

            pwt.println(id + "|" + start + " " + end + "|" + text);
        }

        pwt.close();
        br.close();
        is.close();
    }

    private static void convertAbstracts(String fin, String fout) throws IOException {
        File file = new File(fin);
        if (!file.exists() || !file.canRead()) {
            System.out.println("File doesn't exist or can't be read.");
            System.exit(0);
        }

        // Read file
        FileInputStream is = new FileInputStream(fin);
        BufferedReader br = new BufferedReader(new InputStreamReader(is));

        // Convert file to BC2
        PrintWriter pwt = new PrintWriter(fout);
        String line;

        while ((line = br.readLine()) != null) {
            String[] parts = line.split("\t");

            String id = parts[0];
            String title = parts[1];
            String abs = parts[2];

            pwt.println(id + " " + title + " " + abs);
        }

        pwt.close();
        br.close();
        is.close();
    }

    public static void main(String[] args) throws IOException {
        String abstractsIn = args[0];
        String abstractsOut = args[0].replace(".txt", ".bc2");
        convertAbstracts(abstractsIn, abstractsOut);

        if (args.length == 2) {
            String annotationsIn = args[1];
            String annotationsOut = args[1].replace(".txt", ".bc2");
            convertAnnotations(annotationsIn, annotationsOut);
        }
    }
}
