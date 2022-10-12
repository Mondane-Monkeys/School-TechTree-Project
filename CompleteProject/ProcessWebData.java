import java.util.ArrayList;
import java.io.*;
import java.util.*;

public class ProcessWebData {

    // ................................................
    // Keywords for data procecssing
    final String COURSE_CODE = "COMP";
    final String PRE_REQ = "Prerequisite:";
    final String PRE_REQS = "Prerequisites:";// in case there are more than 1 prerequistes
    final String EQUIV_COURSE = "Equiv";
    final String ATTRIBUTES = "Attributes:";
    final String PR_CR = "PR/CR:";
    final String MUTUALLY_EXCLUSIVE = "Mutually";
    final String CO_REQUISITES = "Co-requisite:";
    // ..........................................................

    // .......................................................
    // Instance variables(Used as tags)
    String name;
    String courseCode;
    String description;
    String prCr;
    String attributes;

    String[] equivCourse;
    int equivCourseIndex;

    String[] mutuallyExclusive;
    int mutallyExclusiveIndex;

    String[] preReqs;
    int preReqIndex;// stores the index of the preReqs array

    String[] coReqs;
    int coReqIndex;// stores the index of the coReqs array

    // .....................................................
    // File reader & interface
    public static ArrayList<Course> parseFile(String fileName) throws FileNotFoundException {
        ArrayList<Course> myCourses = new ArrayList<>();
        String newLine;
        String[] tokens;

        Course compCourse = null;

        Scanner fileReader = new Scanner(new File("RawData.txt"));
        while (fileReader.hasNextLine()) {
            newLine = fileReader.nextLine();
            tokens = newLine.trim().split("\\s+");

            if (tokens[0].equals("COMP")) {
                compCourse = new Course();
                myCourses.add(compCourse);
            }

            if (compCourse != null)
                compCourse.processData(tokens);
        }

        return myCourses;
    }

    // .....................................................
    /*
     * ..................................
     * Course Constructor
     * .....................................
     */

    public ProcessWebData() {
        // ..................................
        // initialzations
        name = "";
        courseCode = "";
        description = "";
        prCr = "";
        attributes = "";

        mutallyExclusiveIndex = 0;
        equivCourseIndex = 0;
        preReqIndex = 0;
        coReqIndex = 0;
    }

    public void processData(String[] tokens) {
        if (tokens[0].equals(COURSE_CODE)) {
            courseCode = tokens[0] + " " + tokens[1];

            for (int i = 2; i < tokens.length; i++) {
                name += tokens[i] + ((i < tokens.length - 1) ? " " : "");
            }

        } else if (tokens[0].equals(PRE_REQ) || tokens[0].equals(PRE_REQS)) {
            int coReqStart = tokens.length;// The token that started corequisites

            preReqs = new String[tokens.length];

            for (int i = 1; i < tokens.length; i++) {
                if (isUpperCase(tokens[i])) {
                    preReqs[preReqIndex++] = tokens[i] + " " + tokens[i + 1];
                } else if (tokens[i].equals(CO_REQUISITES)) {
                    coReqStart = i;

                    coReqs = new String[tokens.length];

                    for (int j = i + 1; j < tokens.length; j++) {
                        if (isUpperCase(tokens[j])) {
                            coReqs[coReqIndex++] = tokens[j] + " " + tokens[j + 1];
                        }
                    }

                    if (coReqIndex == 0) {
                        StringBuilder tempString = new StringBuilder();

                        for (int j = 1; j < tokens.length; j++) {
                            tempString.append(tokens[i]).append(" ");
                        }

                        coReqs[coReqIndex++] = tempString.toString().trim();
                    }
                    break;
                }
            }

            if (preReqIndex == 0) {
                StringBuilder tempString = new StringBuilder();

                for (int i = 1; i < coReqStart; i++) {
                    tempString.append(tokens[i]).append(" ");
                }

                preReqs[preReqIndex++] = tempString.toString().trim();
            }

        } else if (tokens[0].equals(EQUIV_COURSE)) {
            equivCourse = new String[tokens.length];

            for (int i = 2; i < tokens.length; i++) {

                if (isUpperCase(tokens[i])) {
                    equivCourse[equivCourseIndex++] = tokens[i] + " " + tokens[i + 1];
                }
            }

        } else if (tokens[0].equals(ATTRIBUTES)) {

            for (int i = 1; i < tokens.length; i++) {
                attributes += tokens[i] + ((i < tokens.length - 1) ? " " : "");
            }

        } else if (tokens[0].equals(PR_CR)) {
            StringBuilder tempString = new StringBuilder();

            for (int i = 1; i < tokens.length; i++) {
                tempString.append(tokens[i]).append(" ");
            }

            prCr = tempString.toString().trim();
        } else if (tokens[0].equals(MUTUALLY_EXCLUSIVE)) {
            mutuallyExclusive = new String[tokens.length];

            for (int i = 2; i < tokens.length; i++) {

                if (isUpperCase(tokens[i])) {
                    mutuallyExclusive[mutallyExclusiveIndex++] = tokens[i] + " " + tokens[i + 1];
                }
            }
        } else if (!tokens[0].equals("")) {
            final int MAX_NUM_OF_WORDS = 12;
            int numWords = 0;

            StringBuilder tempString = new StringBuilder();

            for (int i = 0; i < tokens.length; i++) {
                if (numWords > MAX_NUM_OF_WORDS) {
                    tempString.append("\n");
                    numWords = 0;
                }

                tempString.append(tokens[i]).append(" ");
                numWords++;
            }

            description = tempString.toString().trim();
        }

        // Trim out all the extra non alphabetic characters from the prop arrays.
        trimAttributes(preReqs, preReqIndex);
        trimAttributes(coReqs, coReqIndex);
        trimAttributes(equivCourse, equivCourseIndex);
        trimAttributes(mutuallyExclusive, mutallyExclusiveIndex);
    }// ....................................End ProcessData

    public boolean isUpperCase(String s) {
        for (int i = 0; i < s.length(); i++) {
            if (Character.isDigit(s.charAt(i))) {
                return false;
            } else if (s.charAt(i) == '(' || s.charAt(i) == '[') {
                if (s.contains("+") || s.contains("-") || s.contains(")") || s.contains("]"))
                    return false;

                return true;
            } else if (Character.isLowerCase(s.charAt(i))) {
                return false;
            }
        }
        return true;
    }// .............................End isUpperCase

    public void trimAttributes(String[] prop, int propLength) {
        for (int i = 0; i < propLength; i++) {
            if (prop[i].contains(",")) {
                prop[i] = prop[i].replace(",", "");
            } else if (prop[i].contains(".")) {
                prop[i] = prop[i].replace(".", "");
            } else if (prop[i].contains(";")) {
                prop[i] = prop[i].replace(";", "");
            } else if (prop[i].contains("(")) {
                prop[i] = prop[i].replace("(", "");
            } else if (prop[i].contains(")")) {
                prop[i] = prop[i].replace(")", "");
            } else if (prop[i].contains("[")) {
                prop[i] = prop[i].replace("[", "");
            } else if (prop[i].contains("]")) {
                prop[i] = prop[i].replace("]", "");
            } else if (prop[i].contains("{")) {
                prop[i] = prop[i].replace("{", "");
            } else if (prop[i].contains("}")) {
                prop[i] = prop[i].replace("}", "");
            }
        }
    }

    public String toString() {
        String output = "{" + "\n" +

                "Course Code: " + courseCode + "\n" +
                "Name: " + name + "\n" +
                "Description: " + description + "\n" +
                (prCr.length() > 0 ? ("PR/CR: " + prCr + "\n") : "") +
                (preReqIndex > 1
                        ? "Prerequisite" + (preReqIndex >= 2 ? "s: " : ": ") + propToString(preReqs, preReqIndex) + "\n"
                        : "")
                +
                (coReqIndex > 1
                        ? "Co:requisite" + (coReqIndex >= 2 ? "s: " : ": ") + propToString(coReqs, coReqIndex) + "\n"
                        : "")
                + (equivCourseIndex > 1 ? "Equiv To: " + propToString(equivCourse, equivCourseIndex) + "\n" : "") +
                (mutallyExclusiveIndex > 1 ? "Mutually Exclusive: " + propToString(mutuallyExclusive,
                        mutallyExclusiveIndex) + "\n" : "")
                +
                "Attributes: " + attributes + "\n" +
                "}\n";

        return output;
    }

    public String propToString(String[] prop, int propLength) {
        int MAX_NUM_TOKENS = 8;
        int numTokens = 0;

        StringBuilder tempString = new StringBuilder();

        for (int i = 0; i < propLength; i++) {

            if (numTokens > MAX_NUM_TOKENS) {
                tempString.append("\n");
                numTokens = 0;
            }

            tempString.append(prop[i]).append((i == propLength - 1 ? "." : ", "));
            numTokens++;
        }

        return tempString.toString();
    }
}
