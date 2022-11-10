import java.util.Random;
public class birth {

    public static final int YEAR = 365;

    public static void main(String[] args) {

        int numOfPeople = 5;
        int people = 5;
        //DOB array
        int[] birthday = new int[YEAR + 1];
        //Creates an array that represents 365 days
        for (int i = 0; i < birthday.length; i++)
            birthday[i] = i + 1;
        //Random Number generator
        Random randNum = new Random();
        int iteration = 1;
        while (numOfPeople <= 24) {
            System.out.println("Iteration: " + iteration);
            System.out.println();
            int[] peopleBirthday = new int[numOfPeople];
            //Assigns people DOB to people in the room
            for (int i = 0; i < peopleBirthday.length; i++) {
                int day = randNum.nextInt(YEAR + 1);
                peopleBirthday[i] = birthday[day];
            }
            for (int i = 0; i < peopleBirthday.length; i++) {
                //stores value for element before and after
                int person1 = peopleBirthday[i];
                int person2 = i + 1;
                //Checks if people have same birthday
                for (int j = person2; j < peopleBirthday.length; j++) {
                    //Prints matching Birthday days
                    if (person1 == peopleBirthday[j]) {
                        System.out.println("P1: " + person1 + " P2: " + peopleBirthday[j]);
                        System.out.println("Match!!! \n");
                    }
                }
            }

        }
    }

}