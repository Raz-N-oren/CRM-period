trigger LeadTrigger on Lead (before insert) {
    for (Lead l : Trigger.New) {
        
        if(l.Country == 'United States' || l.Country == 'Canada') {

            l.Rating = 'Hot';
        }

    }
}