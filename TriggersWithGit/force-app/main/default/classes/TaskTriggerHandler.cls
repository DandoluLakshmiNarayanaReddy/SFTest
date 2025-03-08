public with sharing class TaskTriggerHandler {

    public static Boolean isTaskTriggerExecuted = false;

    
    // When all Tasks associated with an Opportunity are marked as ‘Completed’ 
    //and there are no Tasks in other statuses like ‘In Progress,’ ‘Not Started,’, ‘Deferred,’ or 'Waiting on someone else' the 
    // Opportunity Stage should automatically update to ‘Closed Won.’
    public static void AfterInsert(List<Task> newRecords, Map<Id,Task> oldMap) {

        if (isTaskTriggerExecuted) {
            return; // Exit the method to prevent recursion
        }
        
        Set<Id> OpIds=new Set<Id>();
       
        for(Task t:newRecords)
        {
            if(t.Status == 'Completed'){
                if(t.WhatId.getSObjectType() == Opportunity.SObjectType){
                    OpIds.add(t.WhatId);
                }
            }
        }
        List<Opportunity> lops=[SELECT Id,Name,StageName,(SELECT Id,Status,WhatId FROM Tasks) FROM Opportunity WHERE Id IN:OpIds];
        List<Task> tsks=[Select Id,Status,WhatId FROM Task WHERE WhatId IN:OpIds];
        Map<Id,List<String>> IdvsTasks=new Map<Id,List<String>>();
        for(Task t:tsks)
        {
             if(!IdvsTasks.containsKey(t.WhatId))
             {
              
                IdvsTasks.put(t.WhatId,new List<String>{t.status});
             }
             IdvsTasks.get(t.WhatId).add(t.Status);   
        }
     
        List<Opportunity> lopsToUpdate=new List<Opportunity>();
        for(Opportunity op:lops)
        {
            boolean allCompleted = false;
            if(!IdvsTasks.get(op.Id).Contains('Completed')){
                allCompleted = false;
            }else if(!IdvsTasks.get(op.Id).Contains('In Progress') && !IdvsTasks.get(op.Id).Contains('Waiting on someone else') && !IdvsTasks.get(op.Id).Contains('Not Started') && !IdvsTasks.get(op.Id).Contains('Deferred')){
                allCompleted = true;
            }
            if (allCompleted == true){
                op.StageName = 'Closed Won';       
            }
            lopsToUpdate.add(op);       
        }
        if(lopsToUpdate.size()>0)
        {
            update lopsToUpdate;
        }
       
    }
}