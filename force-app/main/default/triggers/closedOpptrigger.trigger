trigger closedOpptrigger on Opportunity (after insert, after update) {
    
    List<Task> taskList = new List<task>();
    
    if(trigger.isInsert && trigger.isafter){
    for (Opportunity opp : Trigger.new){
            if(opp.StageName == 'Closed Won'){
                taskList.add(new Task(Subject= 'Follow Up Task', WhatId = opp.Id));
            }
         } 
      }

    if(trigger.isUpdate && trigger.isafter){
    for (Opportunity opp : Trigger.new){
            if(opp.StageName == 'Closed Won'){
                taskList.add(new Task(Subject= 'Follow Up Task', WhatId = opp.Id));
            }
        } 
    }

    if(taskList.size()>0) {        
        insert taskList;        
       }
}