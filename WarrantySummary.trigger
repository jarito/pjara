trigger WarrantySummary on Case (before insert) {

    for (Case myCase : Trigger.new) {
        // Set up varaibles to use in the summary field
        String purchaseDate         = myCase.Product_Purchase_Date__c.format();
        String createDate           = Datetime.now().format();  
        Integer warrantyDays        = myCase.Product_Total_Warranty_Days__c.intValue();
        Decimal warrantyPercentage  = (100 * (myCase.Product_Purchase_Date__c.daysBetween(Date.today()) / myCase.Product_Total_Warranty_Days__c)).SetScale(2);
        Boolean hasExtendedWarranty = myCase.Product_Has_Extended_Warranty__c;

        // Ppopulate summary_field
        myCase.Warranty_Summary__c  = 'Product purchased on' + purchaseDate + ''
                                    + 'and case created on' + createDate + '.\n'
                                    + 'Waranty is for' + warrantyDays + ''
                                    + 'and is' + warrantyPercentage + '% trhough warranty period.\n'
                                    + 'Extended warranty' + hasExtendedWarranty + '\n'
                                    + 'Have a nice day';

    }

}