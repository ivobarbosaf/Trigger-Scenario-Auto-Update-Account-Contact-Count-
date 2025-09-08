trigger ContactTrigger on Contact (after insert, after delete, after undelete) {
    if(Trigger.isAfter){
        if(Trigger.isInsert || Trigger.isDelete || Trigger.isUndelete){
            ContactTriggerHandler.updateAccountContactCount(Trigger.new, Trigger.old);
        }
    }
}