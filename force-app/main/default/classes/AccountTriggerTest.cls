@isTest
public class AccountTriggerTest {
    @testSetup
    static void dataFactory(){
        Account acc = new Account (Name='testAccount');
        insert acc;
    }
   
	@isTest
    static void insertAccTest(){
        Account acc = [SELECT Id, Name FROM Account WHERE Name = 'testAccount'];
        List<Opportunity> opp = [SELECT Id FROM Opportunity WHERE AccountId =:acc.Id];
        System.assert(opp.size()>0, 'No opportunity found created in the Account!'); //opp must have created by trigger
    }
    
    @isTest
    static void updateAccTest(){
        Account acc = [SELECT Id, Name FROM Account WHERE Name = 'testAccount'];      
        List<Opportunity> opp = [SELECT Id FROM Opportunity WHERE AccountId =:acc.Id];
        System.assert(opp.size()>0, 'No opportunity found created in the Account!');
        delete opp; //deleted opp
        
        List<Opportunity> opp2 = [SELECT Id FROM Opportunity WHERE AccountId =:acc.Id];
        System.assert(opp2.isEmpty()); //make sure opp is deleted
        
        acc.AnnualRevenue = 150000; //then make update in acc
        Test.startTest();
        update acc;
        Test.stopTest();
        //after update new opp must be created
        List<Opportunity> opp3 = [SELECT Id FROM Opportunity WHERE AccountId =:acc.Id];
        System.assert(opp3.size()>0, 'No opportunity found created in the Account!');
        System.assertEquals(1, opp3.size());

    }
}