trigger TaskTrigger on Task (before insert,after update,after insert) {

    if(Trigger.isAfter && Trigger.isUpdate)
    {
        TaskTriggerHandler.AfterUpdate(Trigger.New,Trigger.oldMap);
    }
    
}