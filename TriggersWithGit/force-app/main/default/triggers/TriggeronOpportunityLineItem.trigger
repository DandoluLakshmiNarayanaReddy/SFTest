trigger TriggeronOpportunityLineItem on OpportunityLineItem(before insert,after insert,after update) {

//     🔹 A custom field on Account, "Total_Opportunity_Products__c", should always store the count of related Opportunities' OpportunityLineItem records
// 🔹 Whenever a user creates or deletes an OpportunityLineItem, the field should update accordingly

    if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate))
    {
        TriggerHandlerOpportunityLineItem.AfterInsert(Trigger.New);
    }

}