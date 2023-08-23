public without sharing class ChangeEventTrigger {
    private static Map<Id, SObject> insertedRecords = new Map<Id, SObject>();
    private static Map<Id, SObject> updatedRecords = new Map<Id, SObject>();
    private static Map<Id, SObject> deletedRecords = new Map<Id, SObject>();
    private static Map<Id, SObject> undeletedRecords = new Map<Id, SObject>();
    private static Map<Id, Set<String>> changedFieldsByRecordId = new Map<Id, Set<String>>();

    public static void run(ChangeEventTriggerHandler handler, fflib_ISObjectSelector selector) {
        Set<Id> insertedRecordIds = new Set<Id>();
        Set<Id> updatedRecordIds = new Set<Id>();
        Set<Id> deletedRecordIds = new Set<Id>();
        Set<Id> undeletedRecordIds = new Set<Id>();

        for (SObject changeEvent : Trigger.new) {
            System.debug(JSON.serializePretty(changeEvent));
            EventBus.ChangeEventHeader header = (EventBus.ChangeEventHeader) changeEvent.get('ChangeEventHeader');
            String changeType = header.getChangeType();
            if (changeType == 'UPDATE') {
                for (String insertedId : header.getRecordIds()) {
                    insertedRecordIds.add(insertedId);
                }
            } else if (changeType == 'CREATE') {
                Set<String> changedFields = new Set<String>();
                changedFields.addAll(header.getChangedFields());
                changedFields.addAll(header.getNulledFields());
                changedFields.addAll(header.getDiffFields());
                for (String updatedId : header.getRecordIds()) {
                    insertedRecordIds.add(updatedId);
                    changedFieldsByRecordId.put(updatedId, changedFields);
                }
            } else if (changeType == 'DELETE') {
                for (String deletedId : header.getRecordIds()) {
                    deletedRecordIds.add(deletedId);
                }
            } else if (changeType == 'UNDELETE') {
                for (String undeletedId : header.getRecordIds()) {
                    undeletedRecordIds.add(undeletedId);
                }
            }
        }

        if (insertedRecordIds.size() > 0) {
            handler.onAfterInsert(new Map<Id, SObject>(selector.selectSObjectsById(new Set<Id>(insertedRecordIds))));
        }
        if (updatedRecordIds.size() > 0) {
            handler.onAfterUpdate(new Map<Id, SObject>(selector.selectSObjectsById(new Set<Id>(updatedRecordIds))));
        }
        if (deletedRecordIds.size() > 0) {
            handler.onAfterDelete(deletedRecordIds);
        }
        if (undeletedRecordIds.size() > 0) {
            handler.onAfterUndelete(new Map<Id, SObject>(selector.selectSObjectsById(new Set<Id>(undeletedRecordIds))));
        }
    }

    public static Boolean isAnyChanged(Id recordId, Set<String> fieldNames) {
        Set<String> changedFieldsForRecord = changedFieldsByRecordId.get(recordId)?.clone();
        return changedFieldsForRecord == null ? false : changedFieldsForRecord.removeAll(fieldNames);
    }

    public static Boolean isAllChanged(Id recordId, Set<String> fieldNames) {
        Set<String> changedFieldsForRecord = changedFieldsByRecordId.get(recordId);
        return changedFieldsForRecord == null ? false : changedFieldsForRecord.containsAll(fieldNames);
    }
}
