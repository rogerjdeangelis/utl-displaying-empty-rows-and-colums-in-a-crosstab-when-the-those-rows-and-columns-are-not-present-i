Displaying empty rows and columns in a crosstab when the those rows or columns are not present in the data                               
                                                                                                                                         
Nice example of preloadfmt to fill crosstabs                                                                                             
                                                                                                                                         
This solution creates an output SAS dataset from tabulate in addition to the static tabulate report.                                     
                                                                                                                                         
github                                                                                                                                   
https://tinyurl.com/yy6lufy6                                                                                                             
https://github.com/rogerjdeangelis/utl-displaying-empty-rows-and-colums-in-a-crosstab-when-the-those-rows-and-columns-are-not-present-i  
                                                                                                                                         
SAS Forum                                                                                                                                
https://tinyurl.com/y3pcyvgo                                                                                                             
https://communities.sas.com/t5/Statistical-Procedures/proc-Freq-2-way-tables/m-p/674912                                                  
                                                                                                                                         
BallardW                                                                                                                                 
https://communities.sas.com/t5/user/viewprofilepage/user-id/13884                                                                        
                                                                                                                                         
Participants in two day special olympics                                                                                                 
                                                                                                                                         
Problem: My program produces                                                                                                             
                                                                                                                                         
--------------------                                                                                                                     
|      |   DAY2    |                                                                                                                     
|      |-----------|                                                                                                                     
|DAY1  |BILL |JOEL |                                                                                                                     
|------+-----+-----|                                                                                                                     
|BILL  |    1|    1|                                                                                                                     
|------+-----+-----|                                                                                                                     
|JOEL  |    0|    1|                                                                                                                     
|------+-----+-----|                                                                                                                     
|MARY  |    1|    1|                                                                                                                     
--------------------                                                                                                                     
                                                                                                                                         
But I want included all paticipents on both days                                                                                         
                                                                                                                                         
--------------------------------                                                                                                         
|      |         DAY2          |                                                                                                         
|      |-----------------------|                                                                                                         
|DAY1  |BILL |DAWN |JOEL |MARY |                                                                                                         
|------+-----+-----+-----+-----|                                                                                                         
|BILL  |    1|    0|    1|    0|                                                                                                         
|------+-----+-----+-----+-----|                                                                                                         
|DAWN  |    0|    0|    0|    0|                                                                                                         
|------+-----+-----+-----+-----|                                                                                                         
|JOEL  |    0|    0|    1|    0|                                                                                                         
|------+-----+-----+-----+-----|                                                                                                         
|MARY  |    1|    0|    1|    0|                                                                                                         
--------------------------------                                                                                                         
                                                                                                                                         
DAWN could not make the olympic games on day1 or day2 so she is not in then data.                                                        
Mary was not present at all on day2 and is not in the day2 data.                                                                         
                                                                                                                                         
Note: With a crosstab, preloadformat can only fill empty row and columns.                                                                
Tabulate will fill with zeors any row or column that has at least one cell with data.                                                    
                                                                                                                                         
/*                   _                                                                                                                   
(_)_ __  _ __  _   _| |_                                                                                                                 
| | `_ \| `_ \| | | | __|                                                                                                                
| | | | | |_) | |_| | |_                                                                                                                 
|_|_| |_| .__/ \__,_|\__|                                                                                                                
        |_|                                                                                                                              
*/                                                                                                                                       
                                                                                                                                         
data have;                                                                                                                               
  input  DAY1$    DAY2$;                                                                                                                 
cards4;                                                                                                                                  
BILL    BILL                                                                                                                             
BILL    JOEL                                                                                                                             
JOEL    JOEL                                                                                                                             
MARY    BILL                                                                                                                             
MARY    JOEL                                                                                                                             
;;;;                                                                                                                                     
run;quit;                                                                                                                                
                                                                                                                                         
* you need to tell tabulate about all the paticpants                                                                                     
  so that 'preloadformat can poulate missing rows and columns;                                                                           
                                                                                                                                         
proc format;                                                                                                                             
value $day                                                                                                                               
'JOEL' = 'JOEL'                                                                                                                          
'BILL' = 'BILL'                                                                                                                          
'MARY' = 'MARY'                                                                                                                          
'DAWN' = 'DAWN'                                                                                                                          
;                                                                                                                                        
run;                                                                                                                                     
                                                                                                                                         
/*           _               _                                                                                                           
  ___  _   _| |_ _ __  _   _| |_                                                                                                         
 / _ \| | | | __| `_ \| | | | __|                                                                                                        
| (_) | |_| | |_| |_) | |_| | |_                                                                                                         
 \___/ \__,_|\__| .__/ \__,_|\__|                                                                                                        
                |_|                                                                                                                      
*/                                                                                                                                       
                                                                                                                                         
SAS TABLE                                                                                                                                
=========                                                                                                                                
                                                                                                                                         
WORK.WANT total obs=4                                                                                                                    
                                                                                                                                         
  DAY1    BILL    DAWN    JOEL    MARY                                                                                                   
                                                                                                                                         
  BILL      1       0       1       0                                                                                                    
  DAWN      0       0       0       0                                                                                                    
  JOEL      0       0       1       0                                                                                                    
  MARY      1       0       1       0                                                                                                    
                                                                                                                                         
                                                                                                                                         
STATIC TABULATE OUTPUT                                                                                                                   
======================                                                                                                                   
                                                                                                                                         
--------------------------------                                                                                                         
|      |         DAY2          |                                                                                                         
|      |-----------------------|                                                                                                         
|      |BILL |DAWN |JOEL |MARY |                                                                                                         
|------+-----+-----+-----+-----|                                                                                                         
|DAY1  |     |     |     |     |                                                                                                         
|------|     |     |     |     |                                                                                                         
|BILL  |    1|    0|    1|    0|                                                                                                         
|------+-----+-----+-----+-----|                                                                                                         
|DAWN  |    0|    0|    0|    0|                                                                                                         
|------+-----+-----+-----+-----|                                                                                                         
|JOEL  |    0|    0|    1|    0|                                                                                                         
|------+-----+-----+-----+-----|                                                                                                         
|MARY  |    1|    0|    1|    0|                                                                                                         
--------------------------------                                                                                                         
                                                                                                                                         
/*                                                                                                                                       
 _ __  _ __ ___   ___ ___  ___ ___                                                                                                       
| `_ \| `__/ _ \ / __/ _ \/ __/ __|                                                                                                      
| |_) | | | (_) | (_|  __/\__ \__ \                                                                                                      
| .__/|_|  \___/ \___\___||___/___/                                                                                                      
|_|                                                                                                                                      
*/                                                                                                                                       
                                                                                                                                         
                                                                                                                                         
data have;                                                                                                                               
  input  DAY1$    DAY2$;                                                                                                                 
cards4;                                                                                                                                  
BILL    BILL                                                                                                                             
BILL    JOEL                                                                                                                             
JOEL    JOEL                                                                                                                             
MARY    BILL                                                                                                                             
MARY    JOEL                                                                                                                             
;;;;                                                                                                                                     
run;quit;                                                                                                                                
                                                                                                                                         
                                                                                                                                         
STATIC TABULATE OUTPUT                                                                                                                   
======================                                                                                                                   
                                                                                                                                         
options FORMCHAR='|----|+|---+=|-/\<>*';                                                                                                 
proc tabulate data=have;                                                                                                                 
   class day1 day2/ preloadfmt  missing;                                                                                                 
   format day1 day2 $day. ;                                                                                                              
   table day1,                                                                                                                           
         day2*n=' '*f=5.                                                                                                                 
         /printmiss misstext='0' rts=8                                                                                                   
   ;                                                                                                                                     
run;                                                                                                                                     
                                                                                                                                         
SAS TABLE                                                                                                                                
=========                                                                                                                                
                                                                                                                                         
%utl_odsrpt(setup);                                                                                                                      
options FORMCHAR='|----|+|---+=|-/\<>*';                                                                                                 
proc tabulate data=have;                                                                                                                 
   class day1 day2/ preloadfmt  missing;                                                                                                 
   format day1 day2 $day. ;                                                                                                              
   table day1="",                                                                                                                        
         day2=""*n=' '*f=5.                                                                                                              
         /printmiss misstext='0' rts=8 box="Day1"                                                                                        
   ;                                                                                                                                     
run;                                                                                                                                     
%utl_odsrpt(outdsn=want);                                                                                                                
                                                                                                                                         
                                                                                                                                         
