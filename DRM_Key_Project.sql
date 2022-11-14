select top 10 * from salesLT.Log_Fimplus_MovieID
select top 10 * from salesLT.Log_Get_DRM_List
select top 10 * from salesLT.MV_PropertiesShowVN
select top 10 * from SalesLT.Customers
select top 10 * from SalesLT.CustomerService

select top 10 CustomerID, MovieID, Date from salesLT.Log_BHD_MovieID
select top 10 CustomerID, MovieID, Date from salesLT.Log_Fimplus_MovieID

select top 10 CustomerID, MovieID, Date from salesLT.Log_BHD_MovieID b
left join salesLT.MV_PropertiesShowVN a
on a.id=b.MovieID
where isDRM=1

Select CustomerID, cast(Date as date) from SalesLT.Log_Get_DRM_List
select top 10 * from SalesLT.Customers

Select count(distinct(CustomerID)) As total_key, 'PhimGoi' As Service, Date from(
Select L.CustomerID, L.Date from SalesLT.Log_Get_DRM_List L
left join SalesLT.CustomerService S on L.CustomerID= S.CustomerID
where ServiceID in (60,89,148,149,150,154) ) C
group by Date


-- Create summary of number of phim theo loai per day
WITH phimle_cophi AS (
Select count(distinct(customerID)) As total_key, 'BHD' as Service, cast(Date as date) AS Date from (select CustomerID, MovieID, Date from SalesLT.Log_Fimplus_MovieID b
left join salesLT.MV_PropertiesShowVN a
on a.id=b.MovieID
where isDRM=1) A
group by cast(Date as date)
UNION
Select count(distinct(customerID)) As total_key, 'FIM+' as Service, cast(Date as date) AS Date from (select CustomerID, MovieID, Date from salesLT.Log_BHD_MovieID b
left join salesLT.MV_PropertiesShowVN a
on a.id=b.MovieID
where isDRM=1) B
group by cast(Date as date)),
phimgoi_cophi AS (
Select count(distinct(CustomerID)) As total_key, 'PhimGoi' As Service, Date from(
Select L.CustomerID, L.Date from SalesLT.Log_Get_DRM_List L
left join SalesLT.CustomerService S on L.CustomerID= S.CustomerID
where ServiceID in (60,89,148,149,150,154) ) C
group by Date)


select date, sum(total_key) from(

select * from phimgoi_cophi
union
select * from phimle_cophi) E
group by date


Select count(distinct(customerID)) As total_key, 'BHD' as Service, cast(Date as date) AS Date from (select CustomerID, MovieID, Date from SalesLT.Log_Fimplus_MovieID b
left join salesLT.MV_PropertiesShowVN a
on a.id=b.MovieID
where isDRM=1) A
group by cast(Date as date)
UNION
Select count(distinct(customerID)) As total_key, 'FIM+' as Service, cast(Date as date) AS Date from (select CustomerID, MovieID, Date from salesLT.Log_BHD_MovieID b
left join salesLT.MV_PropertiesShowVN a
on a.id=b.MovieID
where isDRM=1) B
group by cast(Date as date)
