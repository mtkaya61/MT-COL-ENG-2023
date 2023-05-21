public class LeadBatch implements Database.Batchable<SObject>, Schedulable{
    /**
     * Start Method
     * Executes only once
     * Return batch scope or records
     * Can return upto 50 million records
     * */
    public Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('SELECT Id, LeadSource FROM Lead WHERE leadsource = null'); //give me lead with leadsource null
    }

    /**
     * Execute Method
     * Executes for each batch/chunk of records
     * Must have void return type
     * Each execution will get new set of governor limits
     * */
    public void execute(Database.BatchableContext BC, List<Lead> scope){
        for(Lead leadRecord : scope){ //iterate records and update with manual
      		leadRecord.LeadSource = 'Manual';
        }
       
        Database.update(scope, false);//partial update is ok.
    }

    /**
     * Finish Method
     * Executes only once
     * Called after all batches are processed
     * Can be used for post processing and give information...
     * */
    public void finish(Database.BatchableContext BC){
             System.debug('Batch finished');
    }
    
    // To execute the batch class daily basis, 
    // Use Schedulable interface and you can setup period from apex class page OR from anonymous window with cron expression 
    public void execute(SchedulableContext context){
        LeadBatch myBatch = new LeadBatch();
        Database.executeBatch(myBatch, 2000);
    }

}