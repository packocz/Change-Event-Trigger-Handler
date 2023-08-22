public without sharing class ChangeEventTrigger {
    private static Map<Id, SObject> insertedRecords = new Map<Id, SObject>();
    private static Map<Id, SObject> updatedRecords = new Map<Id, SObject>();
    private static Map<Id, SObject> deletedRecords = new Map<Id, SObject>();
    private static Map<Id, SObject> undeletedRecords = new Map<Id, SObject>();
    private static Map<Id, Set<String>> changedFields = new Map<Id, Set<String>>();

    public static void run(ChangeEventTriggerHandler handler) {
        Set<Id> insertedRecordIds = new Set<Id>();
        Set<Id> updatedRecordIds = new Set<Id>();
        Set<Id> undeletedRecordIds = new Set<Id>();

        for (SObject changeEvent : Trigger.new) {
            EventBus.ChangeEventHeader header = changeEvent.get('ChangeEventHeader');
            String changeType = header.getChangeType();
            if (changeType == 'UPDATE') {
                updatedRecordIds.addAll(header.getRecordIds());
            } else if (changeType == 'CREATE') {
                insertedRecordIds.addAll(header.getRecordIds());
            } else if (changeType == 'DELETE') {
                //
            } else if (changeType == 'UNDELETE') {
                undeletedRecordIds.addAll(header.getRecordIds());
            }
        }
    }

    public static Boolean isAnyChanged(Id recordId, Set<SObjectField> fields) {
        return true;
    }

    public static Boolean isAnyChanged(Id recordId, Set<String> fieldNames) {
        return true;
    }

    private static fflib_SObjectDomain handlerInstange(Type handlerType, List<SObject> records) {
        String constructorTypeName = String.valueOf(handlerType) + '.Constructor';
        Object constructorObject = Type.forName(constructorTypeName).newInstance();
        return ((fflib_SObjectDomain.IConstructable) constructorObject).construct(records);
    }
    // Set<Id> recordIds = new Set<Id>();
    // for (ADvendio__Campaign_Item__ChangeEvent changeEvent : Trigger.new) {
    //     EventBus.ChangeEventHeader header = changeEvent.ChangeEventHeader;
    //     for (Id recordId : header.getRecordIds()) {
    //         recordIds.add(recordId);
    //     }
    // }
    // Map<Id, ADvendio__Campaign_Item__c> campaignItems = new Map<Id, ADvendio__Campaign_Item__c>(
    //     CampaignItemSelector.newInstance().selectById(recordIds)
    // );
    // Map<Id, ADvendio__Campaign_Item__c> existingCampaignItems = new Map<Id, ADvendio__Campaign_Item__c>();
    // for (ADvendio__Campaign_Item__ChangeEvent changeEvent : Trigger.new) {
    //     EventBus.ChangeEventHeader header = changeEvent.ChangeEventHeader;
    //     if (header.getChangeType() == 'UPDATE') {
    //         // do something
    //         for (Id recordId : header.getRecordIds()) {
    //             sfab_FabricatedSObject existingCampaignItem = new sfab_FabricatedSObject(ADvendio__Campaign_Item__c.class);
    //             existingCampaignItem.set(campaignItems.get(recordId).getPopulatedFieldsAsMap());
    //             System.debug('updated: ' + recordId);
    //             for (String changedField : header.getChangedFields()) {
    //                 System.debug('updated field: ' + changedField);
    //                 existingCampaignItem.set(changedField, changeEvent.get(changedField));
    //             }
    //             existingCampaignItems.put(recordId, (ADvendio__Campaign_Item__c) existingCampaignItem.toSObject());
    //         }
    //     }
    // }

    // for (ADvendio__Campaign_Item__c item : campaignItems.values()) {
    //     ADvendio__Campaign_Item__c existingCampaignItem = existingCampaignItems.get(item.Id);
    //     System.debug('item: ' + item);
    //     System.debug('previous item: ' + existingCampaignItem);
    // }

    // CampaignItemsAsyncTriggerHandler triggerHandler = (CampaignItemsAsyncTriggerHandler) ClassFactory.newSObjectDomainInstance(
    //     CampaignItemsAsyncTriggerHandler.class,
    //     campaignItems.values()
    // );
    // for (ADvendio__Campaign_Item__ChangeEvent changeEvent : Trigger.new) {
    //     EventBus.ChangeEventHeader header = changeEvent.ChangeEventHeader;
    //     String changeType = header.getChangeType();
    //     if (changeType == 'UPDATE') {
    //         triggerHandler.onAfterUpdate(existingCampaignItems);
    //     } else if (changeType == 'CREATE') {
    //         triggerHandler.onAfterInsert();
    //     }
    // }
}
