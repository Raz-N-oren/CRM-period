// public class ChatterGroupHandler {
    
//     Set<string> existingGroupName = new Set<string>();    
//     set<string> groupIdAndMemberId= new Set<string>();    
//     Map<string,Group> createPublicGroup = new Map<string,Group>();
//     Map<string,Group> existingGroup = new Map<string,Group>();
    
//     Map<string,GroupMember> GroupMemberMap = new Map<string,GroupMember>();
//     set<Id> removeUsersFromGroup = new set<Id>();
    
    
//     List<CollaborationGroupMember> ChatterGMrelatedInfo =new List<CollaborationGroupMember>();
    
    
//     public ChatterGroupHandler(System.TriggerOperation operationType){
//         list<CollaborationGroupMember> triggerRecs = string.valueOf(operationType)=='AFTER_INSERT'?(list<CollaborationGroupMember>)trigger.New:(list<CollaborationGroupMember>)Trigger.Old;
//                         system.debug(loggingLevel.ERROR,'triggerRecs'+triggerRecs);





//        ChatterGMrelatedInfo =new List<CollaborationGroupMember>([SELECT Id, CollaborationGroupId,CollaborationGroup.Name,
//                                                                   CollaborationGroup.GroupEmail, MemberId
//                                                                   FROM CollaborationGroupMember
//                                                                   WHERE Id IN:triggerRecs]);
//                                 system.debug(loggingLevel.ERROR,'ChatterGMrelatedInfo'+ChatterGMrelatedInfo);




//        queryRelatedGroupAndGroupMembers();




//        SWITCH ON operationType{
//             WHEN AFTER_INSERT{
//                 system.debug(loggingLevel.ERROR,'Entered AFTER_INSERT');
//                 createPublicGroups();
//                 createPublicGroupMembers();
//                 system.debug(loggingLevel.ERROR,'Exited  AFTER_INSERT');
//             }
//   //        WHEN AFTER_DELETE{
//                       WHEN BEFORE_DELETE{
//                 system.debug(loggingLevel.ERROR,'Entered AFTER_DELETE');
//                 removeUserFromPublicGroup();
//                 system.debug(loggingLevel.ERROR,'Exited  AFTER_DELETE');
//             }
//         }
//     }





//     /* Created By: Raz
//      * Params: -
//      * Description: Query all related public groups and public group members
//      */
//     private void queryRelatedGroupAndGroupMembers(){
//         set<string> CollaborationGroupNames = new  set<string>();
//         for(CollaborationGroupMember rec:ChatterGMrelatedInfo){
//             CollaborationGroupNames.add(rec.CollaborationGroup.Name);
//         }
//         List <group> queryGroupAndMembers = new  List <group>([SELECT ID,Name,( SELECT Id, GroupId,Group.Name, UserOrGroupId FROM GroupMembers WHERE Group.Type='Regular') from GROUP  WHERE Name IN: CollaborationGroupNames]);

//         if(queryGroupAndMembers.size()>0){
//             for(group Groprec:queryGroupAndMembers){
//                 existingGroupName.add(Groprec.Name);//  for insert new public group
//                 existingGroup.put(Groprec.Name,Groprec);
//                 if(!Groprec.GroupMembers.isEmpty()){
//                     for(GroupMember GM:Groprec.GroupMembers){
//                         GroupMemberMap.put(GM.Group.Name+'-'+GM.UserOrGroupId, GM);// for removal of members
//                     }
//                 }
//             }
//         }
//           system.debug(loggingLevel.ERROR,'queryRelatedGroupAndGroupMembers:'+GroupMemberMap);
//     }
//     /*Created By: Raz
//     * Description:
//     */
//     public  void createPublicGroups(){
//         for(CollaborationGroupMember rec:ChatterGMrelatedInfo){
//             if( !existingGroupName.contains(rec.CollaborationGroup.Name) && createPublicGroup.get(rec.CollaborationGroup.Name)==null){
//                 Group newGroup = new Group(
//                     Name =rec.CollaborationGroup.Name
//                 );
//                 createPublicGroup.put(newGroup.name,newGroup);
//             }
//         }
//         if(!createPublicGroup.isEmpty()){
//             insert createPublicGroup.values();
//             createPublicGroupMembers();
//         }
//     }
       
        
        
//       /*Created By: Raz
//     * Description:
//     */
//     public  void createPublicGroupMembers(){
//         for(CollaborationGroupMember rec:ChatterGMrelatedInfo){      
//             groupMember gmrec=GroupMemberMap.get(rec.CollaborationGroup.Name+'-'+rec.MemberId);
//             iD groupiD = gmrec!=NULL?gmrec.GroupId:existingGroup.get(rec.CollaborationGroup.Name)!=NULL?existingGroup.get(rec.CollaborationGroup.Name).iD:NULL;




//            if( gmrec==null && groupiD!=null){
//                 system.debug(loggingLevel.ERROR,'newMmber:'+groupiD+'-'+rec.MemberId);
//                 groupIdAndMemberId.add(groupiD+'-'+rec.MemberId);   
//             }
//             if(!groupIdAndMemberId.isEmpty())
//                 createNewGroupMembers(groupIdAndMemberId);
//         }
//     }
    
//     @future
//     public static void createNewGroupMembers(set<string> groupIdAndMemberId){
//         List<GroupMember> createPublicGroupMmebers = new List<GroupMember>();
        
//         for(string groupAndMember:groupIdAndMemberId){
//             List<string> groupmembersInfo=groupAndMember.split('-');
//             string groupId=groupmembersInfo[0];
//             string memberId=groupmembersInfo[1];
//              GroupMember  newMmber = new GroupMember(
//                     UserOrGroupId = memberId,
//                     GroupId=groupId
//                 );   
//             createPublicGroupMmebers.add(newMmber);
//         }
//         insert createPublicGroupMmebers;
//     }
    
//     /*Created By: Raz
//     * Description:
//     */




//    public  void removeUserFromPublicGroup(){
//         system.debug(loggingLevel.ERROR,'removeUserFromPublicGroup ChatterGMrelatedInfo:'+ChatterGMrelatedInfo);
        
//         for(CollaborationGroupMember rec:ChatterGMrelatedInfo){
//             GroupMember relatedGM = GroupMemberMap.get(rec.CollaborationGroup.Name+'-'+rec.MemberId)!=null?GroupMemberMap.get(rec.CollaborationGroup.Name+'-'+rec.MemberId):null;
//             system.debug(loggingLevel.ERROR,'removeUserFromPublicGroup relatedGM:'+relatedGM);
            
//             if(relatedGM!=null){
//                 removeUsersFromGroup.add(relatedGM.Id);
//             }
//         }
//         if(!removeUsersFromGroup.isEmpty())
//             deleteUserFromPublicGroups(removeUsersFromGroup);
//     }
    
//       @future
//     public static void deleteUserFromPublicGroups(set<Id>GroupMemberIds){
//         List<GroupMember> GMtoDelete=  [SELECT Id, GroupId,Group.Name, UserOrGroupId FROM GroupMember WHERE Id IN:GroupMemberIds];
//         delete GMtoDelete;
//     }





// }