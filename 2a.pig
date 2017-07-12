bag1 = load '/user/hive/warehouse/niit.db/h1bfinal' using PigStorage() as (sno:int,casestatus:chararray,employername:chararray,socname:chararray,jobtitle:chararray,fulltime:chararray,wage:int,year:chararray,worksite:chararray,longt:double,lat:double);
bag2 = filter bag1 by ($4 MATCHES '.*DATA ENGINEER.*');
bag3 = group bag2 by (year,worksite);
bag4 = foreach bag3 generate group,COUNT(bag2) as total;
bag5 = foreach bag4 generate FLATTEN(group.year),FLATTEN(group.worksite),FLATTEN(total);
bag6 = group bag5 by year;
top = foreach bag6 {
sorted = order bag5 by total desc;
top1 = limit sorted 1;
generate flatten(top1);
};
dump top;



