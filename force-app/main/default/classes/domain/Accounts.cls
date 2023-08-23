public with sharing class Accounts extends fflib_SObjects {
    public Accounts(List<Account> accounts) {
        super(accounts, Account.getSObjectType());
    }

    public void doSomething() {
        for (Account a : (List<Account>) getRecords()) {
            System.debug('doing something to ' + a.Name);
        }
    }

    public class Constructor implements fflib_IDomainConstructor {
        public fflib_SObjects construct(List<Object> objectList) {
            return new Accounts((List<SObject>) objectList);
        }
    }
}
