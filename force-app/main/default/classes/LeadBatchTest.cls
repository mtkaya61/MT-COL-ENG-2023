@isTest
public class LeadBatchTest {
	@isTest
        static void executeBatchTest(){
            Lead ld = new Lead(lastName='testLead', Company='testCompany', Status='Open - Not Contacted');
            insert ld;
            LeadBatch mybatch = new LeadBatch();
            Test.startTest();
            Database.executeBatch(mybatch);
            Test.stopTest();

            Lead ld2 = [SELECT Id, LeadSource FROM Lead WHERE Id=:ld.Id];

            System.assertEquals ('Manual', ld2.LeadSource, 'Updated LeadSource is not valid');
        }

        @isTest
        static void executeBatchNegativeTest(){
            Lead ld = new Lead(lastName='testLead', Company='testCompany', Status='Open - Not Contacted', LeadSource='Web');
            insert ld;
            LeadBatch mybatch = new LeadBatch();
            Test.startTest();
            Database.executeBatch(mybatch);
            Test.stopTest();

            Lead ld2 = [SELECT Id, LeadSource FROM Lead WHERE Id= :ld.Id];

            System.assertNotEquals ('Manual', ld2.LeadSource, 'Updated LeadSource is not valid');
        }

        @isTest
        static void scheduleBatchTest(){
            Test.startTest();

            LeadBatch myScheduledBatch = new LeadBatch ();
            String cronExp='0 0 23 * * ?';
            String JobId= System.schedule('Lead batch Test', cronExp, myScheduledBatch);

            CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime 
                            FROM CronTrigger 
                            WHERE id = :JobId];
            System.assertEquals(cronExp, ct.CronExpression);
            System.assertEquals(0, ct.TimesTriggered);
            Test.stopTest();
        }
}