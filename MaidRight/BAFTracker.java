// imported packages
import java.util.ArrayList;
import java.util.Scanner;
import java.util.Date;
import java.io.PrintWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.text.SimpleDateFormat;
import java.text.ParseException;

public class BAFTracker {
    
    public static void main(String[] args) throws FileNotFoundException, ParseException {
        
        // args[0] will be sales report
        // args[1] will be baf report   
        // make sure that the sales file is the first command line arg
        File sales = new File(args[0]);    
        File baf = new File(args[1]);
        
        // open the scanner up for reading the sales file
        Scanner in1 = new Scanner(sales);
        Scanner in2 = new Scanner(baf);
        
        // write the file contents to "output.txt"
        PrintWriter out = new PrintWriter("output.txt");

	//
        // iterate through file 1
        //

        // create an array list of each line in the sales report that is eligible for financing
        ArrayList<String[]> eligibleCleans = new ArrayList<>();
        
        // determine the index that correspends to "cleaning fees:Regular Service"
        int cleanTypeIndex = -1; // initialize with a sentinel value
        
        // determine the index that corresponds to "Customer" name
        int customerIndex = -1; // initialize with a sentinel value
        
        // determine the index that corresponds to "Amount"
        int amountIndex = -1; // initialize with a sentinel value
        
        // read in each sale as a line and add to arraylist
        while(in1.hasNextLine()){
            
            // read in the line from a file 
            String line = in1.nextLine();
            
            // get rid of the comma in a customer's name
            String line2 = line.replace(", "," ");
            
            // split the line into an array by the comma 
            String[] words = line2.split(",");
            
            // figure out the index locations only for the first line of a csv
            // i.e. using sentinel values
            if(cleanTypeIndex == -1 || customerIndex == -1 || amountIndex == -1){

                // find the array location for Product/Service
                for(int i = 0; i < words.length; i++){
                    if(words[i].equals("Product/Service")){
                        
                        cleanTypeIndex = i;
                        
                    } else if(words[i].equals("Customer")) {
                        
                        customerIndex = i;
                        
                    } else if(words[i].equals("Amount")) {
                        
                        amountIndex = i;
                    }                          
                }
            }      
                   
            
            // determine if a clean is eligible to be financed & create a list of all these eligible cleans
            if(words[cleanTypeIndex].equals("cleaning fees:Regular Service")) {
                
                // instantiate an array of size 3
                String[] sale = new String[3];
                
                // extract the 3 key elements we need for an eligible cleans
                sale[0] = words[cleanTypeIndex];
                sale[1] = words[customerIndex];
                sale[2] = words[amountIndex];
                
                // add this array to the arrayList of eligible cleans
                eligibleCleans.add(sale);
                
            }
      
        } // end of reading file 1
        
        
	//
        // iterate through file 2
        //

        // create an array list of each line in the baf details report
        ArrayList<String[]> bafReportLines = new ArrayList<>();
        
        // determine the index that corresponds to "Customer" name
        int customerIndex2 = -1; // initialize with a sentinel value
        
        // determine the index that correspends to "Status Changed"
        int statusDateIndex = -1; // initialize with a sentinel value
        
        // determine the index that corresponds to "Acq. Fee Balance"
        int balanceIndex = -1; // initialize with a sentinel value
        
        while(in2.hasNextLine()){
            
            // read in line from baf file
            String line = in2.nextLine();
            
            // replace the formatted comma in certain names to whitespace
            String line2 = line.replace(", "," ");
            
            // split the line into an array of words 
            String[] words = line2.split(",");
            
            // figure out the index locations only for the first line of a csv
            // i.e. using sentinel values
            if(customerIndex2 == -1 || statusDateIndex == -1 || balanceIndex == -1){

                // find the array location for certain keywords
                for(int i = 0; i < words.length; i++){
                    if(words[i].equals("Customer")){
                        
                        customerIndex2 = i;
                        
                    } else if(words[i].equals("Status Changed")) {
                        
                        statusDateIndex = i;
                        
                    } else if(words[i].equals("Acq. Fee Balance")) {
                        
                        balanceIndex = i;
                    }                          
                }
            }  
            
            // extract the three key items that I need from the line 
            String[] customerInfo = new String[3];
            customerInfo[0] = words[customerIndex2];
            customerInfo[1] = words[statusDateIndex];
            customerInfo[2] = words[balanceIndex];
            
            // add the key elements from this line into the bafReportLines arraylist
            bafReportLines.add(customerInfo);
              
        } // end of reading file 2

       // close out the input file scanners 
       in1.close();
       in2.close();
        
	//
        // now start to manipulate client objects
        //

        // get the unique list of customer names from a given sales month
        ArrayList<String> customerNames = new ArrayList<>();
        for(String[] i : eligibleCleans) {
            if(!customerNames.contains(i[1]))
                customerNames.add(i[1]);
        }
          
        // this arraylist will have a list of customer's with their baf Financing balance
        ArrayList<String[]> bafInfo = new ArrayList<>();
        
        // for each unique customer in customer names, lets determine if they have a
        // financing amount available
        for(String element : customerNames){
            
            // this will be the final array appended to the bafinfo array list 
            String[] currentCustomer = new String[2];
            currentCustomer[0] = element; // make the customer name the first entry
            
            
            // This arraylist will house all of the matches of the element and a given customer name.
            // if a customer appears multiple times in the baf report then each line index will be noted. 
            // We will then use this Line Index, to get the latest financing balance
            ArrayList<Integer> matchIndexes = new ArrayList<>();
            
            // iterate through the list of lines
            for(int i=0; i < bafReportLines.size();i++){
                
                // if the customer name is in the bafReportLines list add the line to the matchIndexes list.
                if(element.equals(bafReportLines.get(i)[0])) {
                    
                    // add the line index to the match list
                    matchIndexes.add(i);
                }                                
             }
            
            // if the customer only shows up once, then get his financing fee
            if(matchIndexes.size() == 1){
                
                // pull in the index of the only matched name in both lists
                int temp = matchIndexes.get(0);
                
                // use the previous index, to pull in the correct line, and then the correct baf balance.
                currentCustomer[1] = bafReportLines.get(temp)[2];
                
            } else {
                
                // set up the format for a date object
                SimpleDateFormat sdformat = new SimpleDateFormat("yyyy-MM-dd");
                
                // index of largest date I have seen so far
                int largestSoFar = -1;
                
                Date d1 = sdformat.parse("1000-00-00"); //dummy initialization
                //Date d2 = sdformat.parse("2000-00-00"); //dummy initialization will be changed in the loop
                for(int i = 0; i<matchIndexes.size();i++){
                    // get the line index from the matched list
                    int temp = matchIndexes.get(i);
                    
                    // pull in the formatted date
                    Date d2 = sdformat.parse(bafReportLines.get(temp)[1]);
                    if(d1.compareTo(d2) < 0) {
                        d1 = d2;
                        largestSoFar = i;
                    } else if(d1.compareTo(d2) > 0){
                        //do nothing
                    } else if(d1.compareTo(d2) == 0){
                        d1 = d2;
                        largestSoFar = i;
                    }                    
                    
                    // after finding the line that has the largest date, for a given customer, add it to the array[1]
                    currentCustomer[1] = bafReportLines.get(matchIndexes.get(largestSoFar))[2];                        
                }
                                
            }       
            // add the final array of length 2 that has a customer and his balance to the bafInfo list.
            bafInfo.add(currentCustomer);
                
        } // ***** Believe that this algo is good ... ******
            
        
        // create an Array List of Client objects
        ArrayList<Client> clientList = new ArrayList<>(); 
        
        // determine how many cleans a unique customer had in a given sales month from the eligible cleans list
        // create a client object with a name, number of cleans, and starting baf (not done yet)
        for(String i : customerNames) {
            
            // determine the number of cleans for a given player and store in numCleans
            int numCleans = 0;
            for(String[] j : eligibleCleans){
                if(j[1].equals(i))
                    numCleans += 1;
            }
            
            // pull in the baf balance for a given player and store in bafTemp 
            String bafTemp = "";
            for(String[] j : bafInfo){
                if(j[0].equals(i))
                    bafTemp = j[1];
                    
            }
            
            // pull in the price of the clean
            ArrayList<String> priceOfCleanTemp = new ArrayList<>();
            for(String[] j: eligibleCleans){
                if(j[1].equals(i))
                    priceOfCleanTemp.add(j[2]);
                    
            }
            String priceOfClean = priceOfCleanTemp.get(0);            
         
            // constuct a new client with a name and number of cleans
            Client tempClient = new Client(i,numCleans,bafTemp,priceOfClean);
            
            // add the client to the arraylist of Client objects
            clientList.add(tempClient);                                                     
            
        }
        
        
        // This for loop produces the final output txt file with customer name and running baf 
        for(Client i : clientList){
            // set all 
            //i.setValues(); 
           
            out.print(i.getName()); // get the name of the customer
            out.print(","); // separate name by a comma
            
            //out.println("num cleans: " + i.getCleans());
            //out.println("clean price: " + i.getPrice());
            //out.println("baf: " + i.getBAF());
            //out.println("new value: " + i.getBAFValue());
                     
            // print out each baf as a double value into the output txt and separate by comma
            ArrayList<Double> temp = i.getAfterCleansBAF(); // also initializes the start and end value for a client obj.
            
            out.print(i.getBAFStartValue()); // delete?
            out.print(","); // delete?
            out.print(i.getBAFEndValue()); // delete?
            out.print(","); // delete?
            
            // after getting the start and end value, give me a play by play update
            for(int j = 0; j<temp.size(); j++){
                // ensure that the last entry for a row does not have a floating comma
                if(j == temp.size()-1){
                    out.print(temp.get(j));                   
                
                // else print it with a comma
                } else {
                    out.print(temp.get(j));
                    out.print(",");                    
                }                

            }
           
            // create a new line for the next customer
            out.println();
        
        }
  
       // always remember to close the scanner and print writer 
       out.close();
    }
} // end of program
