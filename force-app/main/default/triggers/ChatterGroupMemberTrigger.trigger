    /* Created By: Raz
     * Params: after insert, before delete
     * Description: Set to execute both after new records of CollaborationGroupMember are inserted and before existing records are deleted. 
     */
trigger ChatterGroupMemberTrigger on CollaborationGroupMember (after insert, before delete) {
    ChatterGroup_ManageGroupAssignment ManageGroupAssignment= new ChatterGroup_ManageGroupAssignment(Trigger.operationType);

}