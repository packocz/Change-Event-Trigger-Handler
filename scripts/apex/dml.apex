//insert 2 new accounts >> 2 x Create with 1 Id each
// insert new List<Account>{
//     new Account(Name = 'CustomTrue', CustomTextField__c = 'Test'),
//     new Account(Name = 'CustomFalse', CustomTextField__c = 'Test')
// };

//epmpty update >> can be 1x UPDATE with 2 Ids
//List<Account> accounts = [SELECT Id, Name FROM Account WHERE Name LIKE 'Test Account%'];
//update accounts;

//non-epmpty update >> can be 1x UPDATE with 2 Ids
//List<Account> accounts = [SELECT Id, Name FROM Account WHERE Name LIKE 'Test Account%' AND CustomTextField__c = NULL];
//accounts[0].CustomTextField__c = 'Text';
//update accounts;

//upsert will be 1 event with 1 Create and 1 Update (or more)
//List<Account> accounts = [SELECT Id, Name FROM Account WHERE Name LIKE 'Test Account%'];
//accounts.add(new Account(Name = 'Test Account 3'));
//upsert accounts;

//nulling values
// List<Account> accounts = [SELECT Id, Name, CustomTextField__c FROM Account WHERE CustomTextField__c != NULL];
// accounts[0].CustomTextField__c = null;
// update accounts;

//deletion
//List<Account> accounts = [SELECT Id, Name, CustomTextField__c FROM Account WHERE CustomTextField__c = 'Test'];
//delete accounts;
