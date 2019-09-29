#Welcome to Blockparty!

The idea here is to show a simple app using blockchain (via Nuls) to record transactions among neighbors so they can trade goods and services.

In this example, there are nine people registered to trades food item like apples, oranges and eggs. Each item costs one nuls or one "token". 

After compiling and running the project (almost exactly like the Chainbox Example), you need to open the front end page by opening this file with a Chrome or Firefox browser:

<project-directory>/NULS_WALLET/Modules/Nuls/nuls-blockparty/1.0.0/nuls-blockparty.html

That is the main entry to this application.

The app can be expanded to do things like trade food for services. One-half hour of house cleaning might be worth 5 eggs, 2 apples and a loaf of bread.
Driving a neighbor to the airport might win you 6 avocados and an hour of babysitting.  And so on.

The app started with a copy of Nuls Chainbox example. I modified the html front-end to accept food trading. I started with basically not much knowledge of how blockchains work. At first, I went through the app and removed all the parts relating to creating and sending emails. I also spent a good amount of time getting the built-in Grizzly web server to function on port 0.0.0.0:9999 . The worst part of that was dealing with CORS rejecting requests based on headers.  I finally figured out how to set them in the outgoing request correctly. 

When I moved onto the meat and potatoes of the app - I discovered that transferring nuls between accounts was easier said than done. In order to better understand the process, I usually use the debugger built into whatever IDE I'm using. However, in the case of Nuls - a giant, complex code base with numerous configuration files - this wasn't going to be possible. Also, you would want debugging run on the entire system because it would slow to a crawl.

The Java JDK ships with it's own built in debugger - often accessed by the command line via the cli tool jdb. However, having little experience using that I did some research and found that Intellij Idea for Java would run with the JDK build in debugger.

I enabled the debugger to run with just my module. Included in this package is a file in the "build" directory called "start-debugger.sh" that enables this. Rename the this file to "start.sh" and copy it over the start.sh in <project-directory>/NULS_WALLET/Modules/Nuls/nuls-blockparty/1.0.0/ .

The debugger runs on port 8000. Go into the Run / Edit Configurations and add a configuration for Remote from the run templates provided. Enter 8000 for the port. It should automatically fill in the settings which are:

       -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=localhost:8000

These are the same settings that go into the java run instruction for the module you want to debug.

The accounts for the people Kathy, Bella, Olivia etc. need to be created in the usual Chainbox example manor.  I will include brief instructions for that below. I've included a file "address" that has keys for the first two users.  To enable the rest of the users, view the source of the html page for now. The source code behind each user's popup selection has their matching account addresses. Later I might include the other names.

As of Sept 27 2019 the transactions in this app are almost going through. I need to finish one step which is the commit.  There is also general code cleanup to be done.

### My Experience Coding with Nuls
Wow, amazing. It's hard to believe a loosely organized open-source, international group of people have this giant code-base not only working but available for everyone. The transactions, encryption, data flow etc are all functional. Clearly the expertise of the developers was very advanced to begin with. In this project you will find:

- Abstract Classes, Interfaces
- Collections – List, Map, Set etc.
- File IO, Serialization, JSON
- Spring, Annotations and Optionals
- Multithreading and Synchronization
- Generics; Dependency Injection, Lambda's
- Servers, Servlets, Sockets
- Web Technologies - HTML, REST, CSS, Javascript, JQuery and Ajax

###Some Things I Changed from Chainbox

Much of the code was difficult to read at first since it was both unfamiliar, and frankly - I had given up on Java and have been using Python more and more over the past few years. Going back to Java was a little bit painful. But I found I enjoyed the 'sturdy' feeling of something that won't tie itself together unless it's developers really "make it so". Also, much of the technology around Java - like profiling and debugging - are very advanced. 

A lot of the Chainbox code had been condensed so that it was fast, lightweight, efficient - but difficult to step through with a debugger for learning purposes. So I undid a lot of the function calls within function calls, etc. I also moved functionality around a little bit so that the main working parts were more together. 

Since my app doesn't send email - in the future I'd like to remove some of that and other extraneous code if posssible.


#### Startup Instructions

- Linux or MacOS
- Git
- Maven
- JDK11
- Set Java in the $PATH

```
git clone git@github.com:nmschorr/nuls-hackathon.git
```
Change directory to the `nuls-blockparty` directory:
```
cd nuls-blockparty  
```
Run the first build command:

```
package
```

If successful, you will find the `outer` folder generated in `nuls-blockparty`.

Go back to the project root directory:

```
cd ..
```

Run the second build command:

```
tools -p nuls-blockparty
```

The `NULS_WALLET` folder will be created in the main directory. It contains the NULS environment, logs, data and runnable classes and jars.

Execute the following in the `NULS_WALLET` directory:

```
start-dev

```

The nuls.ncf is created during the first execution of the command. Re-enter the command:

```
start-dev
```


Now that the node is started, we need to import the default block address of the seed node so that the node can begin to produce blocks. 

**This is very important. If you miss this step, or enter the wrong details, the seed node will not begin building blocks and this app will not work.**

In shell, run:

```
cmd
```
and when you have a "nuls>>>" prompt enter:


```
import b54db432bba7e13a6c4a28f65b925b18e63bcb79143f7b894fa735d5d3d09db5
```
and when prompted for password enter:

```
nuls123456
```

The front end html page is set up to use nine people. To start with, you can enter just the first two. You will also need to go into the cmd cli app and transfer funds from Bella to Kathy as Kathy's account starts off with 0 tokens and Bellas has 1000000000000000.  
Setup two accounts to test sending and receiving a message. The following two addresses are pre-defined in the genesis block.  For these accounts, enter any password.

```
nuls>>> import 477059f40708313626cccd26f276646e4466032cabceccbf571a7c46f954eb75
Please enter the password (password is between 8 and 20 inclusive of numbers and letters), If you do not want to set a password, return directly.
Enter your password:**********
Please confirm new password:**********
tNULSeBaMnrs6JKrCy6TQdzYJZkMZJDng7QAsD

nuls>>> import 8212e7ba23c8b52790c45b0514490356cd819db15d364cbe08659b5888339e78
Please enter the password (password is between 8 and 20 inclusive of numbers and letters), If you do not want to set a password, return directly.
Enter your password:**********
Please confirm new password:**********
tNULSeBaMrbMRiFAUeeAt6swb4xVBNyi81YL24
```
The accounts 'tNULSeBaMnrs6JKrCy6TQdzYJZkMZJDng7QAsD' and 'tNULSeBaMrbMRiFAUeeAt6swb4xVBNyi81YL24' are now available.

If you wish to enable the rest of the accounts to match the web page, here are the entries:

<sub><sup>
tNULSeBaMvEtDfvZuukDf2mVyfGo3DdiN8KLRG;tony;9ce21dad67e0f0af2599b41b515a7f7018059418bab892a7b68f283d489abc4b;

tNULSeBaMu38g1vnJsSZUCwTDU9GsE5TVNUtpD;praveen;020e19418ed26700b0dba720dcc95483cb4adb1b5f8a103818dab17d5b05231854;

tNULSeBaMp9wC9PcWEcfesY7YmWrPfeQzkN1xL;bonnie; bec819ef7d5beeb1593790254583e077e00f481982bce1a43ea2830a2dc4fdf7;

tNULSeBaMpEWXCjDc48kdg2ByejY1KuUcZZhaK;ming;02d27d576e911d1beb218dd3bef6d5c2f96c8de21ff6cc02b799cb6e3f6709f48b;

tNULSeBaMshNPEnuqiDhMdSA4iNs6LMgjY6tcL;ethan;ddddb7cb859a467fbe05d5034735de9e62ad06db6557b64d7c139b6db856b200;

tNULSeBaMoodYW7AqyJrgYdWiJ6nfwfVHHHyXm;olivia;4efb6c23991f56626bc77cdb341d64e891e0412b03cbcb948aba6d4defb4e60a;

tNULSeBaMuNfJh79Jbj6HSzMAkaA4AAGwzeSMH;freddie;0369132c3272148f1635e2f3d8a0fd9c09598e450c41e4b9a0a3f86c88b38e4fa7;
</sub></sup>