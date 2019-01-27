## Inspiration
Non-profit organisations have operating costs too. How much of your money is making a direct impact on the cause you supported? How much is put toward keeping the lights on? With big charity organisations, these questions may be difficult to answer.

There is an overall trend of distrust between donors and charity organisations. In fact, according the New York University's Robert F. Wagner Graduate School of Public Service, **1 out of 3** Americans don't trust charity organisations, and **68 percent** said it is very important that charities have evidence that its programs are effective.

## What it does
Our mobile app/service _Robin Hood_ brings the donor closer to the recipient in many aspects.

1. Enables **wealth redistribution** without the overhead costs in doing so
2. Shows donor **when and where** their donations are being used
3. Allows **targeted** donation so that donors can specify what their donations are used for

Donors make donations by first specifying a dollar amount and purchase category (e.g. food, hygiene, education, etc.). Then, their money is held in our system's bank account until it is needed by a recipient.

When required, recipients may take a picture of their receipt to upload to our database and request a reimbursement. A withdrawal will then be made for the recipient.

## How we built it
The app was built using Dart and the Flutter framework. Donation/withdrawal requests are sent to Firebase Firestore with Firebase Auth functionality, and any receipt images taken are sent to Firebase Store, then run through Microsoft Azure's OCR API. Based on the text extracted through Azure, we could then make a decision on whether the receipt was valid and/or the items purchased were eligible for reimbursement.

The four of us used Android Studio on, interestingly, a variety of operating systems from Linux to OSX to Windows. Also a mixture of Android device emulators and our personal devices were used for debugging.

## Challenges we ran into

**How is the money going to be used as intended?**

Originally, we wanted to transfer the money immediately before a recipient needed to purchase certain items, but it would be very difficult to tell whether they actually spent that money on food, personal hygiene, etc. instead of demerit goods. To solve this issue, we changed our model to one where the recipients purchases goods before requesting reimbursement.

**How are we going to validate receipts?**

Using Azure OCR, we attempt to extract the store address and compare it to the requestor device's location. Also, the date of the receipt is compared to today's date.

**Unfamiliarity with technologies used**

All four team members had little to no experience with our stack going into the event. Although there was a learning curve, mentors were there to help us when we needed it, to speed up the process.

## Accomplishments that we're proud of

Nobody knew our stack well, but we pulled through to work together and create a coherent mobile app.  
Also, we think our UI is pretty clean and minimal.

## What we learned

- The MVC architecture
- Asynchronous programming
- How to use POST requests to take advantage of RESTful web APIs

## What's next for Robin Hood

- Implement actual transfer of balances (with real money) among accounts
- Improve OCR filtering and extend it to recognize and validate individual items purchased
- Functionality to send personalized notes among donors and recipients