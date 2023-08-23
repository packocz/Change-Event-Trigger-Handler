trigger ContactAsyncTrigger on ContactChangeEvent(after insert) {
    ChangeEventTrigger.run(new ContactsTriggerHandler(), Application.Selector.newInstance(Contact.getSObjectType()));
}
