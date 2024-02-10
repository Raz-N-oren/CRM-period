// public class ChatterGroup_UpdateGroupAssignment {
//     Set<string> existingGroupName = new Set<string>();
//     Map<string,GroupMember> GroupMemberMap = new Map<string,GroupMember>();
//     List<GroupMember> removeUsersFromGroup = new List<GroupMember>();
//     List<CollaborationGroupMember> ChatterGMrelatedInfo =new List<CollaborationGroupMember>([SELECT Id, CollaborationGroupId,CollaborationGroup.Name, MemberId 
//                                                                                              FROM CollaborationGroupMember
//                                                                                              WHERE Id IN:(list<CollaborationGroupMember>)trigger.New]);
    
//     public ChatterGroup_UpdateGroupAssignment(System.TriggerOperation operationType){
//         queryRelatedGroupAndGroupMembers();
//         SWITCH ON operationType{
//             WHEN AFTER_INSERT{
                
//             }
//             WHEN AFTER_DELETE{
//                 removeUserFromGroup();
//             }
//         }
//     }
    
//     //get all existing Groups 
//     private void queryRelatedGroupAndGroupMembers(){
//         List<GroupMember> queryGroupMemberList = new List<GroupMember>([SELECT Id, GroupId,Group.Name, UserOrGroupId FROM GroupMember WHERE Group.Type='Group']);
//         if(queryGroupMemberList.size()>0){
//             for(GroupMember GM:queryGroupMemberList){
//                 existingGroupName.add(GM.Group.Name);
//                 GroupMemberMap.put(GM.Group.Name+'-'+GM.UserOrGroupId, GM);
//             }
//         }
//     }
    
//     private void removeUserFromGroup(){
//         for(CollaborationGroupMember rec:ChatterGMrelatedInfo){
//             GroupMember relatedGM = GroupMemberMap.get(rec.CollaborationGroup.Name+'-'+rec.MemberId)!=null?GroupMemberMap.get(rec.CollaborationGroup.Name+'-'+rec.MemberId):null;
//             if(relatedGM!=null){
//                 removeUsersFromGroup.add(relatedGM);
//             }
//         }
//     }
// }