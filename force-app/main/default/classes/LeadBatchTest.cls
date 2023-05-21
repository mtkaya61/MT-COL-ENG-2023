@isTest
public class LeadBatchTest {
	@isTest
        static void executeBatchTest(){
            Lead ld = new Lead(lastName='testLead', Company='testCompany', Status='Open - Not Contacted');
            insert ld; //leadsource is null
            LeadBatch mybatch = new LeadBatch();
            Test.startTest();
            Database.executeBatch(mybatch);
            Test.stopTest();

            Lead ld2 = [SELECT Id, LeadSource FROM Lead WHERE Id=:ld.Id];

            System.assertEquals ('Manual', ld2.LeadSource, 'Updated LeadSource is not valid');
        }//positive test

        @isTest
        static void executeBatchNegativeTest(){
            Lead ld = new Lead(lastName='testLead', Company='testCompany', Status='Open - Not Contacted', LeadSource='Web');
            insert ld; //leadsource is not null
            LeadBatch mybatch = new LeadBatch();
            Test.startTest();
            Database.executeBatch(mybatch);
            Test.stopTest();

            Lead ld2 = [SELECT Id, LeadSource FROM Lead WHERE Id= :ld.Id];

            System.assertNotEquals ('Manual', ld2.LeadSource, 'Updated LeadSource is not valid');
        }//negative test

        @isTest
        static void scheduleBatchTest(){
            Test.startTest();

            LeadBatch myScheduledBatch = new LeadBatch ();
            String cronExp='0 0 23 * * ? 2023'; //define as every day and every month
            String JobId= System.schedule('Lead batch Test', cronExp, myScheduledBatch); //give a name to the job
            //after planning, it will give me a jobId 

            CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime 
                            FROM CronTrigger 
                            WHERE id = :JobId]; //call the job from CronTrigger object
            System.assertEquals(cronExp, ct.CronExpression);
            System.assertEquals(0, ct.TimesTriggered);
            Test.stopTest();
        }
}