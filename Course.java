public class Course
{

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
    public Course()
    {
        // ..................................
        // initialzations
        name = "";
        courseCode = "";
        description = "";
        PrCr = "";

        equivCourseIndex = 0;
        preReqIndex = 0;
        coReqIndex = 0;
        // ...........................................
    }

    public void processData(String[] tokens)
    {
        if (tokens[0].equals(COURSE_CODE))
        {
            // E.g Comp 1010
            courseCode = tokens[0] + " " + tokens[1];

            for (int i = 2; i < tokens.length; i++)
            {
                name += tokens[i] + ((i < tokens.length - 1) ? " " : "");
            }

        } else if (tokens[0].equals(PRE_REQ) || tokens[0].equals(PRE_REQS))
        {
            int coReqStart = tokens.length;// The token that started corequisites

            preReqs = new String[tokens.length];

            for (int i = 1; i < tokens.length; i++)
            {
                if (!containsLowerCaseLetter(tokens[i]))
                {
                    preReqs[preReqIndex] = tokens[i] + " " + tokens[i + 1];
                    preReqIndex++;
                } else if (tokens[i].equals(CO_REQUISITES))
                {
                    coReqStart = i;

                    coReqs = new String[tokens.length];

                    for (int j = i + 1; j < tokens.length; j++)
                    {
                        if (!containsLowerCaseLetter(tokens[j]))
                        {
                            coReqs[coReqIndex] = tokens[j] + " " + tokens[j + 1];
                            coReqIndex++;
                        }
                    }

                    if (coReqIndex == 0)
                    {
                        StringBuilder tempString = new StringBuilder();

                        for (int j = 1; j < tokens.length; j++)
                        {
                            tempString.append(tokens[i]).append(" ");
                        }

                        coReqs[coReqIndex++] = tempString.toString();
                    }
                    break;
                }
            }

            if (preReqIndex == 0)
            {
                StringBuilder tempString = new StringBuilder();
                for (int i = 1; i < coReqStart; i++)
                {
                    tempString.append(tokens[i]).append(" ");
                }

                preReqs[preReqIndex++] = tempString.toString();
            }

        } else if (tokens[0].equals(EQUIV_COURSE))
        {
            equivCourse = new String[tokens.length];

            for (int i = 2; i < tokens.length; i++)
            {

                if (!containsLowerCaseLetter(tokens[i]))
                {
                    equivCourse[equivCourseIndex] = tokens[i] + " " + tokens[i + 1];
                    equivCourseIndex++;
                }
            }

        } else if (tokens[0].equals(ATTRIBUTES))
        {

        } else if (tokens[0].equals(PR_CR))
        {

        } else if (tokens[0].equals(MUTUALLY_EXCLUSIVE))
        {

        } else
        {

        }
    }

    public boolean containsLowerCaseLetter(String s)
    {
        for (int i = 0; i < s.length(); i++)
        {
            if (!Character.isLetter(s.charAt(i)))
            {
                return true;
            } else if (Character.isLowerCase(s.charAt(i)))
            {
                return true;
            }
        }
        return false;
    }

    public void printAttribute()
    {
        final int NUM_ITEMS_PER_LINE = 5;

        int numItems = 0;
        String equiv = "{ ";
        String prereq = "{ ";
        String coreq = "{ ";

        if (equivCourse.length != 0)
        {
            equiv += " ";
        }

        for (int i = 0; i < equivCourseIndex; i++)
        {
            if (numItems >= NUM_ITEMS_PER_LINE)
            {
                equiv += ("\n  ");
                numItems = 0;
            }

            equiv += (i == equivCourseIndex - 1) ? equivCourse[i] + " " : equivCourse[i] + ", ";
            numItems++;

        }

        for (int i = 0; i < preReqIndex; i++)
        {
            if (numItems >= NUM_ITEMS_PER_LINE)
            {
                prereq += ("\n  ");
                numItems = 0;
            }

            prereq += (i == preReqIndex - 1) ? preReqs[i] + " " : preReqs[i] + ", ";
            numItems++;

        }
        for (int i = 0; i < coReqIndex; i++)
        {
            if (numItems >= NUM_ITEMS_PER_LINE)
            {
                coreq += ("\n  ");
                numItems = 0;
            }

            coreq += (i == coReqIndex - 1) ? coReqs[i] + " " : coReqs[i] + ", ";
            numItems++;

        }
        equiv += "}";
        prereq += "}";
        coreq += "}";


        System.out.println(courseCode);
        System.out.println(name);
        System.out.println(prereq);
        System.out.println(coreq);
        System.out.println(equiv);
        System.out.println();
    }
}
