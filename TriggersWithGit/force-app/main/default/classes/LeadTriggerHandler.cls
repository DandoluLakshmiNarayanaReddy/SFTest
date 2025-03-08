public with sharing class LeadTriggerHandler {

    // When inserting new Leads, the system needed to 
    // identify duplicates based on the Email field. If a duplicate was found, 
    // the new Lead had to be marked as "Duplicate" and linked to the Original Lead. 
    // This should also work for Converted Leads too.

    //Note:- the oldest Lead in the system (based on the CreatedDate) should be identified as Original Lead.


   // public static void BeforeInsert(List<Lead> newrecords) {

    //    List<Lead> allleads=[Select Id,Email,CreatedDate From Lead LIMIT 50000];
    //     //Set<String> leadIds=new Set<String>();
    //     Map<String,Lead> Leadmap=new Map<String,Lead>();
    //     for(Lead l:allleads)
    //     {
    //        Leadmap.put(l.Email,l);
    //        //leadIds.add(l.Email);
    //     }
//     Map<String,Lead> newmapleads=new Map<String,Lead>();
//    List<Lead> oldestLeads = new List<Lead>();
      
//        Lead oldestLead = null;

//        // Iterate over the list of leads to find the oldest one
//        for (Lead l : allleads) {
//            if (oldestLead == null || l.CreatedDate < oldestLead.CreatedDate) {
//                oldestLead = l; // Update the oldest lead
//            }
//            oldestLeads.add(oldestLead);
//        }
//        if (oldestLead != null) {
//         newmapleads.put(oldestLead.Email, oldestLead);
//        }


        // for(Lead l:newrecords)
        // {
        //     if(Leadmap.containsKey(l.Email) && Leadmap.keySet().size()>0)
        //     {
        //        l.FirstName=l.FirstName+'Duplicate Lead';
        //       // Id Lid=Leadmap.get(l.Email).Id;
        //        //l.ParentLead__c=Leadmap.get(l.Email).Id;
        //     //    Lead parentLead = newmapleads.get(l.Email);
        //     //    if (parentLead != null) {
        //     //        l.ParentLead__c = parentLead.Id;
        //     //    }
        //     }
           
        // }
       
    //}





    public static void BeforeUpdateAssignToSalesRep(List<Lead> newRecords1) {
        //List<UserRole> userRole=[SELECT Id,NAME From UserRole WHERE Name='Eastern Sales Team'];
        // How to Auto-Assign Leads in Salesforce Using Apex Trigger! 🚀

        //  Imagine a scenario where a company wants to automatically assign leads to sales reps based on predefined criteria (like region or industry) instead of manually assigning them.

        Id userId=[SELECT Id, Name, UserRole.Name FROM User WHERE UserRole.Name = 'Eastern Sales Team'].Id;
        
        for(Lead l:newRecords1)
        {
           if(l.Industry=='Agriculture')
           {
            if(userId!=NULL)
               {
                l.OwnerId=userId;
               }
           }
        }
    }

    public static void BeforeInsertDuplicateRecords(List<Lead> newRecords2) {
        // You need to create a trigger on the **Lead** object 
        // that automatically generates **three duplicate 
        // Lead records** whenever a Lead is created.
        //  Each duplicate should have the same data but with a unique suffix
        //   added to the **Lead Name** (e.g., `John Doe - Copy1`, `John Doe - Copy2`,
        //    `John Doe - Copy3`).
        List<Lead> cLeads=new List<Lead>();

        for(lead l:newRecords2)
            if(l.FirstName!=NULL && l.LastName!=NULL)
            {
                for (Integer i = 1; i <= 3; i++) { // Start from 1 for better readability
                    Lead nLead = new Lead(
                        FirstName = l.FirstName,
                        LastName = l.LastName + ' - Copy' + i,
                        Company = l.Company,
                        Salutation = l.Salutation,
                        Status = l.Status // Ensure required field is populated
                    );
                    cLeads.add(nLead);
                }
            }
            if(cLeads.size()>0)
            {
                insert cLeads;
            }
        }

    
    
}