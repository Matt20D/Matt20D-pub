public class tester {
    
    public static void main(String[] args){
        
        String temp = "3/2/20,,Sales Receipt,,cleaning fees:Regular Service,Cleaning Service on 03/02/2020,145.00,"Customer, Joe", Joe Cleaner";
        String[] temp2 = temp.split(",");
        for(String i : temp2)
            System.out.println(i);
        
    }
}
