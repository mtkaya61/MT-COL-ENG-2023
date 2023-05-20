public class LeadScheduler implements Schedulable {
    
 public void execute(SchedulableContext context){
        LeadBatch myBatch = new LeadBatch();
        Database.executeBatch(myBatch, 2000);
    }
}