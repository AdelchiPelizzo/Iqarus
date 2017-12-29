/**
 * Created by Adelchi on 28/12/2017.
 */

trigger LockNotes on Note (before update) {
    for(Note n : Trigger.New){
        n.addError('Record Locked! Once created, Notes cannot be Modified');
    }
}