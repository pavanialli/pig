bag1= load '/user/hive/warehouse/niit.db/h1bfinal' using PigStorage('\t') as (sno:int,casestatus:chararray,employername:chararray,socname:chararray,jobtitle:chararray,fulltime:chararray,wage:int,year:chararray,worksite:chararray,longt:double,lat:double);

bag2 = foreach bag1 generate year,jobtitle,wage,fulltime;
bag3= filter bag2 by fulltime=='N';
bag4= group bag3 by (year,jobtitle);
bag5= foreach bag4 generate group,COUNT(bag3),SUM(bag3.wage);
bag6 = foreach bag5 generate FLATTEN($0),(double)$2/$1 as avg1;
bag7= order bag6 by avg1 desc;
dump bag7;
