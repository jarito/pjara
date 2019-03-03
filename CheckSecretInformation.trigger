trigger CheckSecretInformation on Case (after insert, before update) {

    String chilCaseSubject = 'Warning parent case may content secret info';
    
    // Step 1: add keywords to collection
    Set<String> secretKeywords = new Set<String>();
    secretKeywords.add('Credit Card');
    secretKeywords.add('Social Security');
    secretKeywords.add('SSN');
    secretKeywords.add('Passport');
    secretKeywords.add('Bodyweight');

    // Step 2: check to see if our case contains any of the secret keywords
    List<Case> caseWithSecretInfo = new List<Case>();
        for (Case myCase : Trigger.new) {
            if (myCase.Subject != chilCaseSubject) {
            for (String keyword : secretKeywords) {
                if (myCase.Description != null && myCase.Description.containsIgnoreCase(keyword)) {
                    caseWithSecretInfo.add(myCase);
                    System.debug('Case' + myCase.Id + 'include secret keyword' + keyword);
                    break;
                }
            }

        }
}
    // Step 3: If our case contains a secret keyword, create a child name
    List<Case> casesToCreate = new List<Case>();
    for(Case caseWithSecretInfo : caseWithSecretInfo) {
        Case childCase          = new Case();
        childCase.subject       = chilCaseSubject;
        childCase.ParentId      = caseWithSecretInfo.Id;
        childCase.IsEscalated   = true;
        childCase.Priority      = 'High';
        childCase.Description   = 'At least on of the following keywords were found';
        casesToCreate.add(childCase); 
        
    }

    insert casesToCreate;
}