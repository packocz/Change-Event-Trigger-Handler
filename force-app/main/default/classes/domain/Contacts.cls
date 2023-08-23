public with sharing class Contacts extends fflib_SObjects {
    public Contacts(List<Contact> contacts) {
        super(contacts, Contact.getSObjectType());
    }

    public void doSomething() {
        for (Contact c : (List<Contact>) getRecords()) {
            System.debug('doing something to ' + c.LastName);
        }
    }

    public class Constructor implements fflib_IDomainConstructor {
        public fflib_SObjects construct(List<Object> objectList) {
            return new Contacts((List<SObject>) objectList);
        }
    }
}
