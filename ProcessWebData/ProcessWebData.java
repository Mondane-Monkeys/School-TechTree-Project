package ProcessWebData;
import java.util.ArrayList;

public class ProcessWebData {
    public static ArrayList<ProcessWebData> courseList = new ArrayList<>();

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

    String[] attributes;
    int attributeIndex;

    String[] equivCourse;
    int equivCourseIndex;

    String[] mutuallyExclusive;
    int mutallyExclusiveIndex;

    String[] preReqs;
    int preReqIndex;// stores the index of the preReqs array

    String[] coReqs;
    int coReqIndex;// stores the index of the coReqs array

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

        mutallyExclusiveIndex = 0;
        equivCourseIndex = 0;
        attributeIndex = 0;
        preReqIndex = 0;
        coReqIndex = 0;
        // ...........................................

        courseList.add(this);
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

                        coReqs[coReqIndex++] = tempString.toString();
                    }
                    break;
                }
            }

            if (preReqIndex == 0) {
                StringBuilder tempString = new StringBuilder();

                for (int i = 1; i < coReqStart; i++) {
                    tempString.append(tokens[i]).append(" ");
                }

                preReqs[preReqIndex++] = tempString.toString();
            }

        } else if (tokens[0].equals(EQUIV_COURSE)) {
            equivCourse = new String[tokens.length];

            for (int i = 2; i < tokens.length; i++) {

                if (isUpperCase(tokens[i])) {
                    equivCourse[equivCourseIndex++] = tokens[i] + " " + tokens[i + 1];
                }
            }

        } else if (tokens[0].equals(ATTRIBUTES)) {
            attributes = new String[tokens.length];

            for (int i = 1; i < tokens.length; i++) {
                attributes[attributeIndex++] = tokens[i];
            }

        } else if (tokens[0].equals(PR_CR)) {
            StringBuilder tempString = new StringBuilder();

            for (int i = 1; i < tokens.length; i++) {
                tempString.append(tokens[i]).append(" ");
            }

            prCr = tempString.toString();
        } else if (tokens[0].equals(MUTUALLY_EXCLUSIVE)) {
            mutuallyExclusive = new String[tokens.length];

            for (int i = 2; i < tokens.length; i++) {

                if (isUpperCase(tokens[i])) {
                    mutuallyExclusive[mutallyExclusiveIndex++] = tokens[i] + " " + tokens[i + 1];
                }
            }
        } else {

        }

        // Trim out all the extra '.' and ',' characters from the arrays.
        trimAttributes(preReqs, preReqIndex);
        trimAttributes(coReqs, coReqIndex);
        trimAttributes(equivCourse, equivCourseIndex);
        trimAttributes(mutuallyExclusive, mutallyExclusiveIndex);
        trimAttributes(attributes, attributeIndex);
    }

    public boolean isUpperCase(String s) {
        for (int i = 0; i < s.length(); i++) {
            if (!Character.isLetter(s.charAt(i))) {
                return false;
            } else if (Character.isLowerCase(s.charAt(i))) {
                return false;
            }
        }
        return true;
    }

    public void trimAttributes(String[] prop, int propLength) {
        for (int i = 0; i < propLength; i++) {
            if (prop[i].contains(",")) {
                prop[i] = prop[i].replace(",", "");
            } else if (prop[i].contains(".")) {
                prop[i] = prop[i].replace(".", "");
            }
        }
    }

    public String toString() {
        String output = "{" + "\n" +

                "Course Code: " + courseCode + "\n" +
                "Name: " + name + "\n" +
                "PR/CR: " + prCr + "\n" +
                (preReqIndex > 1 ? (propToString(preReqs, preReqIndex).length() + "\n") : "") +
                (coReqIndex > 1 ? (propToString(preReqs, preReqIndex).length() + "\n") : "") +
                (equivCourseIndex > 1 ? (propToString(equivCourse, equivCourseIndex).length() + "\n") : "") +
                (mutallyExclusiveIndex > 1 ? (propToString(mutuallyExclusive, mutallyExclusiveIndex).length() +
                        "\n") : "")
                +
                (attributeIndex > 1 ? (propToString(attributes, attributeIndex).length() + "\n") : "") +
                "}\n";

        return output;
    }

    public String propToString(String[] prop, int propLength) {
        StringBuilder tempString = new StringBuilder();

        for (int i = 0; i < propLength; i++) {
            tempString.append(prop[i]).append(", ");
        }

        return tempString.toString();
    }
}
