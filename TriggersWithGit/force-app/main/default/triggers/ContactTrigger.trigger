trigger ContactTrigger on Contact (before insert,after insert,after update) {

        
    if(Trigger.isBefore && Trigger.isInsert)
    {
        ContactTriggerhandlerclass.AfterInsert(Trigger.New);
    }
    if(Trigger.isAfter && Trigger.isUpdate)
    {
        ContactTriggerhandlerclass.AfterUpdate(Trigger.New);
    }
}