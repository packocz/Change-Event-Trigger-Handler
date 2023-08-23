trigger AccountAsyncTrigger on AccountChangeEvent(after insert) {
    ChangeEventTrigger.run(new AccountsTriggerHandler(), Application.Selector.newInstance(Account.getSObjectType()));
}
