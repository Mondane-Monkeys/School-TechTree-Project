import java.util.ArrayList;

public class Main {
    public static void main(String[] args) {
        try {
            ArrayList<Course> myCourses = ProcessWebData.parseFile("");
            System.out.println(myCourses.size());
        } catch (Exception e) {
            System.out.println(e);
        }
        
    }
}
