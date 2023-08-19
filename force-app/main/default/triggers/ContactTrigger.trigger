// This trigger fires after Contact records are deleted.
trigger ContactTrigger on Contact (after delete) {

    // Set to store Account Ids affected by deleted Contacts.
    Set<Id> accountIds = new Set<Id>();

    // Iterate through the deleted Contact records to collect the related Account Ids.
    for (Contact deletedContact : Trigger.old) {
        accountIds.add(deletedContact.AccountId);
    }

    // Query for the related Account records and update the 'Num_Contacts_Deleted__c' field.
    List<Account> accountsToUpdate = [SELECT Id, Num_Contacts_Deleted__c FROM Account WHERE Id IN :accountIds];
    
    for (Account acc : accountsToUpdate) {
        // Increase the 'Num_Contacts_Deleted__c' counter by 1 for each Account.
        acc.Num_Contacts_Deleted__c = acc.Num_Contacts_Deleted__c != null ? acc.Num_Contacts_Deleted__c + 1 : 1;
    }

    // Update the Account records with the incremented counter values.
    update accountsToUpdate;
}
