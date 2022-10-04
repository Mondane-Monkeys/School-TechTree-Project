package ProcessWebData;
import java.io.*;
import java.util.*;

public class Main
{
    public static ArrayList<ProcessWebData> myCourses = new ArrayList<>();

    public static void main(String[] args) throws FileNotFoundException
    {
        String newLine;
        String[] tokens;

        ProcessWebData compCourse = null;

        Scanner fileReader = new Scanner(new File("test.txt"));
        while (fileReader.hasNextLine())
        {
            newLine = fileReader.nextLine();
            tokens = newLine.trim().split("\\s+");

            if (tokens[0].equals("COMP"))
            {
                compCourse = new ProcessWebData();
                myCourses.add(compCourse);
            }

            if (compCourse != null)
                compCourse.processData(tokens);
        }

        assert compCourse != null;

        System.out.println(myCourses.size());
    }
}
