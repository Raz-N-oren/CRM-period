import { LightningElement, api } from 'lwc';

export default class FreelancerList extends LightningElement {
    @api freelancerData; // List of freelancers
    @api freelancerColumns; // Columns to display in the datatable
}
