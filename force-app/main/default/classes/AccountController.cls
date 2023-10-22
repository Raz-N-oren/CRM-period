public with sharing class AccountController {
    // public AccountController() {

    // }

    @AuraEnabled
    public static list<Contact> getAccounts(String searchNameStr, Id accId){
        try {
            String searchNameStrLike = '%' + searchNameStr + '%';
            return [SELECT AccountId, Id, FirstName, LastName
             FROM Contact
             WHERE AccountId != :accId and (FirstName like :searchNameStr 
             or LastName like :searchNameStr)];
        } 
        catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}