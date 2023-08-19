trigger AccountTrigger on Account (after update) {

    Set<ID> accIds = new Set<ID>();

    for (Account acc : Trigger.New) {

        if(acc.BillingCity != Trigger.OldMap.get(acc.Id).BillingCity){
            accIds.add(acc.Id);
        }
    }

    if(accIds.size()>0){
        List<Contact> contList = new List<Contact>([SELECT Id, MailingCity,AccountId
                                                    FROM Contact
                                                    WHERE AccountId IN: accIds]);
    
        for (Contact con : contList) {
            con.MailingCity = Trigger.NewMap.get(con.AccountId).BillingCity;
        }

        if(contList.size() > 0){
            update contList;
        }
    }

}