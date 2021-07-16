trigger Title on Title__c (after insert) {


    if(Trigger.isInsert && Trigger.isAfter) {
       OpenMovieDatabaseWrapper.getTitleDetails(Trigger.newMap.keySet());
    }

}