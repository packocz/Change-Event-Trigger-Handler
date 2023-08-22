trigger AccountAsyncTrigger on AccountChangeEvent(after insert) {
    Set<Id> recordIds = new Set<Id>();
    for (AccountChangeEvent changeEvent : Trigger.new) {
        System.debug(changeEvent.Id);
        System.debug(changeEvent.Name);
        System.debug(changeEvent.Description);
        System.debug(JSON.serializePretty(changeEvent));
        EventBus.ChangeEventHeader header = changeEvent.ChangeEventHeader;
        System.debug('ChangeEvent: ' + header.getChangeType());
        for (Id recordId : header.getRecordIds()) {
            System.debug('RecordId: ' + recordId);
            recordIds.add(recordId);
        }
    }

}
