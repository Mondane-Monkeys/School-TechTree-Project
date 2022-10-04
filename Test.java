import java.io.*;
import java.util.*;

public class Main
{
    public static void main(String[] args) throws FileNotFoundException
    {
        String newLine;
        String[] tokens;

        Course compCourse = new Course();

        Scanner fileReader = new Scanner(new File("test.txt"));
        while (fileReader.hasNextLine())
        {
            newLine = fileReader.nextLine();
            tokens = newLine.trim().split("\\s+");


//            System.out.println(tokens[0]);
            compCourse.processData(tokens);
        }
        compCourse.printAttribute();
    }
}
