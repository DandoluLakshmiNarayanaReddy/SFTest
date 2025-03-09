global with sharing class UpdateContactAddInfo implements Database.Batchable<SObject> {

    global Database.QueryLocator start(Database.BatchableContext bc)
    {

        return Database.getQueryLocator('SELECT Id,Name,BillingStreet,BillingCity,BillingState,BillingPostalCode,'+
                                        '(SELECT Id,MailingStreet,MailingCity,MailingState,MailingPostalCode FROM Contacts)'+
                                        'FROM Account');
    }
    global void execute(Database.BatchableContext bc, List<Account> scope)
    {
       List<Contact> contactsToUpdated=new List<Contact>();
       Map<Id,Account> accIdVSAcc=new Map<Id,Account>();
       for(Account acc:scope)
       {
          accIdVSAcc.put(acc.Id, acc);
       }
       List<Contact> cons=[SELECT Id,Name,MailingStreet,MailingCity,MailingState,MailingPostalCode FROM Contact WHERE Id iN:accIdVSAcc.keySet()];
       for(Contact c:cons)
       {
        c.MailingCity=accIdVSAcc.get(c.AccountId).BillingCity;
        c.MailingStreet=accIdVSAcc.get(c.AccountId).BillingStreet;
        c.MailingState=accIdVSAcc.get(c.AccountId).BillingState;
        c.MailingPostalCode=accIdVSAcc.get(c.AccountId).BillingPostalCode;
        contactsToUpdated.add(c);
       }
       update contactsToUpdated;

    }
    global void finish(Database.BatchableContext bc)
    {
       
    }
}