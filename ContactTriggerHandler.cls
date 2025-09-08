public class ContactTriggerHandler {
    public static void updateAccountContactCount(List<Contact> newList, List<Contact> oldList){
        Set<Id> accountIds = new Set<Id>();

        if(newList != null){
            for(Contact con : newList){
                if(con.AccountId != null){
                    accountIds.add(con.AccountId);
                }
            }
        }

        if(oldList != null){
            for(Contact con : oldList){
                if(con.AccountId != null){
                    accountIds.add(con.AccountId);
                }
            }
        }

        if(!accountIds.isEmpty()){
            List<Account> accountsToUpdate = [
                SELECT Id, Number_of_Contacts__c,
                    (SELECT Id FROM Contacts)
                FROM Account
                WHERE Id IN :accountIds
            ];

            for(Account acc : accountsToUpdate){
                acc.Number_of_Contacts__c = acc.Contacts.size();
            }

            update accountsToUpdate;
        }
    }
}