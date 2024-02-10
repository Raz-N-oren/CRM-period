    /* Created By: Raz
     * Params: -
     * Description: intended for managing group assignments within Chatter groups,
     */
public class ChatterGroup_ManageGroupAssignment {
    
    Set<string> existingGroupName = new Set<string>();    
    set<string> groupIdAndMemberId= new Set<string>();    
    Map<string,Group> createPublicGroup = new Map<string,Group>();
    Map<string,Group> existingGroup = new Map<string,Group>();
    
    Map<string,GroupMember> GroupMemberMap = new Map<string,GroupMember>();
    set<Id> removeUsersFromGroup = new set<Id>();
    
    List<CollaborationGroupMember> ChatterGMrelatedInfo =new List<CollaborationGroupMember>();
    
    /* Created By: Raz
     * Params: System.TriggerOperation operationType
     * Description: This constructor in the ChatterGroup_ManageGroupAssignment class handles triggers for Chatter group member operations. It retrieves relevant records based on the trigger operation type, queries additional information, and then executes specific actions based on whether it's triggered after insertion or before deletion. Debugging logs are included for monitoring.
     */
    public ChatterGroup_ManageGroupAssignment(System.TriggerOperation operationType){
        try {

            list<CollaborationGroupMember> triggerRecs = string.valueOf(operationType)=='AFTER_INSERT'?(list<CollaborationGroupMember>)Trigger.New:(list<CollaborationGroupMember>)Trigger.Old;
            System.debug('triggerRecs'+triggerRecs);


            ChatterGMrelatedInfo =new List<CollaborationGroupMember>([SELECT Id, CollaborationGroupId,CollaborationGroup.Name,
                                                                  CollaborationGroup.GroupEmail, MemberId
                                                                  FROM CollaborationGroupMember
                                                                  WHERE Id IN:triggerRecs]);
            System.debug('ChatterGMrelatedInfo'+ChatterGMrelatedInfo);

            queryRelatedGroupAndGroupMembers();

            SWITCH ON operationType{
                WHEN AFTER_INSERT{
                    System.debug('Entered AFTER_INSERT');
                    createPublicGroups();
                    createPublicGroupMembers();
                    System.debug('Exited  AFTER_INSERT');
                    }
                WHEN BEFORE_DELETE{
                    System.debug('Entered AFTER_DELETE');
                    removeUserFromPublicGroup();
                    System.debug('Exited  AFTER_DELETE');
                }
            }

        } 
        catch (Exception e) {
            System.debug( 'An error occurred in ChatterGroup_ManageGroupAssignment: ' + e.getMessage());
        }
    }

    /* Created By: Raz
     * Params: -
     * Description: Query all related public groups and public group members
     */
    private void queryRelatedGroupAndGroupMembers(){
        try{

            set<string> CollaborationGroupNames = new  set<string>();

            System.debug('queryRelatedGroupAndGroupMembers ChatterGMrelatedInfo'+ChatterGMrelatedInfo);

            for(CollaborationGroupMember rec:ChatterGMrelatedInfo){
                    CollaborationGroupNames.add(rec.CollaborationGroup.Name);
            }

            List <group> queryGroupAndMembers = new List <group>([SELECT ID,Name,( SELECT Id, GroupId,Group.Name, UserOrGroupId FROM GroupMembers WHERE Group.Type='Regular') FROM GROUP WHERE Name IN: CollaborationGroupNames]);

            if(queryGroupAndMembers.size()>0){
                for(group Groprec:queryGroupAndMembers){
                    existingGroupName.add(Groprec.Name);//  for insert new public group
                    existingGroup.put(Groprec.Name,Groprec);
                    if(!Groprec.GroupMembers.isEmpty()){
                        for(GroupMember GM:Groprec.GroupMembers){
                            GroupMemberMap.put(GM.Group.Name+'-'+GM.UserOrGroupId, GM);// for removal of members
                        }
                    }
                }
            }
            System.debug('queryRelatedGroupAndGroupMembers:'+GroupMemberMap);

        }
        catch (Exception e) {
            System.debug( 'An error occurred in queryRelatedGroupAndGroupMembers: ' + e.getMessage());
        }
    }

    /* Created By: Raz
     * Params: -
     * Description: Responsible for creating new public groups based on information gathered from Chatter group members.
     */
    public void createPublicGroups(){
        try{
            for(CollaborationGroupMember rec:ChatterGMrelatedInfo){
                if(!existingGroupName.contains(rec.CollaborationGroup.Name) && createPublicGroup.get(rec.CollaborationGroup.Name)==null){
                    Group newGroup = new Group(
                        Name =rec.CollaborationGroup.Name
                    );
                    createPublicGroup.put(newGroup.name,newGroup);
                }
            }
            if(!createPublicGroup.isEmpty()){
                insert createPublicGroup.values();
                createPublicGroupMembers();
            }
        } 
        catch (Exception e) {
        System.debug( 'An error occurred in createPublicGroups: ' + e.getMessage());
        }
    }
       
    /* Created By: Raz
     * Params: -
     * Description: Responsible for creating new public groups members based on information gathered from Chatter group members.
     */
    public void createPublicGroupMembers(){
        try{

            for(CollaborationGroupMember rec:ChatterGMrelatedInfo){      
                groupMember gmrec=GroupMemberMap.get(rec.CollaborationGroup.Name+'-'+rec.MemberId);
                iD groupiD =existingGroup.get(rec.CollaborationGroup.Name)!=null?existingGroup.get(rec.CollaborationGroup.Name).iD:createPublicGroup.get(rec.CollaborationGroup.Name).Id;

            if( gmrec==null && groupiD!=null){
                    System.debug('newMmber:'+groupiD+'-'+rec.MemberId);
                    groupIdAndMemberId.add(groupiD+'-'+rec.MemberId);   
                }
                if(!groupIdAndMemberId.isEmpty())
                    createNewGroupMembers(groupIdAndMemberId);
            }
        } catch (Exception e) {
            System.debug( 'An error occurred in createPublicGroupMembers: ' + e.getMessage());
        }
    }
    
    /* Created By: Raz
     * Params: set<string> groupIdAndMemberId
     * Description: Generated to asynchronously create new group members for specified groups.
     */
    @future
    public static void createNewGroupMembers(set<string> groupIdAndMemberId){

        try{
            List<GroupMember> createPublicGroupMmebers = new List<GroupMember>();
        
            for(string groupAndMember:groupIdAndMemberId){
                List<string> groupmembersInfo=groupAndMember.split('-');
                string groupId=groupmembersInfo[0];
                string memberId=groupmembersInfo[1];
                GroupMember  newMmber = new GroupMember(
                        UserOrGroupId = memberId,
                        GroupId=groupId
                    );   
                createPublicGroupMmebers.add(newMmber);
            }
            insert createPublicGroupMmebers;

        } catch (Exception e) {
            System.debug( 'An error occurred in createNewGroupMembers: ' + e.getMessage());
        }
    }
    
    /* Created By: Raz
     * Params: set<string> groupIdAndMemberId
     * Description: Responsible for removing members frin public groups based on information gathered from trigger event.
     */
   public void removeUserFromPublicGroup(){
        try{
            System.debug('removeUserFromPublicGroup ChatterGMrelatedInfo:'+ChatterGMrelatedInfo);
        
            for(CollaborationGroupMember rec:ChatterGMrelatedInfo){
                GroupMember relatedGM = GroupMemberMap.get(rec.CollaborationGroup.Name+'-'+rec.MemberId)!=null?GroupMemberMap.get(rec.CollaborationGroup.Name+'-'+rec.MemberId):null;
                System.debug('removeUserFromPublicGroup relatedGM:'+relatedGM);
            
                if(relatedGM!=null){
                    removeUsersFromGroup.add(relatedGM.Id);
                }
            }
            if(!removeUsersFromGroup.isEmpty()){
                deleteUserFromPublicGroups(removeUsersFromGroup);
            }
        } 
        catch (Exception e) {
            System.debug( 'An error occurred in removeUserFromPublicGroup: ' + e.getMessage());
        }
    }
    
    /* Created By: Raz
     * Params: set<string> groupIdAndMemberId
     * Description: Generated to asynchronously delete  members from specified groups.
     */
    @future
    public static void deleteUserFromPublicGroups(set<Id>GroupMemberIds){
        try{
            List<GroupMember> GMtoDelete=  [SELECT Id, GroupId,Group.Name, UserOrGroupId FROM GroupMember WHERE Id IN:GroupMemberIds];
            delete GMtoDelete;
        } 
        catch (Exception e) {
            System.debug( 'An error occurred in removeUserFromPublicGroup: ' + e.getMessage());
        }
    }





}