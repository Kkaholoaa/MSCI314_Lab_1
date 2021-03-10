##Kaiku Kaholoaa## 
##kkaholoaa@csumb.edu##
##Lab 1 - Subpopulations##
##March 10, 2021## 

#-----------------------------------------------

##Clear workspace
rm(list=ls())

install.packages("adegenet", dep = TRUE)
install.packages("poppr")
install.packages("ape")
install.packages("pegas")
install.packages("hierfstat")
library(adegenet)
library(poppr)package?poppr
library(ape)
library(pegas)
library("hierfstat")

data(nancycats)
cats <- nancycats 
cats
