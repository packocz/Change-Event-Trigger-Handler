public interface ChangeEventTriggerHandler {
    void onAfterInsert(Map<Id, SObject> records);
    void onAfterUpdate(Map<Id, SObject> records);
    void onAfterDelete(Set<Id> recordIds);
    void onAfterUndelete(Map<Id, SObject> records);
}
