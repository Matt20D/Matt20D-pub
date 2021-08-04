import java.lang.NullPointerException; 
import java.util.ArrayList;

public class Client {
    
    private int numCleans; // number of cleans a client had in a month
    private String startingBAF; // what was the starting baf for the month
    private String name; // name of the client
    private String cleanPrice; // clean price for a given client
    
    private Double startingBAFValue; // starting bar at the beginning of the month, Double object
    private Double endingBAFValue; // ending bar at the end of the month, Double object
    private Double cleanPriceValue; // getting the actual price from the string
    public static final double FINANCING_PERCENTAGE = 0.15; // this is the financing fee
    private ArrayList<Double> afterCleansBAF; // add to this array list the value after each clean.
    
    
    // construct a client
    public Client (String name, int numCleans, String startingBAF, String cleanPrice) {
        
        this.name = name;
        this.numCleans = numCleans;
        this.startingBAF = startingBAF;
        this.cleanPrice = cleanPrice;
        this.afterCleansBAF = new ArrayList<Double>();
   
    }
    
    // getter methods
    public int getCleans(){
        return numCleans;
    }
    
    public String getBAF(){
        return startingBAF;
    }
    
    public String getName(){
        return name;
    }
    
    public String getPrice(){
        return cleanPrice;
    }
    
    public double getBAFStartValue(){
        return startingBAFValue;
    }
    
    // new, delete?
    public double getBAFEndValue(){
        return endingBAFValue;
    }
    
    // this method takes in the bad value and converts it to a double.
    public void setValues(){
        
        // check for null pointer exceptions from the inputted arraylist/array values
        try{        
            startingBAFValue = Double.parseDouble(this.startingBAF); // get the double value from a string 
        } catch(NullPointerException e1){ // catch this exception for null values and turn it into 0's        
            startingBAFValue = 0.00;
        }  
        
        // do the same thing for the cleaning price
        try{
            cleanPriceValue = Double.parseDouble(this.cleanPrice);
        } catch(NullPointerException e2){
            cleanPriceValue = 0.00;
        }
              
    }
    
    // this setter method does the financing calculations
    private void doFinancing(){
        
        // set the starting BAF value
        setValues();
        
        // deduction doesn't change
        double deduction = FINANCING_PERCENTAGE * this.cleanPriceValue; 
        
        // calculate the currentValue and append to the arraylist
        double currentValue = this.startingBAFValue;  
        for(int i = 0; i < this.numCleans; i++){
            if(currentValue == (double) 0){
                afterCleansBAF.add(currentValue);
            } else if(currentValue-deduction <= 0){
                currentValue = 0;
                afterCleansBAF.add(currentValue);
            } else {
                currentValue -= deduction;
                afterCleansBAF.add(currentValue);                
            }
                               
        }                 
     }
    
    // return the list of financing after cleans.
    public ArrayList<Double> getAfterCleansBAF(){
        doFinancing();
        endingBAFValue = afterCleansBAF.get(afterCleansBAF.size() - 1); // this is useful to give me the end value
									// for a client's BAF after a month
        return afterCleansBAF;
    }
        
        
}
