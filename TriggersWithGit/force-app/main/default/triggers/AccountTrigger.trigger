trigger AccountTrigger on Account (before insert,after update,before delete) {

    if(Trigger.isAfter)
    {
        if(Trigger.isUpdate)
        {
            //     On Account, there’s a checkbox field "Close_Good_Opportunities__c"
            // 🔹 When checked, all related Opportunities with a probability > 70% should be automatically closed

            // Sounds simple? But how would you handle bulk processing efficiently? 🤔

            AccountHandler.AfterUpdateCloseOpp(Trigger.New);
        }
    }
    if(Trigger.isBefore)
    {
        if(Trigger.isDelete)
        {
            AccountHandler.BeforeDeleteAddError(Trigger.oldMap);
        }
    }
}