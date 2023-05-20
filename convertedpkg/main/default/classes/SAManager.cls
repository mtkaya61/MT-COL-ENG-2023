public with sharing class SAManager {
    
    @AuraEnabled(cacheable=true scope='global')
    public static List<SA_details__c> getAllSA(){

        return [SELECT Id, Name, Experience__c,Name__c,Customer_handled__c,Date_of_Joining__c,Specilization__c,Location__Latitude__s, Location__Longitude__s FROM SA_details__c ORDER BY Name__c LIMIT 50];
        
    }
	
	@AuraEnabled(cacheable=true scope='global')
    public static List<SA_details__c> searchSas(String searchTerm) {
        
        searchTerm = searchTerm.trim();
        if (searchTerm == '') {
            return getAllSA();
        }
        
        searchTerm = '%' + searchTerm + '%';
        
        return [
            SELECT
                Id,
                Name,
                Experience__c,
                Name__c,
                Customer_handled__c,
                Date_of_Joining__c,
                Location__Latitude__s,
                Location__Longitude__s,
                Specilization__c
            FROM SA_details__c
            WHERE Name__c LIKE :searchTerm
            WITH SECURITY_ENFORCED
            ORDER BY Name__c
            LIMIT 50
        ];
    }
}