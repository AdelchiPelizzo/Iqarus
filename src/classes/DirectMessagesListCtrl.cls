/**
 * Created by Adelchi on 03/01/2018.
 */

/*public with sharing class DirectMessagesListCtrl {
    @AuraEnabled
    public static List<DirectMessageFeed> getDirectMessages(){
        String memberIdString = userInfo.getUserId();
        List<DirectMessage> directMessageList = new List<DirectMessage>();

        List<DirectMessageMember> directMessageMemberList = new List<DirectMessageMember>();
        directMessageMemberList = [SELECT DirectMessageId FROM DirectMessageMember WHERE MemberId =: memberIdString];


        List<DirectMessageFeed> directMessageFeedList = new List<DirectMessageFeed>();

        for(DirectMessageMember DMM : directMessageMemberList){
            directMessageFeedList.add(
            [SELECT Body FROM  DirectMessageFeed WHERE ParentId =: DMM.DirectMessageId ]
            );
        }
        system.debug(directMessageFeedList);
        return directMessageFeedList;
    }
}*/




public with sharing class DirectMessagesListCtrl {
    @AuraEnabled
    public static Map<String, String> getDirectMessages(){

        String memberIdString = userInfo.getUserId();

        List<DirectMessage> directMessageList = new List<DirectMessage>();


        List<DirectMessageMember> directMessageMemberList = new List<DirectMessageMember>();
        directMessageMemberList = [SELECT DirectMessageId FROM DirectMessageMember WHERE MemberId =: memberIdString];
        List<Id> listId = new List<Id>();
        for(DirectMessageMember DMML : directMessageMemberList){
            listId.add(DMML.DirectMessageId);
        }

        List<DirectMessage> DMList = [SELECT Subject FROM DirectMessage WHERE Id IN :listId];
        List<String> sbjList = new List<String>();
        for(DirectMessage dList : DMList){
            sbjList.add(dList.Subject);
        }
        Map<String, String> directMessageFeedMap = new Map<String, String>();



        for (integer i = 0; i < directMessageMemberList.size(); i++){
            directMessageFeedMap.put(
                    sbjList[i], [SELECT Body FROM  DirectMessageFeed WHERE ParentId =: directMessageMemberList[i].DirectMessageId Limit 1].Body);

        }


/*
        for(DirectMessageMember DMM : directMessageMemberList){
            system.debug('start inside for loop!!');
            for (integer i = 0; i < directMessageList.size(); i++){

            }DirectMessage  DML : directMessageList){
                system.debug('start inside for second loop!!');
                system.debug('DML.Subject>>>'+DML.Subject);
                system.debug('DML.Body>>>'+[SELECT Body FROM  DirectMessageFeed WHERE ParentId =: DMM.DirectMessageId LIMIT 1].Body);
                directMessageFeedMap.put(DML.Subject, [SELECT Body FROM  DirectMessageFeed WHERE ParentId =: DMM.DirectMessageId LIMIT 1].Body);
            }
        }*/
        system.debug('map of messages and body>>>'+directMessageFeedMap);
        return directMessageFeedMap;
    }
}
