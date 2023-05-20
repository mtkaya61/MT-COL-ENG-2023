@isTest
public class SAManagerTest {
	@isTest
    static void testMethods (){
       Contact supervisor = new Contact(lastname='testSUpervisor'); 
       insert supervisor;
       SA_details__c sa = new SA_details__c (Experience__c = 3, Name__c='TestSA', Supervisor__c = supervisor.Id);
       insert sa;
       List<SA_details__c> saList = SAManager.getAllSA();
       System.assert(saList.size()>0);

       List<SA_details__c> saList2 = SAManager.searchSas('Test');
       System.assert(saList2.size()>0);
               
    }
}