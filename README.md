# 🖐 PLS-Package 🖐

-   [Introduction](#introduction)
-   [Setup](#setup)



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

Once you have install the package, you should use the command "plsdaSise::" before the function to use it.

```
plsdaSise::plsda()
```

If you have a question about a function you can run the command "help". That will show you some explanation about the function and also some examples.

```
help(plsda)
```

## PLSDA object

The first step to use our package, is to create a PLSDA object. To do this, we need to call the function plsda.

```
obj = plsda()
```

## Function fit

After the construction of the object, we can apply the function plsda_fit to our oject.
This function have many parameters :

- object
- formula
- data
- ncomp
- var.select
- center
- threshold

4 of them have a value by default so we will explain here only the 3 paramaters that you need to use for the function. Object is a PLSDA object created above, formula is an object of class formula use to select explicative data and target data of the dataset and finaly there is data that we want to apply a PLS regression.
Here some examples of using the function.

```
fit = plsda_fit(obj,Species~., iris)

#Here we want same thing but with a selection of variable and a define number of composant
fit = plsda_fit(obj,Species~., iris,ncomp=2, var.select = T)

```

If you want to see the result, you can print it and you will see a list of 14 features. We overload the print function for this object so you only need to use the command "print".
```
print(fit)
```

## Prediction - Usage

## Display

## Application r-Shiny

This repository has an r-shiny application allowing to use the package in a graphical way and to simply present it and take it in hand 
You just need to have the shiny library on your computer 
and you should be able to launch the application from your IDE from one of the files in the rshiny repository folder
Example below: 

![image](https://user-images.githubusercontent.com/43068347/204147679-80463626-b954-44bf-9f5d-21364aa06ae7.png)
