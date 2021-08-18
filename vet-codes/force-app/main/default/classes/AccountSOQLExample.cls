/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 08-16-2021
 * @last modified by  : Daniel Boice
**/
public class AccountSOQLExample {

    /*

	//AccountSOQLExample.MapAccountsWithContactsWithEmailOrPhone('','',true,true);

	// AccountSOQLExample.AddExampleRecords();

     //AccountSOQLExample.DeleteExampleRecords();
    //AccountSOQLExample.UpdateContactsWithoutPhoneOrEmailWithDefaultValues()

    // AccountSOQLExample.MapAccountsWithContactsWithEmailOrPhone('','',true,true);

    // AccountSOQLExample.MapAccountsWithContactsWithEmailOrPhone('bryananeux@outlook.com','',true, false);

	//System.debug(AccountSOQLExample.GetMapOfAccountContactsWithAccountId('0015e00000ETSDUAA5'));
    testing vscode push github github2 testing 123 dks, this is a test, dkddsdd, test, test, test, test, test, test
    
    test... testing one two three! I think this is it. test, testing, testing setup, testing again. should work this time., test, test.
    
    */

    public static void AddExampleRecords(){
        //add 151 unique records to the Account object

        Account[] accts = new List<Account>();

        //create an incrementing for loop that iterates 151 times, creates an account object, and adds it to the accts List
        for(Integer i=0;i< 152; i++) {
    		Account a = new Account(Name='Example' + i);
    		accts.add(a);
		}

        // Use a try catch block to insert the account list
		try {
    		insert accts;
		}
      	catch(DmlException e) {
    		System.debug('An unexpected error has occurred: ' + e.getMessage());
		}

		// Verify that the accounts were added.
       	Account[] acctsAfterAdded = [SELECT Name FROM Account WHERE Name LIKE 'Example%'];

        System.debug(acctsAfterAdded);

    }

	public static void DeleteExampleRecords(){

        Account[] acctsAfterAdded = [SELECT Name FROM Account WHERE Name LIKE 'Example%'];

        // Use a try catch block for delete DML statement
        try {
    		delete acctsAfterAdded;
		}
      	catch(DmlException e) {
    		System.debug('An unexpected error has occurred: ' + e.getMessage());
		}

        // Verify that they were deleted
        Account[] acctsAfterDeleted = [SELECT Name FROM Account WHERE Name LIKE 'Example%'];

        System.debug(acctsAfterDeleted);

    }
    public static void UpdateContactsWithoutPhoneOrEmailWithDefaultValues(){
        //update account object records without email or phone with default values


		// Select the contacts where email is null.
       	Contact[] contactsWithoutEmail = [SELECT Email FROM Contact WHERE Email = null];

        // view the results
        System.debug(contactsWithoutEmail);

        // loop through the accounts and update them with default value
        for(Contact contct: contactsWithoutEmail) {
    		contct.Email='default@nowhere.com';
		}

        // use DML to update the contacts
		try {
    		update contactsWithoutEmail;
		}
      	catch(DmlException e) {
    		System.debug('An unexpected error has occurred: ' + e.getMessage());
		}

        // Select contacts where phone is Null.
       	Contact[] contactsWithoutPhone = [SELECT Email FROM Contact WHERE Phone = null];

        // view the contacts
        System.debug(contactsWithoutPhone);

        // loop through the contacts and update them with default value for phone
        for(Contact contct: contactsWithoutPhone) {
    		contct.Phone='555.555.5555';
		}

		try {
    		update contactsWithoutPhone;
		}
      	catch(DmlException e) {
    		System.debug('An unexpected error has occurred: ' + e.getMessage());
		}
    }

    public static void MapAccountsWithContactsWithEmailOrPhone(String email,String phone, Boolean useDefaultEmailIfNotProvided, Boolean useDefaultPhoneIfNotProvided){

        /*
        Boolean useDefaultEmailIfNotProvided = true;
		Boolean useDefaultPhoneIfNotProvided = true;
		String email = '';
		String phone = '';
    	*/
	if ( useDefaultEmailIfNotProvided &&  (email==null || email == '')){
            email = 'default@nowhere.com';
        }
        if ( useDefaultPhoneIfNotProvided && (phone==null || phone =='') ){
            phone = '555.555.5555';
        }
        /** some previous tests
         Select contact with default emails and phones
         Contact[] contactsWithDefaultEmailOrPhone = [SELECT Contact.Account.Name, Email, Phone FROM Contact WHERE Email = email or Phone = phone];

         Account[] accountsWithDefaultEmailOrPhone = [Select Name, (Select Id, FirstName, LastName, Email, Phone FROM Account.Contacts WHERE Email = email or Phone = phone) FROM Account WHERE Account.Contact = Id];
         display the results

        Account[] accountsWithDefaultEmailOrPhone = [SELECT Id, FirstName, LastName, Account.Name, Email, Phone FROM Contact WHERE Email = 'default@nowhere.com'];
        System.debug(accountsWithDefaultEmailOrPhone);
       	**/

		Contact[] qr = [SELECT c.Id, c.AccountId, c.FirstName, c.LastName, c.Email, c.Phone FROM Contact c WHERE c.Email = :email or c.Phone = :phone];
		//System.debug(qr);

        Map<Id, List<List<String>>> m1 = new Map<Id, List<List<String>>>();

		for (Contact c : qr){


            //get Account with account id equal to the account id in contact to get the account name
    		Account a = [SELECT Name, Id FROM Account WHERE Id =: c.AccountId];
			//Account[] a = (Account) c[1];
            // create a list of account name, contact first name, contact last name, email, and Phone
            List<String> myList2 = new List <String>();
            myList2.add('Account Name : ' + a.Name);
            myList2.add('First Name: '+ c.FirstName);
            myList2.add('Last Name: '+ c.LastName);
            myList2.add('Email: ' + c.Email);
            myList2.add('Phone: ' + c.Phone);

            // put the list in the map with the account key if it already exists
            if (m1.containsKey(a.Id)){
               List<List<String>> aListValue = (List<List<String>>) m1.get(a.Id);
               aListValue.add(myList2);
            }
            else{
                // create a list to hold the list of contacts
                List<List<String>> myList1 = new List<List<String>>();

                // add the list with contact info strings to the List
                myList1.add(myList2);
                // create a key value pair with the unique account ID as key and the list of contact strings as value
                m1.put(a.Id, myList1);
            }

		}
		System.debug(m1);
	}
    public static  Map<Id, List<List<String>>> GetMapOfAccountContactsWithAccountId(Id accountId){


        /** some previous tests
         Select contact with default emails and phones
         Contact[] contactsWithDefaultEmailOrPhone = [SELECT Contact.Account.Name, Email, Phone FROM Contact WHERE Email =:email or Phone = :phone];

         Account[] accountsWithDefaultEmailOrPhone = [Select Name, (Select Id, FirstName, LastName, Email, Phone FROM Account.Contacts WHERE Email = :email or Phone = :phone) FROM Account WHERE Account.Contact =: Id];
         display the results

        Account[] accountsWithDefaultEmailOrPhone = [SELECT Id, FirstName, LastName, Account.Name, Email, Phone FROM Contact WHERE Email = 'default@nowhere.com'];
        System.debug(accountsWithDefaultEmailOrPhone);
       	**/

		Contact[] qr = [SELECT c.Id, c.AccountId, c.FirstName, c.LastName, c.Email, c.Phone FROM Contact c WHERE c.AccountId = :accountId];
		//System.debug(qr);

        Map<Id, List<List<String>>> m1 = new Map<Id, List<List<String>>>();

		for (Contact c : qr){


            //get Account with account id equal to the account id in contact to get the account name
    		Account a = [SELECT Name, Id FROM Account WHERE Id =: c.AccountId];

            // create a list of account name, contact first name, contact last name, email, and Phone
            List<String> myList2 = new List <String>();
            myList2.add('Account Name : ' + a.Name);
            myList2.add('First Name: '+ c.FirstName);
            myList2.add('Last Name: '+ c.LastName);
            myList2.add('Email: ' + c.Email);
            myList2.add('Phone: ' + c.Phone);

            // put the list in the map with the account key if it already exists
            if (m1.containsKey(a.Id)){
               List<List<String>> aListValue = (List<List<String>>) m1.get(a.Id);
               aListValue.add(myList2);
            }
            else{
                // create a list to hold the list of contacts
                List<List<String>> myList1 = new List<List<String>>();

                // add the list with contact info strings to the List
                myList1.add(myList2);
                // create a key value pair with the unique account ID as key and the list of contact strings as value
                m1.put(a.Id, myList1);
            }

		}
		return m1;
	}

}