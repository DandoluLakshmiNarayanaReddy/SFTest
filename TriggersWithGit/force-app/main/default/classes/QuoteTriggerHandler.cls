public with sharing class QuoteTriggerHandler {

    // How do you update an Opportunity's Stage to "Closed Won" when all related Quotes have a status of "Accepted"? (Trigger Scenario)

    public static void AfterInsert(List<Quote> newRecords) {
        Set<Id> qIds=new Set<Id>();
        for(Quote q:newRecords)
        {
            qIds.add(q.OpportunityId);
        }
        List<Opportunity> lOps=[SELECT Id,Name,(SELECT Id,Name,Status FROM Quotes) FROM Opportunity WHERE Id IN:qIds];
        //Map<Id,List<Quote>> opIdvsQl=new Map<Id,List<Quote>>();
        List<Opportunity> updatedLOps=new List<Opportunity>();
        for(Opportunity opp:lOps)
        {
            Boolean flag=True;
            for(Quote q:opp.quotes)
            {
                if(q.status!='Accepted')
                {
                    flag=False;
                }
            }
            if(flag==True)
            {
                opp.StageName='Closed Won';
            }
        updatedLOps.add(opp);
        }
        update  updatedLOps;
    }
}