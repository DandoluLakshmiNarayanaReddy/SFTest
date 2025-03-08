trigger OpportunityTrigger on Opportunity (before insert,after insert,before update, after update,before delete) {

    if(Trigger.isBefore)
    {
        if(Trigger.isUpdate)
        {
             // When an Opportunity’s Stage changes:
             // 🔹 If Stage = "Closed Won", update all related Tasks' Status to "Completed".
             // 🔹 If Stage = "Closed Lost", update all related Tasks' Status to "In Progress". 
            OpportunityTriggerHandler.AfterUpdate(Trigger.New, Trigger.oldMap);
        }
    }
    if(Trigger.isAfter)
    {
        if(Trigger.isUpdate)
        {
             // When an Opportunity’s Stage changes:
             // 🔹 If Stage = "Closed Won", update all related Tasks' Status to "Completed".
             // 🔹 If Stage = "Closed Lost", update all related Tasks' Status to "In Progress". 
            OpportunityTriggerHandler.AfterUpdate(Trigger.New);
            OpportunityTriggerHandler.AfterUpdatePickList(Trigger.New);
        }
    }
    if(Trigger.isBefore)
    {
        if(Trigger.isDelete)
        {
            OpportunityTriggerHandler.BeforeDelete(Trigger.Old);
        }
    }
    
}