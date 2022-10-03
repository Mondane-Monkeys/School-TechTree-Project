import java.io.File;
import java.io.FileNotFoundException;
import java.util.*;

public class test {
    public static void main(String[] args) throws FileNotFoundException {
        Scanner test = new Scanner(new File("test.txt"));
        String newLine;

        while (test.hasNextLine()) {
            newLine = test.nextLine();
            System.out.println(newLine);
        }
    }
}
