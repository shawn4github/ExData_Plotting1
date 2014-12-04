***  
## [Course Project 1 - Read Me] Exploratory Data Analysis
### Data Science Specialization on Coursera
***  
**Ian Huang**     
shuang4csa@hotmail.com    

***  
#### Introduction
***
This assignment uses data from
the <a href="http://archive.ics.uci.edu/ml/">UC Irvine Machine
Learning Repository</a>, a popular repository for machine learning
datasets. In particular, we will be using the "Individual household
electric power consumption Data Set" which can be found on
the course web site:

* <b>Dataset</b>: <a href="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip">Electric power consumption</a> [20Mb]

***
####The final project includes the following files 
***  
* 'README.md': The document you are currently reading
* 'plot1.png','plot2.png','plot3.png','plot4.png': Plots graphics saved in .png format
* 'plot1.R','plot2.R','plot3.R','plot4.R': Scripts to make plots via base plotting functions
* 'WhiteBG_FIG' folder: Contains plotted figures saved with white background      
* 'TranspBG_FIG' folder: Contains plotted figures saved with transparent background      

***
####How to run these R Scripts      
***
1. Download 'plot1.R','plot2.R','plot3.R' and 'plot4.R', save them to anywhere on your local machine.
2. (Optional) Make sure the original data source file ('household_power_consumption.txt') is in your working directory.
3. Open RStudio.
4. Install and load 'data.table' package to R if necessary.
5. Source these R Scripts one by one.
6. These R Scripts will first check whether you have the original data source file ('household_power_consumption.txt') in your working directory.    
7. If it does not exist, it will start downloading 'household_power_consumption.zip' file automatically from the designated URL and unzip to your working directory; otherwise it would use your previously downloaded data source file for later data plotting.
8. The plotted .png files will be generated and saved in your working directory.     

For more detailed procedures, please view the documentation in these R Scripts.

***
####Notes
***
1. Development environment for 'run_analysis.R'    
        - Windows 7, 64-bit OS   
        - R version 3.1.2   
        - RStudio Version 0.98.1049   
2. Depending on your local machine and internet connection speed, the downloading time for 'household_power_consumption.zip' may vary.         
3. The PNG graphics device supports transparent backgrounds when use "bg='transparent'". But not all PNG viewers render files with transparency correctly (All the files under 'TranspBG_FIG' folder has been tested OK only on Internet Explorer 11). 

For more information about this dataset contact: 
shuang4csa@hotmail.com