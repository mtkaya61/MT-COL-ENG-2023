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
        System.assert(opp.size()>0, 'Account için oluşturulmuş bir Opportunity bulunamadı!');
    }
    
    @isTest
    static void updateAccTest(){
        Account acc = [SELECT Id, Name FROM Account WHERE Name = 'testAccount'];      
        List<Opportunity> opp = [SELECT Id FROM Opportunity WHERE AccountId =:acc.Id];
        System.assert(opp.size()>0, 'Account için oluşturulmuş bir Opportunity bulunamadı!');
        delete opp;
        
        List<Opportunity> opp2 = [SELECT Id FROM Opportunity WHERE AccountId =:acc.Id];
        System.assert(opp2.isEmpty());
        
        acc.AnnualRevenue = 150000;
        Test.startTest();
        update acc;
        Test.stopTest();
        
        List<Opportunity> opp3 = [SELECT Id FROM Opportunity WHERE AccountId =:acc.Id];
        System.assert(opp3.size()>0, 'Account için oluşturulmuş bir Opportunity bulunamadı!');
        System.assertEquals(1, opp3.size());

    }
}