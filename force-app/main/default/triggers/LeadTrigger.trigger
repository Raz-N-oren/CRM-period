// This trigger fires before Lead records are insert.
trigger LeadTrigger on Lead (before insert) {

    // This loop iterates through each Lead record in the Trigger.New collection, which contains the Leads being inserted.
    for (Lead l : Trigger.New) {
        
        // This condition checks if the Country field of the current Lead is either 'United States' or 'Canada'.
        if(l.Country == 'United States' || l.Country == 'Canada') {

            // If the condition is met, this line sets the Rating field of the current Lead to 'Hot'.
            l.Rating = 'Hot';
        }

        // If the number of employees is 50 or fewer, set the Company_Type__c field to 'Small'.
        if(l.NumberOfEmployees <= 50){

            // If the condition is met, this line sets the Rating field of the current Lead to 'Small'.
            l.Company_Type__c = 'Small';
        }

        // If the number of employees is between 51 and 499, set the Company_Type__c field to 'Medium'.
        else if(l.NumberOfEmployees > 51 && l.NumberOfEmployees < 500 ){

            // If the condition is met, this line sets the Rating field of the current Lead to 'Medium'.
            l.Company_Type__c = 'Medium';
        }

        // If the number of employees is 500 or more, set the Company_Type__c field to 'Enterprise'.
        else if(l.NumberOfEmployees >= 500){

            // If the condition is met, this line sets the Rating field of the current Lead to 'Enterprise'.
            l.Company_Type__c = 'Enterprise';
        }

    }
}