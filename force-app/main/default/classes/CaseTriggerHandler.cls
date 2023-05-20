public class CaseTriggerHandler {
    public static void updateCaseWithParentId(List<Case> newCases){
        Set<Id> setAccount = new Set<Id>();
        Map<Id, list<Case>> accountToCase = new Map<Id, list<Case>>();
                
        for(Case c : newCases){
            if(String.isNotBlank(c.AccountId)){
                setAccount.add(c.AccountId);}
        }
        
        List<Account> lstAccount = [SELECT Id, (SELECT Origin, ParentId, AccountId FROM Cases ORDER BY CreatedDate DESC) 
                                    FROM Account WHERE Id IN :setAccount];
        for(Account a : lstAccount){
            accountToCase.put(a.Id, a.Cases);
        }
        
        for(Case c : newCases){
            if(String.isNotBlank(c.AccountId)){
                
                for(Case oldCase : accountToCase.get(c.AccountId)){
                    if((c.Origin == oldCase.Origin)){       
                        c.ParentId = oldCase.Id;
                          
                        break;
                    }
                }
            }
        }
    }
}