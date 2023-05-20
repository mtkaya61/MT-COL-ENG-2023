public with sharing class ContactTriggerHandler {
    public static void updateAccountActiveContacts(List<Contact> contactList) {
        Set<Id> accountIds = new Set<Id>(); //
        List<Account> accList = new List<Account>();
        // Consider when something happens only in Contacts having Account info 
        for (Contact con : contactList) {
            if (String.isNotBlank(con.AccountId)) {  
                accountIds.add(con.AccountId); //store the parent Id's in Set
            }
        }
        
        // Query Accounts in Set of the newly Updated Contacts
        for(Account acc:[SELECT Id, Active_Contacts__c, 
                                (SELECT Id FROM Contacts WHERE Active__c=true) 
                         FROM Account 
                         WHERE Id IN:accountIds]){
        // isEmpty() method returns true if the list has zero elements
        //if it is not empty; there are active contacts need the size then.
            if(!acc.Contacts.isEmpty()){ // acc.Contacts = List<Contact>
        		// size() method returns the number of elements in the list
                acc.Active_Contacts__c = acc.Contacts.size();
                accList.add(acc);
            }else{
        		// if there is no active contact set it to Zero
                acc.Active_Contacts__c = 0;
                accList.add(acc);
            }
        }
        // After for each loop we are updating accounts
        update accList;
    }
}