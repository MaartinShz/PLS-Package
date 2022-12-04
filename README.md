# 🖐 PLS-Package 🖐

-   [Introduction](#introduction)
-   [Setup](#setup)
-   [PLSDA object](#plsda-object)
-   [Function fit](#function-fit)
    -   [Parameters](#parameters)
    -   [Function usage](#function-usage---print)
-   [Function predict](#function-predict)
    -   [Parameters](#parameters-1)
    -   [Function usage](#function-usage)
    -   [Confusion matrix](#confusion-matrix)
-   [GridSearchCV](#gridsearchcv)
-   [Plots](#plot)
-   [Rshiny app](#application-r-shiny)
    -   [Setup](#how-to-setup-the-app)
    -   [App](#app)
        -   [Import Data](#import-data)
        -   [Fit and Predict](#fit-and-predict)
        -   [Plots](#plots)
        -   [Export](#export)

## Introduction

It's a package proposing a PLS regression method for ranking purposes.
PLS regression is used to predict a set of dependent variables from a very large set of explanatory variables that may be very highly correlated.
In this ReadMe, we will show you how our package works with the Iris dataset, native dataset from R.

## Setup

To use the package in your environment R. You have two solutions.
Download the file with extension .tar.gz from the repository then go to your IDE and install the package manually.

![install1](https://user-images.githubusercontent.com/43068347/204146389-5f08c16a-0f82-4f6a-a5ab-abc56581eeed.jpg)
![install2](https://user-images.githubusercontent.com/43068347/204146422-fd1647be-ea2e-4725-ae9e-d8fbd3520cb4.jpg)

Or directly install the package from GitHub with devtools, with the command below in your terminal:

```
library(devtools)
install_github("MaartinShz/PLS-Package")
```

Once you have install the package, you can use the command "plsdaSise::" before the function to use it.

```
plsdaSise::plsda()
```

Otherwise, to avoid the annoying prefix, you should use this command and then you are free to use all the functions of our package easily.

```
library(plsdaSise)

plsda()
```

If you have a question about a function you can run the command "help". That will show you some explanation about the function and also some examples.

```
help(plsda)
```

![image](https://user-images.githubusercontent.com/114392261/205472717-543fbb64-e8ec-427c-8929-eaf732a36871.png)

## PLSDA object

The first step to use our package, is to create a PLSDA object. To do this, we need to call the function plsda.

```
obj = plsdaSise::plsda()
```

## Function fit

### Parameters
After the construction of the object, we can apply the function plsda_fit to our object.
This function have many parameters :

- object
- formula
- data
- ncomp
- var.select
- center
- threshold

4 of them have a value by default so we will explain here only the 3 paramaters that you need to use for the function. Object is a PLSDA object created above, formula is an object of class formula use to select explicative data and target data of the dataset and finaly there is data that we want to apply a PLS regression.

### Function usage - Print 
Here some examples of using the function.

```
fit = plsdaSise::plsda_fit(obj,Species~., iris)

#Here we want same thing but with a selection of variable and a define number of composant
fit = plsdaSise::plsda_fit(obj,Species~., iris,ncomp=2, var.select = T)

```

If you want to see the result, you can print it and you will see a list of 14 features. We overload the print method for this object so you only need to use the command "print".
```
print(fit)
```
You can see below the lasts lines of the print

![print1](https://user-images.githubusercontent.com/43068347/205502818-0cf82be3-57ee-4f5a-a981-9867bbdded30.jpg)
![print2](https://user-images.githubusercontent.com/43068347/205502830-0bca3474-d7a2-4399-a9cc-4313b20e274d.jpg)

We overload the summary method too. Here it is the result :


![summary1](https://user-images.githubusercontent.com/43068347/205502856-397a559c-10d9-4af9-9b10-bf687063ecff.jpg)

## Function predict

Finally, we can use the prediction model to use on a test data.

### Parameters
There is 3 parameters :

- obj : object PLSDA
- newdata : data we want to predict (without the target)
- type : posterior or class (probability for each class or target prediction)

### Function usage
To predict the target of our dataset we need to use the function plsda_predict

```
plsdaSise::plsda_predict(obj,newdata,type = "class")
```
Here we have the value of the prediction by observation :

![image](https://user-images.githubusercontent.com/114392261/205471965-5fd14788-becf-4b14-9f9f-0eaea6957e7c.png)


```
plsdaSise::plsda_predict(obj,newdata,type = "posterior")
```

Here we have the probabilty of class membership by observation :

![image](https://user-images.githubusercontent.com/114392261/205471939-cd7b21ed-2265-4973-91a8-18f7fd0f797e.png)


### Confusion matrix
When you finish all steps, you can make a confusion matrix with the result of the prediction.
We show you how to do this below.

```
#We create a dataset for training, X variables for test and target variable for test too
newdata = split_sample(iris)
train = newdata$train
Xtest= newdata$test[,-ncol(iris)]
Ytest= newdata$test[,ncol(iris)]

#Create object
obj = plsda()
#fit + predict
plsTrain = plsda_fit(obj, Species~., train)
predTest = plsda_predict(plsTrain, Xtest,type = "class")

#confusion matrix
cm = table(Ytest, predTest)
print(cm)
```

## GridSearchCV

The goal of this function is to take the best model made by the cross validation.
It has 3 parameters :

- ObjectPLSDA : PLSDA object
- formula : object of class formula
- data : dataset
- cv : number of part for splitting ( 5 by default)
- method : How do we split the dataset, there is 2 different method (rsplit and kfold)

After the cross validation you selected, the function will make X predictions (number of the parameter cv) and will calculate the fscore of each.
The function will return the resukt with the best model and his fscore.

```
BM = GridSearchCV(obj,Species~.,iris)
```
If you want to see the model or the fscore look below.

```
BM$model
```


```
BM$fscore
```
## Plot

Our package offer some plot to observe the data.
There are 3 different plots available : 

- scree plot
- varcorr plot
- variableMap plot

Except the last plot, plots take only one parameter : Object PLSDA.
Here the line code that allow you to make the plot.

```
plsdaSise::plot.scree(obj)
```

![image](https://user-images.githubusercontent.com/114392261/205472638-28588055-c233-42fb-a525-4b2afea9cd7e.png)

```
plsdaSise::plot.varCorr(obj)
```
![image](https://user-images.githubusercontent.com/114392261/205472643-fd3f7cef-c7d1-4696-a1e9-1c915c3be1d1.png)

For the last graph, we need 2 more parameters. comp1 and comp2, there are the 2 components that we want to use for the plot.
Look at the example below.

```
plsdaSise::variableMap.plsda(obj,obj$x_scores$X1,obj$x_scores$X2)
```

![image](https://user-images.githubusercontent.com/114392261/205472646-08d47897-0869-4a85-a78a-257102a0fb48.png)

## Application r-Shiny


### How to setup the app
This repository has an r-shiny application allowing to use the package in a graphical way and to simply present it and take it in hand 
You just need to have the shiny library on your computer 
and you should be able to launch the application from your IDE from one of the files in the rshiny repository folder
Example below: 

![image](https://user-images.githubusercontent.com/43068347/204147679-80463626-b954-44bf-9f5d-21364aa06ae7.png)

### App

The shiny app contains 4 tabs :
- Import Data
- Fit and Predict
- Plots
- Export

We will explain below all the features of our application.

#### Import Data
When you run the app, it opens on the "Import Data" tab.

![image](https://user-images.githubusercontent.com/114392261/205500575-d06b228f-73b4-4cc4-9bf1-d86f32e1128e.png)

To use the features we need to import a file, he can be a csv or an excel type. Once you select the type, you can choose the separator, the sheet you want and if your dataset have a header or not.
You can see the result on the right.

![image](https://user-images.githubusercontent.com/114392261/205500951-58a8569c-cfed-42ac-9f8a-a83c132505fc.png)

You don't need to validate something, your dataset is created when you browse your file.

#### Fit and Predict
This tab is the most important, it's here that we train the data and predict the target.
First of all we select our X variables and our target. There is lot of parameters like the number of composant, if we want variables selection etc.
Here it is an exemple of what we can do :

![image](https://user-images.githubusercontent.com/114392261/205500984-1bb5fe9d-0c90-464f-aa96-03cd7cb66c41.png)

Once you complete your selection and check your options, you click on the fit model button and you will see the result on the right of the app.

Now the predict is completed so we have to predict. to do this just click on the predict model button and you will see the result below the fit model.

![image](https://user-images.githubusercontent.com/114392261/205501007-5f5286ae-853b-4ab5-b5e7-c0747585af64.png)

By default, the prediction's type is "posterior", so you can change it before the predict to see the difference. Here I click on Class radio button to change the type and I predict the model once more :

![image](https://user-images.githubusercontent.com/114392261/205501021-3a58856d-2bce-43b1-890b-fae1c0d6f102.png)

Finally, if you don't split the Data, you can choose your file test with the final option below the prediction.
Be careful to select the exact same data format, select the good separator. Data test need to have the target varaible too.

#### Plots
The plot tab contains 2 different graphs. The first one is a scree plot that show us the eigen values of each composant of the model.
If you click on the composant plot, you will see the scree plot on the right and below the button the number of composant in the fit.

![image](https://user-images.githubusercontent.com/114392261/205501040-f9e7bb7a-c6d5-48d2-b667-81c2509790dc.png)

The second graph, is a composant map that will show us the correlation between the different X variables.
If you click on the composant map plot, it shows a graph below the first one that show us the X variables around the 2 composants that we choose.

![image](https://user-images.githubusercontent.com/114392261/205501057-9a35ba97-ed5e-47eb-b786-da15e0a914d2.png)

Little tips, we can see values of the points when we pass on them. We can select which variables we want to see when we clck on them in the legends.

![image](https://user-images.githubusercontent.com/114392261/205501076-f2f6f96b-3062-457a-af0c-cab4d00aa4c7.png)

![image](https://user-images.githubusercontent.com/114392261/205501091-097dbbce-3d01-4082-bd1a-5052be37316e.png)

#### Export
The last one is simple, you can click on the button to export your prediction and we show you some entries of your prediction.
Above the prediction you have the path where the file is save.

![image](https://user-images.githubusercontent.com/114392261/205501101-27dbf931-c12a-4ab8-a8d4-4544617de4a8.png)
