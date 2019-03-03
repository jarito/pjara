trigger CustomTriggerHelper on APEX_customer__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {

	for (APEX_customer__c so : Trigger.new) {
		//friends remind friends to bulkify
	}

}