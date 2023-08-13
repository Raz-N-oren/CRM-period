public with sharing class MyClass {
    public void func1(List<Opportunity> opps){

        System.debug(opps.isEmpty());
        System.debug('func1');
    }
}

// List<Opportunity> opps = new List<Opportunity>();
// MyClass myClass = new MyClass();

// MyClass.func1(opps);

