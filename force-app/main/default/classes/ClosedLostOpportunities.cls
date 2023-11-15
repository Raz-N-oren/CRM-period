public class ClosedLostOpportunities {
    @InvocableMethod(
    Label='	Closed Lost Opportunities '
    Description='Class will close lost all opportunities related to account IDs'
    Category='Account')
    public static void CloseLostOpportunities(List<String> accountIDs){
        List<Opportunity> oppList;
        //get opportunities need to be closed//
        oppList = [select Id, StageName, CloseDate, Closed_Reason__c from Opportunity Where AccountId IN: accountIDs AND IsClosed = False ];
        if (!oppList.isEmpty()){
             //update the fields in the relevant opportunities//
             for (Opportunity o: oppList){
                 o.CloseDate = system.today();
                 o.Closed_Reason__c = 'No Credit';
                 o.StageName = 'Closed Lost';
                 //  oppIDs.add(o.Id);
             }
             update oppList;
     }
     //return IDs of opportunities that were udpated//
    //  return oppIDs;
    }
}