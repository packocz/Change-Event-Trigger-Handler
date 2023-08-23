public with sharing class AccountsTriggerHandler implements ChangeEventTriggerHandler {
    public void onAfterInsert(Map<Id, SObject> records) {
        ((Accounts) Application.Domain.newInstance(records.values())).doSomething();
    }
    public void onAfterUpdate(Map<Id, SObject> records) {
        ((Accounts) Application.Domain.newInstance(records.values())).doSomething();
    }
    public void onAfterDelete(Set<Id> recordIds) {
    }
    public void onAfterUndelete(Map<Id, SObject> records) {
        ((Accounts) Application.Domain.newInstance(records.values())).doSomething();
    }
}
