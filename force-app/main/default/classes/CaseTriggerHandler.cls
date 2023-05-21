public class CaseTriggerHandler {
    public static void updateCaseWithParentId(List<Case> newCases){ //multiple case can be created
        Set<Id> setAccount = new Set<Id>(); //to store accountId's of cases 
        Map<Id, list<Case>> accountToCase = new Map<Id, list<Case>>(); //key is accountId and list will be old cases..
        //new case and old case must match in terms of account Id...  
        
        for(Case c : newCases){
            if(String.isNotBlank(c.AccountId)){
                setAccount.add(c.AccountId);} //fetch the Id of the account in which case is created
        }
        
        //and go to the accounts athen find the previously created cases and tehir origins
        List<Account> lstAccount = [SELECT Id, (SELECT Origin, ParentId, AccountId FROM Cases ORDER BY CreatedDate DESC) 
                                    FROM Account WHERE Id IN :setAccount]; //DESC gives most recent ones..
        for(Account a : lstAccount){
            accountToCase.put(a.Id, a.Cases);//fill the map with acc Id and old cases
        }
        
        for(Case c : newCases){ //cases coming with trigger (new)
            if(String.isNotBlank(c.AccountId)){ //if accountId is full, check old cases...
                
                for(Case oldCase : accountToCase.get(c.AccountId)){ //existing cases will be iterated and check origins...
                    if((c.Origin == oldCase.Origin)){      //if the origin is save in old and new one 
                        c.ParentId = oldCase.Id; //assign older one as parent case in new er 
                          
                        break;
                    }
                }//we can improve the solution by checking only open cases!
            }
        }
    }
}