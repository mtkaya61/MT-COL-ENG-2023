@isTest
public class OpportunityTriggerTest {
	@isTest
    static void createTaskforOppTest (){
        Account acc = new Account (Name='testAccount');
        insert acc;
        Opportunity opp = new Opportunity(Name='testOpp', StageName='Prospecting', CloseDate=Date.today(), AccountId=acc.Id);
        insert opp; //create opp in account..
        
        opp.StageName = 'Closed Won'; //make opp closed won
        Test.startTest();
        update opp;
        Test.stopTest(); 
        
        List<Task> oppTask = [SELECT Id, Subject, WhatId FROM Task WHERE WhatId =:opp.Id]; //check if task is created!
        System.assertEquals(1, oppTask.size());
       
    }
}