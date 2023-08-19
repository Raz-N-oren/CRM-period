trigger AddressChangedCounterOnAccount on Account (before update) {

    for (Account newAccount : Trigger.new) {
        Account oldAccount = Trigger.oldMap.get(newAccount.Id);

        // Check if any of the address fields have changed.
        if (newAccount.BillingCountry != oldAccount.BillingCountry ||
            newAccount.BillingPostalCode != oldAccount.BillingPostalCode ||
            newAccount.BillingState != oldAccount.BillingState ||
            newAccount.BillingCity != oldAccount.BillingCity ||
            newAccount.BillingStreet != oldAccount.BillingStreet) {

            // Update the address change counter.
            newAccount.Address_Changed_Counter__c = newAccount.Address_Changed_Counter__c != null ? newAccount.Address_Changed_Counter__c + 1 : 1;
        }
    }
}