trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
    
    List<Task> OpTasklist = new List<Task>();
    
    // Iterate over opportunities that are in this trigger and have a stage of "Closed Won"
    for (Opportunity op: [SELECT id FROM Opportunity 
                          WHERE Id IN :Trigger.New AND
                          StageName =: 'Closed Won']) {
                              
                              if (((Trigger.IsUpdate) && (Trigger.oldMap.get(op.Id).StageName != 'Closed Won')) || 
                                  (Trigger.IsInsert)) {
                                      OpTaskList.add(new Task (Subject='Follow Up Test Task', 
                                                               WhatId = op.Id)); }          
                          }
    
    If (OpTaskList.size() > 0) { 
        Insert OpTaskList ;
    }   
    
}