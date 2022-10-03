import java.util.Scanner;

class Course {
    // ................................................
    // Keywords for data procecssing
    final String COURSE_CODE = "COMP";
    final String PRE_REQ = "Prerequisite:";
    final String PRE_REQS = "Prerequisites:";// in case there are more than 1 prerequistes
    final String EQUIV_COURSE = "Equiv";
    final String ATTRIBUTES = "Attributes:";
    final String PR_CR = "PR/CR:";
    final String MUTUALLY_EXCLUSIVE = "Mutually";
    // ..........................................................

    // .......................................................
    // Instance variables(Used as tags)
    String name;
    String courseCode;
    String description;
    String PrCr;
    String equivalentCourse;
    String mutuallyExclusive;
    String[] preReqs;
    int preReqIndex;// stores the index of the preReqs array
    int preReqCounter;// counts how many preRequisites the course has
    // .....................................................

    public Course() {

        // ....................................
        // variables to read the file and stuff
        String newLine;
        String[] tokens;
        Scanner fileReader = new Scanner(System.in);
        // .........................................

        while ((newLine = fileReader.nextLine()) != null) {
            tokens = newLine.trim().split("//s+");

            if (tokens[0].equals(COURSE_CODE)) {
                // E.g Comp 1010
                courseCode = tokens[0] + " " + tokens[1];

                for (int i = 2; i < tokens.length; i++) {
                    name = tokens[i] + ((i < tokens.length - 1) ? " " : "");
                }

            } else if (tokens[0].equals(PRE_REQ) || tokens[0].equals(PRE_REQS)) {
                for (int i = 1; i < tokens.length; i++) {
                    if (!isNumeric(tokens[i]) && !containsLowerCaseLetter(tokens[i])) {
                        preReqs[preReqIndex] = tokens[i] + " " + tokens[i + 1];
                        preReqIndex++;
                    }
                }

            } else if (tokens[0].equals(EQUIV_COURSE)) {
                

            } else if (tokens[0].equals(ATTRIBUTES)) {

            } else if (tokens[0].equals(PR_CR)) {

            } else if (tokens[0].equals(MUTUALLY_EXCLUSIVE)) {

            } else {

            }
        }

        fileReader.close();
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