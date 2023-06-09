public class AccountTriggerHandler {
    
    public static void createOppForAccount(Map<Id,Account> accNewMap){ //to store Id's in keyset

    List<Opportunity> oppList = new List<Opportunity>();
    // Add an opportunity for each account if it doesn't already has one.
    // Iterate over accounts that are in this trigger but that don't have opportunities.
    // keySet() method returns a set that contains all of the keys (id) in the map. 
        
    for (Account a : [SELECT Id,Name, 
                            (SELECT Id FROM Opportunities) 
                                FROM Account
                                WHERE Id IN :accNewMap.keySet()]) {
        
             if (a.Opportunities.isEmpty()){//if true, there is no opp and must create a new one 
         
                // Add a default opportunity for this account    
        oppList.add(new Opportunity(Name=a.Name + ' Opportunity',
                                   StageName='Prospecting',
                                   CloseDate=System.today().addMonths(1),	
                                   AccountId=a.Id)); 
             }                
    }//if there is no opp in account, I created a new one for each account records without opp!
    	
    System.debug('Merge Test');
        if (!oppList.isEmpty()) {
            insert oppList;
        }
    }
}