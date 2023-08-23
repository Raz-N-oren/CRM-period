trigger ContactTrigger on Contact (after delete){
    Map<Id,Integer> AccountIdsMap = new Map<Id,Integer>();
    List<Account> AccList4Update = new List<Account>();

    for(Contact c : Trigger.Old){
        if(!AccountIdsMap.containsKey(c.AccountId)){
            AccountIdsMap.put(c.AccountId,1);
        }
        else{
            AccountIdsMap.put(c.AccountId,AccountIdsMap.get(c.AccountId)+1);
        }
    }

    
    for (Id accId : AccountIdsMap.keySet()) {
        Account Acc = new Account(Id = accId);
        Acc.Last_Contact_Deletion_Date__c = System.today();
        AccList4Update.add(Acc);
    }

    // List<Account>RelevantConAcc = [SELECT Id, Number_Of_Contacts_Deleted__c  FROM Account WHERE Id IN :AccountIdsMap.keySet()];

    // if(RelevantConAcc.size()>0){
    //     for(Account a : RelevantConAcc){
    //         if(a.Number_Of_Contacts_Deleted__c == null){
    //             a.Number_Of_Contacts_Deleted__c = AccountIdsMap.get(a.Id);
    //         }
    //         else{
    //             a.Number_Of_Contacts_Deleted__c += AccountIdsMap.get(a.Id);
    //         }
    //         a.Last_Contact_Deletion_Date__c = System.today();
    //         AccList4Update.add(a);
    //     }
    // }
    if(AccList4Update.size() > 0){
        update AccList4Update;
    }
}

/* 
// This trigger fires after Contact records are deleted.
trigger ContactTrigger on Contact (after delete) {

    // Set to store Account Ids affected by deleted Contacts.
    Set<Id> accountIds = new Set<Id>();

    // Iterate through the deleted Contact records to collect the related Account Ids.
    for (Contact deletedContact : Trigger.old) {
        accountIds.add(deletedContact.AccountId);
    }

    // Query for the related Account records and update the 'Num_Contacts_Deleted__c' field.
    List<Account> accountsToUpdate = [SELECT Id, Number_Of_Contacts_Deleted__c ,Last_Contact_Deletion_Date__c FROM Account WHERE Id IN :accountIds];
    
    for (Account acc : accountsToUpdate) {
        // Increase the 'Num_Contacts_Deleted__c' counter by 1 for each Account.
        acc.Number_Of_Contacts_Deleted__c = acc.Number_Of_Contacts_Deleted__c != null ? acc.Number_Of_Contacts_Deleted__c + 1 : 1;

        // Update the 'Last_Contact_Deletion_Date__c' with the current date.
        acc.Last_Contact_Deletion_Date__c = System.today();
    }

    // Update the Account records with the incremented counter values.
    update accountsToUpdate;
}

// List<Account> sortedAccounts = [SELECT Id, Name, Last_Contact_Deletion_Date__c FROM Account ORDER BY Last_Contact_Deletion_Date__c DESC];
*/

