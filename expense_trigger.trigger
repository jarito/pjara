trigger expense_trigger on Expense__c (after insert, after update) {

if (trigger.isAfter && (trigger.isInsert || trigger.isUpdate)) {
	expense_Methods.afterUpsert(trigger.new);
	
}
}