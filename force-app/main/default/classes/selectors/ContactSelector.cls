public with sharing class ContactSelector extends fflib_SObjectSelector {
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField>{ Contact.Id, Contact.FirstName, Contact.LastName };
    }

    public Schema.SObjectType getSObjectType() {
        return Contact.SObjectType;
    }

    public List<Contact> selectById(Set<Id> idSet) {
        return (List<Contact>) selectSObjectsById(idSet);
    }
}
