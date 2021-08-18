/**
 * @description       : Handler for the Standup Meeting object
 * @author            : Daniel Boice
 * @group             : 
 * @last modified on  : 08-16-2021
 * @last modified by  : Daniel Boice
 * Modifications Log
 * Ver   Date         Author         Modification
 * 1.0   08-16-2021   Daniel Boice   Initial Version
**/
public with sharing class HandlerStandupMeeting {
    // public HandlerStandupMeeting() {

    // }

    //method that is used in an after insert trigger for the standup meeting object that adds unlinked coding sessions to the earliest standup meeting added.
    public static void addStandupToUnassignedCodingSessions(List<Standup_Meeting__c> standupMeetingListAdded){

        // get unassinged coding sessions
        Coding_Session__c[] codSessList = [SELECT Id, Name, Standup_Meeting__c FROM Coding_Session__c WHERE Standup_Meeting__c = null ];
        
        //if there are unassigned coding sessions, update those with the earliest standup meeting that were inserted
        if(codSessList.size()>0){
            List<Standup_Meeting__c> standupMeetingSortedByMeetingDateList =new List <Standup_Meeting__c>();
            
            //to get the earliest standup meeting in the list.
            List<Datetime> listOfDatetimes = new List<Datetime>();
            Standup_Meeting__c stumWithEarliestDateTime ; 
            for (Standup_Meeting__c stum : standupMeetingListAdded) {
                listOfDatetimes.add(stum.Meeting_Date__c);
            }
            //sort the list of datetimes 
            listOfDatetimes.sort();
            for(Standup_Meeting__c stum: standupMeetingListAdded){
                //check if the standup meeting in the list matches the first sorted datetime
                if (stum.Meeting_Date__c ==listOfDatetimes[0]) {
                    stumWithEarliestDateTime=stum;
                }
            }


            //sorting algorithm for the standup meetings based on datetimes if want to sort the whole list, but we only need the first one... so this is not needed, but may be usefule somewhere in the future.
            /*
            try {
                for (Standup_Meeting__c stum : standupMeetingListAdded){

                    for (Integer p = standupMeetingSortedByMeetingDateList.size()-1; p >= -1; p--) {
                        if( p > 0 ){
                            Standup_Meeting__c stumToSort = standupMeetingSortedByMeetingDateList[p];
                            if ( stum.Meeting_Date__c >= stumToSort.Meeting_Date__c && !standupMeetingSortedByMeetingDateList.contains(stum) ) {
                                standupMeetingSortedByMeetingDateList.add(p,stum);
                            }
                            else if((stum.Meeting_Date__c < stumToSort.Meeting_Date__c) && !standupMeetingSortedByMeetingDateList.contains(stum)){
                                continue;
                            }
                        }
                        else if(p <= 0 && !standupMeetingSortedByMeetingDateList.contains(stum)){
                            standupMeetingSortedByMeetingDateList.add(stum);

                        }                    
                    }
                }
            }
            catch (Exception e){
                e.setMessage('error occured when sorting standup meetings list based on datetime. '+e.getMessage());
            }

            // get the first standup meeting in the sorted list, if all went well we should have at least one in our list
            Standup_Meeting__c earliestStum = (Standup_Meeting__c) standupMeetingSortedByMeetingDateList[0];
            
            System.assertEquals (listOfDatetimes[0], earliestStum.Meeting_Date__c, 'the earliest meeting dates check do not match. '+    listOfDatetimes[0].format() +' != '+ earliestStum.Meeting_Date__c.format());

            System.assertEquals(true, standupMeetingSortedByMeetingDateList.size()==standupMeetingListAdded.size(), 'Sorted standup meeting does not match the standup meeting added list. standupMeetingSortedByMeetingDateList.size()='+standupMeetingSortedByMeetingDateList.size()+ 'standupMeetingListAdded.size()'+ standupMeetingListAdded.size());

            */
            // add the earliest standup meeting to the coding sessions that don't have an assigned coding session and add those to an updatelist
            List<Coding_Session__c> codingSessionsToUpdate = new List<Coding_Session__c>();
            for(Coding_Session__c codeSess: codSessList){
                codeSess.Standup_Meeting__c= stumWithEarliestDateTime.Id;
                codingSessionsToUpdate.add(codeSess);
            }
            //now update the coding sessions with dml statment
            Boolean success = true;
            String msg = 'Able to update the coding sessions with earliest standup date.';
            try {
                update codingSessionsToUpdate;
            } 
            catch (DmlException e) {
                e.setMessage(e.getMessage()+CustomExceptions.ERROR_MESSAGE_LINKING_CODING_SESSION_WHEN_INSERTING_STANDUP);
            }
            catch (Exception e) {
                msg = e.getMessage()+ ' '+ e.getLineNumber();
            } 
        
        }

    } 
}
