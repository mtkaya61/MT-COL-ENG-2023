@isTest
public class ContactTriggerTest {

    @testSetup
    static void dataFactory(){
        Account acc = new Account(name='testAccount');
        insert acc;
        List<Contact> conList = new List<Contact>{
            new Contact (lastName='testContact1', AccountId=acc.Id, Active__c=true),
            new Contact (lastName='testContact2', AccountId=acc.Id, Active__c=true),
            new Contact (lastName='testContact3', AccountId=acc.Id, Active__c=true)
                
        };
        insert conList;
        Account accUpdated = [SELECT Id, Active_Contacts__c FROM Account WHERE Id = :acc.Id];
        System.assertEquals(3, accUpdated.Active_Contacts__c);  //assertion for insert above

             
    }

    //test for update 
	@isTest
    static void contactDMLTest(){
        Contact con = [SELECT Id, LastName FROM Contact WHERE LastName = 'testContact1' LIMIT 1];
        con.lastName += 'Updated';
        con.Active__c = false; //make passive one of the contacts then update
        
        Test.startTest();
        update con;
        Test.stopTest();//provides different transaction with fresh dml limits..
        Account accUpdated = [SELECT Id, Active_Contacts__c FROM Account WHERE Name = 'testAccount' LIMIT 1];
        System.assertEquals(2, accUpdated.Active_Contacts__c);//active contacts are 2 in the account?
        System.assertNotEquals(3, accUpdated.Active_Contacts__c);
 
    }
    
    @isTest 
    static void testPassiveCon (){
        Account acc = new Account (Name='testAccount2');
        insert acc;
        Contact con4 = new Contact (LastName='testContact4', AccountId=acc.Id, Active__c=false); 
		insert con4;
        
        Account accUpdated = [SELECT Id, Active_Contacts__c FROM Account WHERE Name = 'testAccount2' LIMIT 1];
        System.assertEquals(0, accUpdated.Active_Contacts__c); // negative test - active>false accounts
        System.assertNotEquals(1, accUpdated.Active_Contacts__c);
        
    } 
    
    @isTest 
    static void testDelete (){
        Contact con = [SELECT Id, LastName FROM Contact WHERE LastName = 'testContact1' LIMIT 1];
        Test.startTest();
        delete con;
        
        Account accUpdated = [SELECT Id, Active_Contacts__c FROM Account WHERE Name = 'testAccount' LIMIT 1];
       
        System.assertEquals(2, accUpdated.Active_Contacts__c);
        System.assertNotEquals(3, accUpdated.Active_Contacts__c);
       	
        undelete con;
        Test.stopTest();
        Account accUpdated2 = [SELECT Id, Active_Contacts__c FROM Account WHERE Name = 'testAccount' LIMIT 1];
        System.assertEquals(3, accUpdated2.Active_Contacts__c);
        System.assertNotEquals(2, accUpdated2.Active_Contacts__c);
    }
    
}