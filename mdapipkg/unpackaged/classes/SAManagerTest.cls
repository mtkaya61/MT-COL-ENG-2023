@isTest
public class SAManagerTest {
	@isTest
    static void testMethods (){
       List<SA_details__c> saList = SAManager.getSA();
       List<SA_details__c> saList2 = SAManager.searchSas('Rohan');
       List<SA_details__c> saList3 = SAManager.getAllSAdetails();
        
    }
}