/**
 * @description       : 
 * @author            : Daniel Boice
 * @group             : 
 * @last modified on  : 08-14-2021
 * @last modified by  : Daniel Boice
 * Modifications Log
 * Ver   Date         Author         Modification
 * 1.0   08-14-2021   Daniel Boice   Initial Version
**/
@isTest(seeAllData=false)
public with sharing class TestVerifyDate {
   
    //method to test Positive the CheckDates method in the VerifyDate class to get number of days to the end of the month
    @isTest
    public static void tP_CheckDates(){
        // create two dates that are less than 30 days apart
        Date date1 =  Date.newInstance(2021, 7, 1);
      
        Date date2 = date1+5;
        // test the CheckDates method if date 2 withing 30 days return date 2, otherwise return the end of the month
        //should return date2
        Date testDate = VerifyDate.CheckDates(date1, date2);
        System.assertEquals(date2, testDate,'the date returned was not as expected');

    }
    @isTest
    public static void tN_CheckDates(){
        // create two dates that are less than 30 days apart
        Date date1 =  Date.newInstance(2021, 7, 1);
        Date date1EndOfMonth = Date.newInstance(2021, 7, 31);
        Date date2 = date1+45;
        // test the CheckDates method if date 2 withing 30 days return date 2, otherwise return the end of the month
        //should return 7/31/2021 end of month
        Date testDate = VerifyDate.CheckDates(date1, date2);
        
        //
        System.assertEquals(date1EndOfMonth, testDate,'the date returned was not as expected');

    }

}