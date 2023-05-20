public class AccountTriggerHandler {
    
    public static void createOppForAccount(Map<Id,Account> accNewMap){ 

    List<Opportunity> oppList = new List<Opportunity>();
    // Add an opportunity for each account if it doesn't already have one.
    // Iterate over accounts that are in this trigger but that don't have opportunities.
    // keySet() method returns a set that contains all of the keys (id) in the map. 
        
    for (Account a : [SELECT Id,Name, 
                            (SELECT Id FROM Opportunities) 
                      FROM Account
                     WHERE Id IN :accNewMap.keySet()]) {
        
             if (a.Opportunities.isEmpty()){
                             // Add a default opportunity for this account    
        oppList.add(new Opportunity(Name=a.Name + ' Opportunity',
                                   StageName='Prospecting',
                                   CloseDate=System.today().addMonths(1),	
                                   AccountId=a.Id)); 
             }                
    }
    	
    System.debug('Merge Deneme');
        if (!oppList.isEmpty()) {
            insert oppList;
        }
    }
}