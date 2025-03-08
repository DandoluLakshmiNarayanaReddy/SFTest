trigger LeadTrigger on Lead (before insert,before Update) {

    if(Trigger.isUpdate)
    {
        if(Trigger.isBefore)
        {
          // How to Auto-Assign Leads in Salesforce Using Apex Trigger! 🚀

        //  Imagine a scenario where a company wants to automatically assign leads to sales reps based on predefined criteria (like region or industry) instead of manually assigning them.

            LeadTriggerHandler.BeforeUpdateAssignToSalesRep(Trigger.New);
        }
    }

    if(Trigger.isInsert)
    {
        if(Trigger.isAfter)
        {

             // When inserting new Leads, the system needed to 
           // identify duplicates based on the Email field. If a duplicate was found, 
           // the new Lead had to be marked as "Duplicate" and linked to the Original Lead. 
           // This should also work for Converted Leads too.
            // LeadTriggerHandler.BeforeInsert(Trigger.New);


             // You need to create a trigger on the **Lead** object 
        // that automatically generates **three duplicate 
        // Lead records** whenever a Lead is created.
        //  Each duplicate should have the same data but with a unique suffix
        //   added to the **Lead Name** (e.g., `John Doe - Copy1`, `John Doe - Copy2`,
        //    `John Doe - Copy3`).
            LeadTriggerHandler.BeforeInsertDuplicateRecords(Trigger.New);
        }
    }

}