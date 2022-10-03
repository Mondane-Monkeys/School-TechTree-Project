import java.util.Scanner;

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
    String PrCr;

    String[] equivCourse;
    int equivCourseIndex;
    int equivCourseCounter;

    String[] mutuallyExclusive;
    int mutallyExclusiveIndex;
    int mutuallyExclusiveCounter;

    String[] preReqs;
    int preReqIndex;// stores the index of the preReqs array
    int preReqCounter;// counts how many preRequisites the course has

    String[] coReqs;
    int coReqIndex;// stores the index of the coReqs array
    int coReqCounter;// counts how many coRequisites the course has

    // .....................................................

    /*
     * ..................................
     * Course Constructor
     * .....................................
     */
    public ProcessWebData() {

        // ....................................
        // variables to read the file and stuff
        String newLine;
        String[] tokens;
        Scanner fileReader = new Scanner(System.in);
        // .........................................

        // ..................................
        // initialzations
        equivCourseIndex = 0;
        equivCourseCounter = 0;

        int preReqIndex = 0;
        int preReqCounter = 0;

        int coReqIndex = 0;
        int coReqCounter = 0;
        // ...........................................

        while ((newLine = fileReader.nextLine()) != null) {
            tokens = newLine.trim().split("//s+");

            if (tokens[0].equals(COURSE_CODE)) {
                // E.g Comp 1010
                courseCode = tokens[0] + " " + tokens[1];

                for (int i = 2; i < tokens.length; i++) {
                    name = tokens[i] + ((i < tokens.length - 1) ? " " : "");
                }

            } else if (tokens[0].equals(PRE_REQ) || tokens[0].equals(PRE_REQS)) {
                preReqs = new String[tokens.length];

                for (int i = 1; i < tokens.length; i++) {

                    if (!isNumeric(tokens[i]) && !containsLowerCaseLetter(tokens[i])) {
                        preReqs[preReqIndex] = tokens[i] + " " + tokens[i + 1];
                        preReqIndex++;
                    } else if (tokens[i].equals(CO_REQUISITES)) {
                        coReqs = new String[tokens.length];

                        for (int j = i + 1; j < tokens.length; j++) {
                            if (!isNumeric(tokens[j]) && !containsLowerCaseLetter(tokens[j])) {
                                coReqs[coReqIndex] = tokens[j] + " " + tokens[j + 1];
                                coReqIndex++;
                            }
                        }

                        if (coReqs.length == 0) {
                            for (int j = 0; j < tokens.length; j++) {
                                coReqs[0] = tokens[j] + " ";
                            }
                        }
                    }
                }
                if (preReqs.length == 0) {
                    for (int i = 0; i < tokens.length; i++) {
                        preReqs[0] = tokens[i] + " ";
                    }
                }

            } else if (tokens[0].equals(EQUIV_COURSE)) {
                for (int i = 2; i < tokens.length; i++) {

                    if (!isNumeric(tokens[i]) && !containsLowerCaseLetter(tokens[i])) {
                        preReqs[preReqIndex] = tokens[i] + " " + tokens[i + 1];
                        preReqIndex++;
                    } else if (tokens[i].equals(CO_REQUISITES)) {
                        coReqs = new String[tokens.length];

                        for (int j = i + 1; j < tokens.length; j++) {
                            if (!isNumeric(tokens[j]) && !containsLowerCaseLetter(tokens[j])) {
                                coReqs[coReqIndex] = tokens[j] + " " + tokens[j + 1];
                                coReqIndex++;
                            }
                        }

                        if (coReqs.length == 0) {
                            for (int j = 0; j < tokens.length; j++) {
                                coReqs[0] = tokens[j] + " ";
                            }
                        }
                    }
                }

            } else if (tokens[0].equals(ATTRIBUTES)) {

            } else if (tokens[0].equals(PR_CR)) {

            } else if (tokens[0].equals(MUTUALLY_EXCLUSIVE)) {

            } else {

            }
            fileReader.close();
        }
    }

    public static boolean isNumeric(String strNum) {
        if (strNum == null) {
            return false;
        }

        try {
            Integer.parseInt(strNum);
        } catch (NumberFormatException nfe) {
            return false;
        }
        return true;
    }

    public boolean containsLowerCaseLetter(String s) {
        for (int i = 0; i < s.length(); i++) {
            if (Character.isLowerCase(s.charAt(i))) {
                return true;
            }
        }
        return false;
    }
}