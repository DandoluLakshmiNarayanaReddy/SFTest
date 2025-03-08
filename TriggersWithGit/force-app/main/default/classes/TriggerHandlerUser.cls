public with sharing class TriggerHandlerUser {
    public static void BeforeUpdate(List<User> newRecords) {
        Set<Id> uIds=new Set<Id>();
        for(User u:newRecords)
        {
           uIds.add(u.Id); 
        }
        List<User> users=[SELECT Id,Name,(SELECT Id,Name FROM Contacts) FROM User WHERE Id IN:uIds];
        for(User u:users)
        {
           uIds.add(u.Id); 
        }


    }
}