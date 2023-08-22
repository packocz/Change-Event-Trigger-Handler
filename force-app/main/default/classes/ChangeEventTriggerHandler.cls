public interface ChangeEventTriggerHandler {
    void onAfterInsert(Map<Id, SObject> records);
    void onAfterUpdate(Map<Id, SObject> records);
    void onAfterDelete(Map<Id, SObject> records);
    void onAfterUndelete(Map<Id, SObject> records);
}
