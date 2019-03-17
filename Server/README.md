
## Some Read Me Goes Here..
And also its a live build, that means: When ever i change this file(s) and save it, just reload this web page.
#### It updates the live server instantly. Nice!

** I'll give a handy defition of this API server here, later.. may be away later **


### How to start?
clone the repo first,
just go to the `/Server` directory from CLI and run the following command,

`docker-compose up --build`

you must have docker installed on your system to do this.



### How to test?

First build and run the mobile application in XCode, be sure it is running on iOS Simulator, it must be running in the same machine with this server instance. 

Then run this server instance.

Then go to the 'Game Page' in the mobile app.

While the server is running, open your [Postan](https://www.getpostman.com/) and make a post request with the example structure in below.

*example Request:*
```
{
	"id":"1",
	"title":"What is the special fruid which growns only mediterrain area?",
	"answers": [
		{
			"id":"1",
			"title" : "Apple",
			"isSelected" : false,
			"isCorrect" : false
		},
		{
			"id":"2",
			"title" : "Mandarin",
			"isSelected" : false,
			"isCorrect" : true
		},
		{
			"id":"3",
			"title" : "Banana",
			"isSelected" : false,
			"isCorrect" : false
		}
	]
}
```


server will give a success message to you like below

*example Response:*
```
{
    "message": "Question Sent!",
    "response": {
        "answers": [
            {
                "id": "1",
                "isCorrect": false,
                "isSelected": false,
                "title": "Apple"
            },
            {
                "id": "2",
                "isCorrect": true,
                "isSelected": false,
                "title": "Mandarin"
            },
            {
                "id": "3",
                "isCorrect": false,
                "isSelected": false,
                "title": "Banana"
            }
        ],
        "id": "1",
        "title": "What is the special fruid which growns only mediterrain area?"
    }
}
```


you now must be able to see the incoming communication on your mobile app. 

Feel free to test as much as you want and notice the developer if any bug occurs.
[project owner](https://github.com/coshkun)
[main repository](https://github.com/coshkun/Questify)