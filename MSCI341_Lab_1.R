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

#237 individuals; 9 loci; 108 alleles; about 8-18 alleles per locus

#genind = allelic data for individuals stored as (integer) allele counts 5 can be imported from a wide range of formats, including those of popular population. 
#genpop: allelic data for groups of individuals ("populations") stored as (integer) allele counts

##looking at the data##

#these are from the package adegenet

nInd(cats)
#nInd = # individuals
#237 individuals

nLoc(cats)
#nLoc = # loci
#9 loci 

nAll(cats)
#nAll = number of alleles for each locus 
#fca8 fca23 fca43 fca45 fca77 fca78 fca90 fca96 fca37 
#I believe that fca is the allele and the numbers are the amount of such allele at each locus
#example: first locus is at fca8 and there are 8 fca alleles at this locus

nPop(cats)
#npop= returns the number of populations
#(joined with nAll in this example)\
#fca8 fca23 fca43 fca45 fca77 fca78 fca90 fca96 fca37 
#16    11    10     9    12     8    12    12    18 
#there are 16 populations with 8 fcs alleles at the first locus

tab(cats)
#tab returns a table of allele numbers or frequencies, with optional replacement of missing values; replaces the former accessor 'true names'. 
#table too big to display.

head(indNames(cats),10)
#head shows first 10 outputs; indNames shows individual names of individuals; 10 is the position. 
#names of those individuals: "N215" "N216" "N217" "N218" "N219" "N220" "N221" "N222" "N223" "N224"

indNames(cats) <- paste("cat", 1:nInd(cats),sep=".")
head(indNames(cats),10)
#you can change the individual names using this code 
#names now are "cat.1"  "cat.2"  "cat.3"  "cat.4"  "cat.5"  "cat.6"  "cat.7"  "cat.8"  "cat.9"  "cat.10"

cats
#where the data is stored as allele counts in a matrix where rows are individuals and columns

dim(cats@tab)
#dim(cats@tab) tells us about the dimensions
#[1] 237 108
#the dimensions tells us that there are 237 individuals and 108 alleles

class(cats@tab)
#class describes the class the of the object
#this object is a "matrix" "array"

cats@tab[1:5,1:20]
#cats@tab[position] lets you look at a table of the interval
#turns out we have missing data for cats 1 and 2

#Some accessors such as locNames may have specific options; for instance: 

locNames(cats)

#locNames(cats) returns the names of the loc
#loci names are "fca8"  "fca23" "fca43" "fca45" "fca77" "fca78" "fca90" "fca96" "fca37"

#while 

temp <- locNames(cats, withAlleles=TRUE)

head(temp, 10)

length(temp)

#this code sets locnames with their alleles as a variable temp, and then heads (shows first 10 ouputs) those names and displays the length of them
#new names are "fca8.117" "fca8.119" "fca8.121" "fca8.123" "fca8.127" "fca8.129" "fca8.131" "fca8.133" "fca8.135" "fca8.137" and the amount of alleles, which is 108.

#Accessors make things easier. For instance, when setting new names for loci, the columns of @tab are renamed automatically: 
obj <- cats[sample(1:50,10)]

pop(obj)

#obj <- cats[sample(1:50,10)]
#pop(obj)
#it now shows the population of the object, which includes[1] P02 P02 P02 P02 P02 P02 P02 P02 P03 P04
#With Levels: P02 P03 P04
#what are levels? I think they are unrepeated populations within the object?

head(colnames(tab(obj)),20)
#prints out a table of columnn names...
#"fca8.117"  "fca8.119"  "fca8.121"  "fca8.123"  "fca8.127"  "fca8.129"  "fca8.131"  "fca8.133"  "fca8.135"  "fca8.137"  "fca8.139"  "fca8.141"  "fca8.143"  "fca8.145"  "fca8.147"  "fca8.149" 
#[17] "fca23.128" "fca23.130" "fca23.132" "fca23.136"

locNames(obj)
#locNames(obj) returns the names of the loci
#"fca8"  "fca23" "fca43" "fca45" "fca77" "fca78" "fca90" "fca96" "fca37"

locNames(obj)[1] <- "newLocusName"

locNames(obj) 

head(colnames(tab(obj)),20)

#locNames(obj)[1] <- "newLocusName"
#locNames(obj) 
#head(colnames(tab(obj)),20)
#this code lets us rename the loci
# "newLocusName.117" "newLocusName.119" "newLocusName.121" "newLocusName.123" "newLocusName.127" "newLocusName.129" "newLocusName.131" "newLocusName.133" "newLocusName.135" "newLocusName.137"
#[11] "newLocusName.139" "newLocusName.141" "newLocusName.143" "newLocusName.145" "newLocusName.147" "newLocusName.149" "fca23.128"        "fca23.130"        "fca23.132"        "fca23.136"       

##pop will check the length of the new group membership vector against the data and complain if there is a mismatch##
#slot pop also tells us how to find out about the populations that exist in the data set. 

head(pop(cats),50)
#head(pop(cats)50) tells us how many populations there are. There are 17 levels so 17 unique populations
#[1] P01 P01 P01 P01 P01 P01 P01 P01 P01 P01 P02 P02 P02 P02 P02 P02 P02 P02 P02 P02 P02 P02 P02 P02 P02 P02 P02 P02 P02 P02 P02 P02 P03 P03 P03 P03 P03 P03 P03 P03 P03 P03 P03 P03 P04 P04 P04 P04 P04
#[50] P04
#Levels: P01 P02 P03 P04 P05 P06 P07 P08 P09 P10 P11 P12 P13 P14 P15 P16 P17

table(pop(cats))
#table(pop(cats)) tells us the number of cats sampled per population. 
#P01 P02 P03 P04 P05 P06 P07 P08 P09 P10 P11 P12 P13 P14 P15 P16 P17 
#10  22  12  23  15  11  14  10   9  11  20  14  13  17  11  12  13 

barplot(table(pop(cats)), col=funky(17), las=3,
        
        xlab="Population", ylab="Sample size")

#barplot(table(pop(cats)), col=funky(17), las=3,
        #xlab="Population", ylab="Sample size")
#this code returns a barplot of the cat populations and their sample sizes. 

info_table(cats, plot =TRUE)
#info_table(cats, plot =TRUE) this inspects the amount of missing data in your data sets. 
#Population 11 with locus fca45 has 40% missing data. There is no data for population 17 at locus fca45. population11 has about 6% data missing across all loci. 

temp <- summary(cats)
#temp <- summary(cats) creates variable for a summary of cats, and contains the information returned. 

barplot(temp$loc.n.all, xlab="Locus", ylab="Number of alleles")

barplot(temp$pop.n.all, xlab="Population", ylab="Number of alleles",
        
        col=funky(17), las=3)

#barplot(temp$loc.n.all, xlab="Locus", ylab="Number of alleles")
#barplot(temp$pop.n.all, xlab="Population", ylab="Number of alleles",
         #col=funky(17), las=3)
#the difference between the two graphs is that the grey one shows the number of alleles per locus and the funky one shows the number of alleles per population. 
#locus fca37 had the most alleles, and population 11 had the most alleles. ill make the first plot colorful by adding the funky function

barplot(temp$loc.n.all, xlab="Locus", ylab="Number of alleles", 
        col=funky(9), las=3)

barplot(temp$pop.n.all, xlab="Population", ylab="Number of alleles",
        
        col=funky(17), las=3)
#made graph funky

plot(temp$Hexp, temp$Hobs, pch=20, cex=3, xlim=c(.4,1), ylim=c(.4,1))

abline(0,1,lty=2)

#plot(temp$Hexp, temp$Hobs, pch=20, cex=3, xlim=c(.4,1), ylim=c(.4,1))
#abline(0,1,lty=2)
#plotted the correlation between HWO and HWE... it seems there is no correlation and statistical test is not needed because they are obviously not in HWE

##Basic Population Genetic Analyses##
#in this portion of the lab, we try to assess the possibility of heterozygotic deficiency in population structure using classical population genetic tools. 

##testing for HWE##

hw.test(nancycats)
#hw.test(nancycats) is a function from the genind objects in the package pegas. 
#does not look like they are in HWE, the x^2 values are very large. 

##Assessing Population Structure##
#pop structure is usually assessed using F statistics and Fst, which measures population differentiation. 

fstat(cats)
fstat(cats,fstonly=TRUE)
#fstat(cats)
#fstat(cats,fstonly=TRUE)
#Should calculate the fst and f stat only. 























