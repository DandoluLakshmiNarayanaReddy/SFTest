trigger QuoteTrigger on Quote (before insert,after insert) {

    if(Trigger.isAfter && Trigger.isInsert)
    {
        QuoteTriggerHandler.AfterInsert(Trigger.new);
    }
}