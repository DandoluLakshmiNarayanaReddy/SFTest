public with sharing class TriggerHandlerOpportunityLineItem {


//     In a Cognizant interview for a Salesforce Developer (4 years experience), this trigger scenario was asked:
// 🔹 A custom field on Account, "Total_Opportunity_Products__c", should always store the count of related Opportunities' OpportunityLineItem records
// 🔹 Whenever a user creates or deletes an OpportunityLineItem, the field should update accordingly

    public static void AfterInsert(List<OpportunityLineItem> newRecords) {

        Set<Id> opIds=new Set<Id>();
        for(OpportunityLineItem opli:newRecords)
        {
            opIds.add(opli.OpportunityId);
        }
        List<Opportunity> lops=[SELECT Id,Name,AccountId,(SELECT Id, Name FROM OpportunityLineItems) FROM Opportunity WHERE Id IN:opIds];
        Set<Id> AcIds=new Set<Id>();
        Map<Id,Integer> AcIdvsOpLi=new Map<Id,Integer>();
        for(Opportunity op:lops)
        {
            AcIds.add(op.AccountId);
            Integer count1=op.OpportunityLineItems.size();
            if(AcIdvsOpLi.containsKey(op.AccountId))
            {
               
                AcIdvsOpLi.put(op.AccountId, AcIdvsOpLi.get(op.AccountId)+count1);
            }
            else {
                AcIdvsOpLi.put(op.AccountId,count1);
            }

        }

        List<Account> accs=[SELECT Id,Name,Total_Opportunity_Products__c FROM Account WHERE Id IN:AcIds];
        List<Account> accstoUpdate=new List<Account>();
        for(Account ac:accs)
        {
            if (AcIdvsOpLi.containsKey(ac.Id))
            {
                ac.Total_Opportunity_Products__c = String.valueOf(AcIdvsOpLi.get(ac.Id));
                accsToUpdate.add(ac);
            }
        }

        if(accstoUpdate.size()>0)
        {
            update accstoUpdate;
        }


    }
}