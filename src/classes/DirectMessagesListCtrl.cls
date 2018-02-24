/**
 * Created by Adelchi on 03/01/2018.
 */

public with sharing class DirectMessagesListCtrl {
    @AuraEnabled
    public static Map<String, String> getDirectMessages(){
        String memberIdString = userInfo.getUserId();
        List<DirectMessage> directMessageList = new List<DirectMessage>();
        List<DirectMessageMember> directMessageMemberList = new List<DirectMessageMember>();
        directMessageMemberList = [SELECT DirectMessageId FROM DirectMessageMember WHERE MemberId =: memberIdString ];
        List<Id> listId = new List<Id>();
        system.debug(directMessageMemberList);
        for(DirectMessageMember DMML : directMessageMemberList){
            listId.add(DMML.DirectMessageId);
        }

        List<DirectMessage> DMList = new List<DirectMessage>();

        for(DirectMessageMember dmm : directMessageMemberList){
            DMList.add([SELECT Subject, SystemModstamp  FROM DirectMessage WHERE Id =:dmm.DirectMessageId ORDER BY SystemModstamp  DESC]);
        }
        List<String> sbjList = new List<String>();
        for(DirectMessage dList : DMList){
            sbjList.add(dList.Subject);
        }
        Map<String, String> directMessageFeedMap = new Map<String, String>();
        for (integer i = 0; i < directMessageMemberList.size(); i++){
            datetime d = DMList[0].SystemModstamp;
            system.debug(d);
            system.debug([SELECT Body, CreatedDate  FROM  DirectMessageFeed WHERE ParentId =: directMessageMemberList[i].DirectMessageId ORDER BY CreatedDate  DESC Limit 1].CreatedDate);
            directMessageFeedMap.put(
                    sbjList[i], [SELECT Body, CreatedDate  FROM  DirectMessageFeed WHERE ParentId =: directMessageMemberList[i].DirectMessageId ORDER BY CreatedDate  DESC Limit 1].Body);
        }
        system.debug('map of messages and body>>>'+directMessageFeedMap);
        return directMessageFeedMap;
    }
}
