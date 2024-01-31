import { LightningElement, api } from 'lwc';

export default class ProjectList extends LightningElement {
    @api projectData; // List of projects
    @api projectColumns; // Columns to display in the datatable
}
