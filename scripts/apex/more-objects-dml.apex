Account acc = new Account(Name = 'Some Account');
insert acc;
Contact con = new Contact(LastName = 'Some Contact', AccountId = acc.Id);
insert con;
