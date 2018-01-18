/**
 * Created by Adelchi on 28/12/2017.
 */

trigger LockNotes on Note (before update, before delete) {
    if(Trigger.isDelete){
        for(Note n : Trigger.Old){
            n.addError('Record Locked! Once created, Notes cannot be Modified or Delete');
    }
        if(Trigger.isUpdate){
            for(Note n : Trigger.New){
                n.addError('Record Locked! Once created, Notes cannot be Modified or Delete');
        }
    }
}}