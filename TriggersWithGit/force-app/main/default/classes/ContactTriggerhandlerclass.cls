public with sharing class ContactTriggerhandlerclass {

    //Whenever a Contact record is created, copy BillingAddress of Account to MailingAddress on Contact

    public static void AfterInsert(List<Contact> newRecords) {


      List<Id> AccIds=new List<Id>();
      List<Contact> cons=new List<Contact>();
      for(Contact c:newRecords)
      {
        AccIds.add(c.AccountId);
        cons.add(c);
      }
      Map<Id,Account> MapAccount=new Map<Id,Account>([SELECT ID,Name,BillingCity,BillingCountry FROM Account WHERE Id IN:AccIds]);
      List<Contact> consToUpdate=new List<Contact>();
      for(Contact c:cons)
      {
        Account acc=MapAccount.get(c.AccountId);
        c.MailingCity=acc.BillingCity;
        c.MailingCountry=acc.BillingCountry;
        
      }
     
    }
   // If the contact's email address gets updated then the email address of the related account should also get updated.

    public static void AfterUpdate(List<Contact> newRecords){

        Set<Id> AIds=new Set<Id>();
        Map<Id,String> IdvsEmail=new Map<Id,String>();
        for(Contact c:newRecords)
        {
           AIds.add(c.AccountId);
           IdvsEmail.put(c.AccountId,c.Email);
        }
        List<Account> accs=[SELECT Id,Name,Email__c FROM Account WHERE Id IN:AIds];
        List<Account> UpdatedAccounts=new List<Account>();
        for(Account acc : accs)
        {
            acc.Email__c=IdvsEmail.get(acc.Id);
            UpdatedAccounts.add(acc);
        }
        update UpdatedAccounts;

    }
}