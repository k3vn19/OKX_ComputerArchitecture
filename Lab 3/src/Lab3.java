import java.io.*;
import java.util.ArrayList;

/**
 * Compiler for CSE 141L assembly code.
 *
 * Usage: To compile program X replace the index param in read() and compile() in the main() method to X.
 */
public class Lab3 {

    /**
     * This ArrayList will hold all of the assembly lines from .txt files being read.
     */
    private static ArrayList<String> lines = new ArrayList<>();

    public static void main(String[] args) {
        try {
            read(2);
        } catch (IOException e) {
            System.out.println("Files not read!!!");
        }

        // compile the assembly code and write to output files
        try {
            compile(2);
        } catch (IOException e) {
            System.out.println("Unable to write!!!");
        }
    } // end of main()

    /**
     * Helper method to read the assembly code into ArrayList to be used by compile().
     *
     * @param index Refers to the program to be compiled.
     * @throws IOException Exception thrown if files are unable to be opened and read.
     */
    private static void read(int index) throws IOException {
        BufferedReader reader;

        // choose which file to read from depending on index parameter.
        if (index == 1) {
            // first read in lines of assembly code
            reader = new BufferedReader(new FileReader("src/program1.txt"));
        } else if (index == 2) {
            reader = new BufferedReader(new FileReader("src/program2.txt"));
        } else {
            reader = new BufferedReader(new FileReader("src/program3.txt"));
        }

        // read through each line of file and add the sring to ArrayList.
        String line = reader.readLine();
        while (line != null) {
            // add each read line to the array list
            lines.add(line);

            line = reader.readLine();
        }
        reader.close();

    } // end of read()


    /**
     * Helper method to compile the assembly instructions and write the output to corresponding output files.
     *
     * @param index Corresponds to which program is being compiled.
     * @throws IOException Exception thrown if BufferedWriter cannot open and write to file.
     */
    private static void compile(int index) throws IOException {

        BufferedWriter writer; // writer for machine code
        BufferedWriter writer2; // writer for machine code with comments and debug errors

        // choose which files to write to depending on index parameter.
        if (index == 1) {
            writer = new BufferedWriter(new FileWriter("machine1.txt"));
            writer2 = new BufferedWriter(new FileWriter("machine1_comments.txt"));
        } else if (index == 2) {
            writer = new BufferedWriter(new FileWriter("machine2.txt"));
            writer2 = new BufferedWriter(new FileWriter("machine2_comments.txt"));
        } else {
            writer = new BufferedWriter(new FileWriter("machine3.txt"));
            writer2 = new BufferedWriter(new FileWriter("machine3_comments.txt"));
        }


        // iterate through each line of assembly code and begin converting it to machine code
        for (int i = 0; i < lines.size(); i++) {
            // split instruction from comment
            String instruction[] = lines.get(i).split("#");

            // split the instruction into the arguments
            String arguments[] = instruction[0].split("\\s+", 5);

            String opcode = getOpcode(arguments[0]);

            String toWrite; // raw machine code
            String toWrite2; // machine code in debug mode
            if (opcode == null) {
                // this should only be labels/non compiled lines, debugging purposes only
                //System.out.println("Skipped: " + lines.get(i));

                toWrite = lines.get(i);
                writer2.write(toWrite + "\n"); // only write non compiled lines to debug version of machine code

            } else if (opcode.equals("110")) {
                // if the instruction is "get", get the source and immediate
                String source = getRegister(arguments[1]);
                String immediate = getImm(arguments[2]);

                // error check
                if (immediate == null) {
                    System.out.println("Error getting immediate value: " + lines.get(i));
                } else {
                    // if there is no error then write the machine code
                    toWrite = opcode + source + immediate;
                    toWrite2 = opcode + "_" + source + "_" + immediate;
                    writer.write(toWrite + "\n");

                    // add comments for debug file
                    String comment = " # " + instruction[0];
                    toWrite2 += comment;
                    writer2.write(toWrite2 + "\n");
                }

            } else if (opcode.equals("111")) {
                // if the instruction is "shft", get the source, direction and shift amount
                String source = getRegister(arguments[1]);
                String direction = arguments[2];
                String shamt = getShAmt(arguments[3]);

                boolean error = false;
                // error check
                if (shamt == null) {
                    error = true;
                    System.out.println("Error getting shift amount: " + lines.get(i));
                }
                if (direction.length() != 1) {
                    error = true;
                    System.out.println("Error getting shift direction: " + lines.get(i));
                    System.out.println("Direction computed: " + direction);
                }

                // if no error write the machine code
                if (!error) {
                    // write compiled machine code
                    toWrite = opcode + source + direction + shamt;
                    toWrite2 = opcode + "_" + source + "_" + direction + "_" + shamt;
                    writer.write(toWrite + "\n");

                    // add comments for debug file
                    String comment = " # " + instruction[0];
                    toWrite2 += comment;
                    writer2.write(toWrite2 + "\n");
                }
            } else if(opcode.equals("100") || opcode.equals("101")){ // jump statements
                String jumpImm = getJumpImm(arguments[1]);
                if(jumpImm != null){
                    toWrite = opcode + jumpImm;
                    toWrite2 = opcode + "_" +  jumpImm;
                    writer.write(toWrite + "\n");

                    // add comments for debug file
                    String comment = " # " + instruction[0];
                    toWrite2 += comment;
                    writer2.write(toWrite2 + "\n");
                }
                else{
                    System.out.print("Error getting jump immediate: " + lines.get(i));
                }
            } else {
                // all other instructions are R type so get first source and second source register
                String source1 = getRegister(arguments[1]);
                String source2 = getRegister(arguments[2]);

                if (source1 != null && source2 != null) {
                    // write compiled machine code
                    toWrite = opcode +  source1 + source2;
                    toWrite2 = opcode + "_" + source1 + "_" + source2;
                    writer.write(toWrite + "\n");

                    // add comments for debug file
                    String comment = " # " + instruction[0];
                    toWrite2 += comment;
                    writer2.write(toWrite2 + "\n");
                } else {
                    System.out.println("Error computing registers: " + lines.get(i));
                }
            }
        } // end of for loop

        // close the writers so output is written
        writer.close();
        writer2.close();

    } // end of compile()

    /**
     * Helper method to get the opcode for a given line of assembly code.
     *
     * @param line Assembly instruction.
     * @return Opcode in the form of a 3 digit string.
     */
    private static String getOpcode(String line) {
        switch (line) {
            case "ld":
                return "000";
            case "st":
                return "001";
            case "xor":
                return "010";
            case "add":
                return "011";
            case "jz":
                return "100";
            case "jnz":
                return "101";
            case "get":
                return "110";
            case "shft":
                return "111";
            default:
                return null;
        }
    } // end of getOpcode()

    private static String getJumpImm(String line) {
        switch (line) {
            case "0": return "000000";
            case "1": return "000001";
            case "2": return "000010";
            case "3": return "000011";
            case "4": return "000100";
            case "5": return "000101";
            case "6": return "000110";
            case "7": return "000111";
            case "8": return "001000";
            case "9": return "001001";
            case "10": return "001010";
            case "11": return "001011";
            case "12": return "001100";
            case "13": return "001101";
            case "14": return "001110";
            case "15": return "001111";
            case "16": return "010000";
            case "17": return "010001";
            case "18": return "010010";
            case "19": return "010011";
            case "20": return "010100";
            case "21": return "010101";
            case "22": return "010110";
            case "23": return "010111";
            case "24": return "011000";
            case "25": return "011001";
            case "26": return "011010";
            case "27": return "011011";
            case "28": return "011100";
            case "29": return "011101";
            case "30": return "011110";
            case "31": return "011111";
            case "32": return "100000";
            case "33": return "100001";
            case "34": return "100010";
            case "35": return "100011";
            case "36": return "100100";
            case "37": return "100101";
            case "38": return "100110";
            case "39": return "100111";
            case "40": return "101000";
            case "41": return "101001";
            case "42": return "101010";
            case "50": return "000000";
            case "51": return "000000";
            default:
                return null;
        }
    }

    /**
     * Helper method to get binary representation of register number.
     *
     * @param reg Assembly register in form "rX".
     * @return Binary representation of register number as a string.
     */
    private static String getRegister(String reg) {

        switch (reg) {
            case "r0":
                return "000";
            case "r1":
                return "001";
            case "r2":
                return "010";
            case "r3":
                return "011";
            case "r4":
                return "100";
            case "r5":
                return "101";
            case "r6":
                return "110";
            case "r7":
                return "111";
            default:
                return null;
        }
    } // end of getRegister()

    /**
     * Helper method to convert immediate value to binary. This method is used in converting
     * immediate value for get instructions.
     *
     * @param imm String immediate.
     * @return Binary representation of the immediate value as a string.
     */
    private static String getImm(String imm) {
        switch (imm) {
            case "0":
                return "000";
            case "1":
                return "001";
            case "2":
                return "010";
            case "3":
                return "011";
            case "4":
                return "100";
            case "5":
                return "101";
            case "6":
                return "110";
            case "7":
                return "111";
            default:
                return null;
        }
    } // end of getImm()

    /**
     * Helper method to convert shift amount to binary.
     *
     * @param shamt String shift amount in decimal form.
     * @return Binary representation of the shift amount as a string.
     */
    private static String getShAmt(String shamt) {
        switch (shamt) {
            case "1":
                return "01";
            case "2":
                return "10";
            case "3":
                return "11";
            default:
                return null;
        }
    } // end of getShAmt()

} // end of class