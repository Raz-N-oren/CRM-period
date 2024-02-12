// trigger EventTrigger on Message_Event__e (after insert) {
//     System.debug('EventTrigger');
//     for(Message_Event__e event: Trigger.new){
//         System.debug('event'+event);
//         List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
//         Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
//         List<String> sentTo = new List<string>();
//         sentTo.add('razoren2394@gmail.com');
//         mail.setToAddresses(sentTo);
//         mail.setSubject('Good Luck');
//         String body = (event.Description__c);
//         mail.setHtmlBody(body);
//         mails.add(mail);
//         Messaging.sendEmail(mails);

//     }
// }



// SWITCH ON Trigger.operationType{
//     WHEN AFTER_INSERT{
//         System.debug('Trigger.isAfter && Trigger.isInsert');
//         Message_Event__e messageEvent = new Message_Event__e();   
//         messageEvent.Description__c = 'Trigger.isAfter && Trigger.isInsert';
//         EventBus.publish(messageEvent);     
//     }
// }