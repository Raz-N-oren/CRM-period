// This trigger fires after Account records are updated.
trigger AccountTrigger on Account (after update) {

    // Create a Set to store Account IDs for which the Billing City has changed.
    Set<ID> accIds = new Set<ID>();

    // Loop through each updated Account record in the Trigger.New collection.
    for (Account acc : Trigger.New) {

        // Check if the Billing City of the current Account has changed compared to its previous value.
        if(acc.BillingCity != Trigger.OldMap.get(acc.Id).BillingCity){

            // If the Billing City has changed, add the Account's ID to the Set of changed Account IDs.
            accIds.add(acc.Id);
        }
    }

    // Check if there are any changed Account.
    if(accIds.size()>0){

        // Query for Contacts associated with the changed Account IDs and select relevant fields.
        List<Contact> contList = new List<Contact>([SELECT Id, MailingCity,AccountId
                                                    FROM Contact
                                                    WHERE AccountId IN: accIds]);
    
        // Loop through the retrieved Contact records.
        for (Contact con : contList) {

            // Update the Mailing City of the Contact with the Billing City from the corresponding updated Account.
            con.MailingCity = Trigger.NewMap.get(con.AccountId).BillingCity;
        }

        // Check if there are any Contact records to update.
        if(contList.size() > 0){

            // Update the Contact records with the modified Mailing City values.
            update contList;
        }
    }

}