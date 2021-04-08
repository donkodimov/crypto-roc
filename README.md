# crypto-roc

crypto-roc is web app that compares a **historical cryptocurrency price** versus the price of different hard assets (gold, real estate ...).
This web app is created using `streamlit` Python library for learning purpose only. 
Do not use it as an investment advice. 

### Rate of Change (ROC)

The [rate of change](https://www.investopedia.com/terms/r/rateofchange.asp) (ROC) is the speed at which a variable changes over a specific period of time. ROC is often used when speaking about momentum, and it can generally be expressed as a ratio between a change in one variable relative to a corresponding change in another; graphically, the rate of change is represented by the slope of a line. The ROC is often illustrated by the Greek letter delta.

Quickstart
-------------

Tested only on `linux` so far.
To build this web you need to have `docker engine` installed. 

### Install
1. Copy the repo and move to the folder:
 ```
 git clone https://github.com/donkodimov/crypto-roc.git
 cd crypto-roc
 ```
   
2. Build docker image:
````
make build
````

3. Run the container:
```
make run
```

4. Open the web:
 
Use your browser to visit the app on `localhost:8501`




### Issues:

* If the docker container cannot be build on step 2, check that your user is added to the docker group:

```
 sudo usermod -a -G docker USER
 newgrp docker
```

* If you want to reach the app outside the running machine, make sure port 8501 is not filtered by a firewall.

### License
`crypto-roc` is free and open source software and may be redistributed under the terms specified in the
[LICENSE] file.

[LICENSE]: https://github.com/donkodimov/crypto-roc/blob/develop/LICENSE
