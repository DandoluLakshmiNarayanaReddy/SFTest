trigger TaskTrigger on Task (before insert,after update,after insert) {

    if(Trigger.isAfter && Trigger.isUpdate)
    {
        TaskTriggerHandler.AfterInsert(Trigger.New,Trigger.oldMap);
    }
    
}