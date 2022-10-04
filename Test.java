import java.io.*;
import java.util.*;

public class Test
{
    public static ArrayList<Course> myCourses = new ArrayList<>();

    public static void main(String[] args) throws FileNotFoundException
    {
        String newLine;
        String[] tokens;

        Course compCourse = null;

        Scanner fileReader = new Scanner(new File("test.txt"));
        while (fileReader.hasNextLine())
        {
            newLine = fileReader.nextLine();
            tokens = newLine.trim().split("\\s+");

            if (tokens[0].equals("COMP"))
            {
                compCourse = new Course();
                myCourses.add(compCourse);
            }

            if (compCourse != null)
                compCourse.processData(tokens);
        }

        assert compCourse != null;

        System.out.println(!Character.isUpperCase('['));

        for (int i = 0; i < myCourses.size(); i++)
        {
            System.out.println(myCourses.get(i));
        }
    }
}
