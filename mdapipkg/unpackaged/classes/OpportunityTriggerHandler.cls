public class OpportunityTriggerHandler {
     
    public static void createTaskForClosedWonOpp(List<Opportunity> oppList, Map<Id, Opportunity> oppOldMap){
        List<Task> taskList = new List<Task>();
      
        for (Opportunity opp : oppList){
                      
            // With if statement, we make sure the stage has been updated to Closed Won. We compare with the old value.
            if(opp.StageName == 'Closed Won' && opp.StageName != oppOldMap.get(opp.Id).StageName){
                
                // Create new task instance with opp infos    
                   Task oppTask = new Task(Subject= 'Follow Up Task', 
                                           WhatId = opp.Id, 
                                           OwnerId = opp.OwnerId,
                                           ActivityDate = opp.CloseDate.addMonths(1));
                // Add task object to List and bulkify it. Thus, we don't hit the governor limits.   
                   taskList.add(oppTask);
                }
         } 
        
        if(!taskList.isEmpty()) {        
        	insert taskList;        
       }
    }
}