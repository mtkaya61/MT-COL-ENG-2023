trigger OpportunityTrigger on Opportunity (after update) {
    if(Trigger.isAfter && trigger.isUpdate){
       
            OpportunityTriggerHandler.createTaskForClosedWonOpp(Trigger.new, Trigger.oldMap);
          //
      }
}