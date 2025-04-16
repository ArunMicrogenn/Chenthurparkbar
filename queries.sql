create procedure Get__Authenticate

@name varchar(1000), @pass varchar(1000)
As

select * from username where username=@name and TPassword=@pass



create procedure Get__menu
As

select * from menu


create procedure Get__submenu
@menuid bigint 
As

select * from submenu where MNID=@menuid order by act asc

alter table submenu add des varchar(1000)

insert into submenu(submenu,MNID,act,des)values('Purchase Entry', 2, 1,'Purchase_Entry')



create procedure [dbo].[Get__Stockitem__mas]
@ID bigint = 0
As

select * from Stock_itemmmas where Itemid=(case when @ID=0 then Itemid else @ID end) order by itemid asc


create FUNCTION [dbo].[entryno]()

RETURNS varchar(2000) AS  BEGIN

DECLARE @STRN VARCHAR(5000);
DECLARE @STR VARCHAR(5000);
DECLARE @STR2 VARCHAR(5000);
DECLARE @code VARCHAR(5000);
DECLARE @Date1 VARCHAR(5000);
DECLARE @Date2 VARCHAR(5000);


IF isnull (@STRN,0) = 1
BEGIN

    SET @STR=(SELECT RIGHT('0000000000'+ (Convert(varchar(10),substring(max(entryno),4,13)+ 1)) ,10) from Trans_bar_purchasemas WHERE  len(entryno)=13)
    
    IF @STR IS NULL
    BEGIN
    SET @STR2 = '0000000001'
    SET @code ='PUR'
    END
    
    ELSE
    BEGIN
    SET @STR2 = (SELECT RIGHT('0000000000'+ (Convert(varchar(10),substring(max(entryno),4,13)+ 1)) ,10) from Trans_bar_purchasemas WHERE  len(entryno)=13)
    SET @code ='PUR'
    END
    
END
IF isnull(@STRN,0) <> '1'
BEGIN

    SET @STR=(SELECT RIGHT('00000'+ (Convert(varchar(10),substring(max(entryno),4,13)+ 1)) ,5) from Trans_bar_purchasemas WHERE len(entryno)=8)

    IF @STR IS NULL
    BEGIN
    SET @STR2 = '00001'
    SET @code ='PUR'
    END
    
    ELSE
    BEGIN
    SET @STR2 = (SELECT RIGHT('00000'+ (Convert(varchar(10),substring(max(entryno),4,13)+ 1)) ,5) from Trans_bar_purchasemas WHERE  len(entryno)=8)
    SET @code ='PUR'
    END
    
END
RETURN @code+@STR2
END




create procedure Get__supplier
@ID bigint=0
As

select * from supplier where supplierid=(case when @ID=0 then supplierid else @ID end) order by supplierid asc


	ALTER TABLE trans_bar_purchasemas ALTER COLUMN totalamount numeric(12,2)

Create PROCEDURE EXEC_PIURCHASE_MAS
@ENTRYNO VARCHAR(50), @ENTRYDATE DATETIME, @INVO VARCHAR(100),@INVDATE DATETIME,@SUPPELIERID BIGINT,
@AMOUNT NUMERIC(12,2),@ID BIGINT=0

AS

IF(@ID=0)
	BEGIN
		INSERT INTO trans_bar_purchasemas(ENTRYNO,ENTRYDATE,INVNO,INVDATE,SUPPLIERID,TOTALAMOUNT) VALUES(@ENTRYNO,@ENTRYDATE,@INVO,@INVDATE,@SUPPELIERID,@AMOUNT)
		SELECT 'SAVED' AS MGS, ident_current('Trans_bar_purchasemas') as id 
	END 

ELSE
	BEGIN
		UPDATE trans_bar_purchasemas SET ENTRYNO=@ENTRYNO,ENTRYDATE=@ENTRYDATE,INVNO=@INVO,INVDATE=@INVDATE,SUPPLIERID=@SUPPELIERID,TOTALAMOUNT=@AMOUNT WHERE PURID=@ID
		SELECT 'UPDATED' AS MGS, @ID as id
	END



alter table trans_bar_purchasedet add totalqty numeric(12,2)




create PROCEDURE EXEC_PURCHASE_DET
@PURID BIGINT, @ITEMID BIGINT,@CASES VARCHAR(10),@PURQTY BIGINT, 
@RATE NUMERIC(12,2),@ADDED NUMERIC(12,2)=0.00,@AMOUNT NUMERIC(12,2),@edit bigint =0,@totalqty numeric(12,2)

AS


--IF(@edit =1 )
--	BEGIN
--		DELETE FROM TRANS_BAR_PURCHASEDET WHERE PURID=@PURID
--	END


INSERT INTO TRANS_BAR_PURCHASEDET (PURID,ITEMID,CASES,PURQTY,RATE,ADDED,AMOUNT,totalqty)
VALUES(@PURID,@ITEMID,@CASES,@PURQTY,@RATE,@ADDED,@AMOUNT,@totalqty)

SELECT 'SUCCESS' AS MGS



create procedure Get_purchase_mas 
@ID bigint = 0
As

select * from trans_bar_purchasemas where purid=(case when @ID=0 then purid else @ID end) order by purid desc



create procedure Get_purchase_det 
@ID bigint = 0
As

select * from trans_bar_purchasedet where purid=(case when @ID=0 then purid else @ID end) order by purdetid asc


insert into submenu(submenu,MNID,act,des)values('Inward', 2, 2,'Inward')


create FUNCTION [dbo].[Inwardno]()

RETURNS varchar(2000) AS  BEGIN

DECLARE @STRN VARCHAR(5000);
DECLARE @STR VARCHAR(5000);
DECLARE @STR2 VARCHAR(5000);
DECLARE @code VARCHAR(5000);
DECLARE @Date1 VARCHAR(5000);
DECLARE @Date2 VARCHAR(5000);






IF isnull (@STRN,0) = 1
BEGIN

    SET @STR=(SELECT RIGHT('0000000000'+ (Convert(varchar(10),substring(max(entryno),4,13)+ 1)) ,10) from trans_bar_inwardmas WHERE  len(entryno)=13)
    
    IF @STR IS NULL
    BEGIN
    SET @STR2 = '0000000001'
    SET @code ='INB'
    END
    
    ELSE
    BEGIN
    SET @STR2 = (SELECT RIGHT('0000000000'+ (Convert(varchar(10),substring(max(entryno),4,13)+ 1)) ,10) from trans_bar_inwardmas WHERE  len(entryno)=13)
    SET @code ='INB'
    END
    
END
IF isnull(@STRN,0) <> '1'
BEGIN

    SET @STR=(SELECT RIGHT('00000'+ (Convert(varchar(10),substring(max(entryno),4,13)+ 1)) ,5) from trans_bar_inwardmas WHERE len(entryno)=8)

    IF @STR IS NULL
    BEGIN
    SET @STR2 = '00001'
    SET @code ='INB'
    END
    
    ELSE
    BEGIN
    SET @STR2 = (SELECT RIGHT('00000'+ (Convert(varchar(10),substring(max(entryno),4,13)+ 1)) ,5) from trans_bar_inwardmas WHERE  len(entryno)=8)
    SET @code ='INB'
    END
    
END
RETURN @code+@STR2
END



create procedure Get__Inwardmas

@ID bigint=0

As


select * from trans_bar_inwardmas where Inwid=(case when @ID=0 then inwid else @ID end) order by inwid desc




create procedure Get__Inwarddet

@ID bigint=0

As


select * from trans_bar_inwarddet where Inwid=(case when @ID=0 then inwid else @ID end) order by inwid asc







create PROCEDURE EXEC_INWARD_MAS
@ENTRYNO VARCHAR(50), @ENTRYDATE DATETIME, @REMARKS VARCHAR(100),@ID BIGINT=0

AS

IF(@ID=0)
	BEGIN
		INSERT INTO trans_bar_inwardmas(ENTRYNO,ENTRYDATE,Remarks) VALUES(@ENTRYNO,@ENTRYDATE,@REMARKS)
		SELECT 'SAVED' AS MGS, ident_current('Trans_bar_inwardmas') as id 
	END 

ELSE
	BEGIN
		UPDATE trans_bar_inwardmas SET ENTRYNO=@ENTRYNO,ENTRYDATE=@ENTRYDATE,Remarks=@REMARKS WHERE Inwid=@ID
		SELECT 'UPDATED' AS MGS, @ID as id
	END



create PROCEDURE EXEC_INWARD_DET
@INWID BIGINT, @ITEMID BIGINT,@QTY BIGINT, @QTYBOTT BIGINT

AS



INSERT INTO TRANS_BAR_INWARDDET (INWID,ITEMID,QTY,QTYBTL)VALUES(@INWID,@ITEMID,@QTY,@QTYBOTT)

SELECT 'SUCCESS' AS MGS


insert into submenu(submenu,MNID,act,des)values('Stock Adjustment', 2, 3,'Adjustment')


alter table trans_bar_stockadjustmentdet add computerstock numeric(12,2)
alter table trans_bar_stockadjustmentdet add physicalstock numeric(12,2)

alter table trans_bar_stockadjustmentdet add mltype numeric(12,2)



create PROCEDURE EXEC_ADJUSTMENT_DET
@Adjid BIGINT, @Itemid BIGINT,@Qty BIGINT,@computerstock numeric(12,2),@physicalstock numeric(12,2),@mltype numeric(12,2)

AS

declare @addorless varchar(2)

if(@Qty < 0)
	begin
		set @addorless = '-'
	end
else
	begin
		set @addorless = '+'
	end
INSERT INTO trans_bar_stockadjustmentdet(adjid,ITEMID,QTY,computerstock,physicalstock,mltype,addorless)
VALUES(@Adjid,@Itemid,abs(@Qty),@computerstock,@physicalstock,@mltype,@addorless)

SELECT 'SUCCESS' AS MGS





create PROCEDURE EXEC_ADJUSTMENT_MAS
@ENTRYNO VARCHAR(50), @ENTRYDATE DATETIME,@BARORSTORE varchar(2), @REMARKS VARCHAR(100),@ID BIGINT=0

AS

IF(@ID=0)
	BEGIN
		INSERT INTO trans_bar_stockadjustmentmas(ENTRYNO,ENTRYDATE,BAROORSTORE,Remarks) VALUES(@ENTRYNO,@ENTRYDATE,@BARORSTORE,@REMARKS)
		SELECT 'SAVED' AS MGS, ident_current('trans_bar_stockadjustmentmas') as id 
	END 

ELSE
	BEGIN
		UPDATE trans_bar_stockadjustmentmas SET ENTRYNO=@ENTRYNO,ENTRYDATE=@ENTRYDATE,Remarks=@REMARKS,BAROORSTORE=@BARORSTORE WHERE Adjid=@ID
		SELECT 'UPDATED' AS MGS, @ID as id
	END


create FUNCTION [dbo].[Adjno]()

RETURNS varchar(2000) AS  BEGIN

DECLARE @STRN VARCHAR(5000);
DECLARE @STR VARCHAR(5000);
DECLARE @STR2 VARCHAR(5000);
DECLARE @code VARCHAR(5000);
DECLARE @Date1 VARCHAR(5000);
DECLARE @Date2 VARCHAR(5000);






IF isnull (@STRN,0) = 1
BEGIN

    SET @STR=(SELECT RIGHT('0000000000'+ (Convert(varchar(10),substring(max(entryno),4,13)+ 1)) ,10) from trans_bar_stockadjustmentmas WHERE  len(entryno)=13)
    
    IF @STR IS NULL
    BEGIN
    SET @STR2 = '0000000001'
    SET @code ='ADJ'
    END
    
    ELSE
    BEGIN
    SET @STR2 = (SELECT RIGHT('0000000000'+ (Convert(varchar(10),substring(max(entryno),4,13)+ 1)) ,10) from trans_bar_stockadjustmentmas WHERE  len(entryno)=13)
    SET @code ='ADJ'
    END
    
END
IF isnull(@STRN,0) <> '1'
BEGIN

    SET @STR=(SELECT RIGHT('00000'+ (Convert(varchar(10),substring(max(entryno),4,13)+ 1)) ,5) from trans_bar_stockadjustmentmas WHERE len(entryno)=8)

    IF @STR IS NULL
    BEGIN
    SET @STR2 = '00001'
    SET @code ='ADJ'
    END
    
    ELSE
    BEGIN
    SET @STR2 = (SELECT RIGHT('00000'+ (Convert(varchar(10),substring(max(entryno),4,13)+ 1)) ,5) from trans_bar_stockadjustmentmas WHERE  len(entryno)=8)
    SET @code ='ADJ'
    END
    
END
RETURN @code+@STR2
END





create procedure Get__adjustmentdet

@ID bigint=0

As


select * from trans_bar_stockadjustmentdet where Adjid=(case when @ID=0 then Adjid else @ID end) order by Adjdetid asc



create procedure Get__adjustmentmas

@ID bigint=0

As


select * from trans_bar_stockadjustmentmas where Adjid=(case when @ID=0 then Adjid else @ID end) order by Adjid asc



insert into submenu(submenu,MNID,act,des)values('Tax Type', 1, 1,'Add_taxType')

insert into submenu(submenu,MNID,act,des)values('Item Category', 1, 2,'Add_itemCategory')

insert into submenu(submenu,MNID,act,des)values('Fire Master', 1, 3,'Add_fireMaster')

insert into submenu(submenu,MNID,act,des)values('NC KOT', 1, 4,'Add_nonChangeKOT')

insert into submenu(submenu,MNID,act,des)values('NC Account', 1, 5,'Add_nonChargeAccount')

insert into submenu(submenu,MNID,act,des)values('Table Group', 1, 6,'Add_TableGroup')

insert into submenu(submenu,MNID,act,des)values('Table', 1, 7,'Add_TableMaster')




CREATE Procedure [dbo].[Get_FireGroup] @ID BIGINT=0 as BEGIN 
Select Fireid,Firename from mas_fire
WHERE Fireid  =(CASE WHEN @ID=0 THEN Fireid ELSE @ID END ) order by Fireid desc END



CREATE PROCEDURE [dbo].[Get_FireMaster] @ID BIGINT=0 as 
BEGIN  
SELECT * FROM  mas_fire
WHERE Fireid  =(CASE WHEN @ID=0 THEN Fireid ELSE @ID END ) order by Fireid END



CREATE PROCEDURE [dbo].[Get_ItemCategory] @ID BIGINT=0 as 
BEGIN  
SELECT * FROM Itemcategory c 
INNER JOIN Mas_accountledger  s ON s.accledgerid = c.accledgerid
WHERE itemcategoryid  =(CASE WHEN @ID=0 THEN itemcategoryid ELSE @ID END ) order by itemcategoryid desc END




CREATE PROCEDURE [dbo].[Get_NonchangeKOT] @ID BIGINT=0 as 
BEGIN  
SELECT * FROM Mas_nckottype
WHERE typeid  =(CASE WHEN @ID=0 THEN typeid ELSE @ID END ) order by typeid desc END



CREATE PROCEDURE [dbo].[Get_NonChargeAccount] @ID BIGINT=0 as 
BEGIN  
SELECT * FROM Mas_nckotaccount c 
INNER JOIN Mas_nckottype  s ON s.typeid = c.typeid
WHERE accid  =(CASE WHEN @ID=0 THEN accid ELSE @ID END ) order by accid desc END




create PROCEDURE [dbo].[Get_TableGroup] @ID BIGINT=0 as 

BEGIN  
 SELECT * FROM Table_Group
					WHERE tablegroup_id  =(CASE WHEN @ID=0 THEN tablegroup_id ELSE @ID END ) order by tablegroup_id desc END


ALTER TABLE Table_Group ADD orderby BIGINT,inactive BIGINT



CREATE PROCEDURE [dbo].[Get_TableMaster] @ID BIGINT=0 as 

BEGIN  
SELECT * FROM Tablemas c 
                     INNER JOIN Table_Group  s ON s.tablegroup_id = c.tablegroupid
					WHERE Tableid  =(CASE WHEN @ID=0 THEN Tableid ELSE @ID END ) order by Tableid desc END



CREATE PROCEDURE [dbo].[Get_TableMasters] @ID BIGINT=0 as 

BEGIN  
 SELECT * FROM Table_Group
                   
					WHERE tablegroup_id  =(CASE WHEN @ID=0 THEN tablegroup_id ELSE @ID END ) order by tablegroup_id desc END




CREATE PROCEDURE [dbo].[Exec_FireMaster] 
@Firename VARCHAR (100) ,
@orderby BIGINT,
@uid BIGINT=0,@SType VARCHAR(100) AS 
BEGIN
 IF @SType = 'SAVE'
	BEGIN
	  INSERT INTO dbo.mas_fire (Firename, orderby)
      VALUES (@Firename, @orderby)
	 SELECT 'Successfully Saved' AS MGS
	END 
	
  IF @SType = 'UPDATE'
  BEGIN
    
 UPDATE dbo.mas_fire
SET  
	Firename= @Firename,
	 
	
	orderby = @orderby 
	
  WHERE  Fireid = @uid

   
    SELECT 'Successfully Updated' AS MGS
    
  END
  
  IF @SType = 'DELETE'
  BEGIN
    
   
    SELECT 'Successfully Deleted' AS MGS
    
  END
  END




CREATE PROCEDURE [dbo].[Exec_ItemCategory] 
 @itemcategory VARCHAR (100) ,
 @accledgerid BIGINT,
 @uid BIGINT=0,@SType VARCHAR(100) AS 
 
 BEGIN
 
  IF @SType = 'SAVE'
	BEGIN
	  INSERT INTO dbo.Itemcategory (itemcategory, accledgerid)
      VALUES (@itemcategory, @accledgerid)
	 SELECT 'Successfully Saved' AS MGS
	END 
	
  IF @SType = 'UPDATE'
  BEGIN
    
 UPDATE dbo.Itemcategory
SET  
	itemcategory= @itemcategory,
	 
	
	accledgerid = @accledgerid
	
  WHERE  itemcategoryid = @uid

   
    SELECT 'Successfully Updated' AS MGS
    
  END
  
  IF @SType = 'DELETE'
  BEGIN
    
   
    SELECT 'Successfully Deleted' AS MGS
    
  END
  END



CREATE PROCEDURE [dbo].[Exec_NonchangeKOT] 
 @typename VARCHAR (100) ,

 @uid BIGINT=0,@SType VARCHAR(100) AS 
 
 BEGIN
 
  IF @SType = 'SAVE'
	BEGIN
	  INSERT INTO dbo.Mas_nckottype (typename)
      VALUES (@typename)
	 SELECT 'Successfully Saved' AS MGS
	END 
	
  IF @SType = 'UPDATE'
  BEGIN
    
 UPDATE dbo.Mas_nckottype
SET  
	typename = @typename
	
  WHERE  typeid = @uid

   
    SELECT 'Successfully Updated' AS MGS
    
  END
  
  IF @SType = 'DELETE'
  BEGIN
    
   
    SELECT 'Successfully Deleted' AS MGS
    
  END
  END




CREATE PROCEDURE [dbo].[Exec_NonChargeAccount] 
 @accountname VARCHAR (100) ,
 @typeid BIGINT,
 @uid BIGINT=0,@SType VARCHAR(100) AS 
 
 BEGIN
 
  IF @SType = 'SAVE'
	BEGIN
	  INSERT INTO dbo.Mas_nckotaccount (accountname, typeid)
      VALUES (@accountname, @typeid)
	 SELECT 'Successfully Saved' AS MGS
	END 
	
  IF @SType = 'UPDATE'
  BEGIN
    
 UPDATE dbo.Mas_nckotaccount
SET  
	accountname= @accountname,
	 
	
	typeid = @typeid
	
  WHERE  accid = @uid

   
    SELECT 'Successfully Updated' AS MGS
    
  END
  
  IF @SType = 'DELETE'
  BEGIN
    
   
    SELECT 'Successfully Deleted' AS MGS
    
  END
  END




CREATE PROCEDURE [dbo].[Exec_TableGroup] 
 @Groupname VARCHAR (100) ,
@orderby BIGINT,
 @inactive BIGINT,
 @uid BIGINT=0,@SType VARCHAR(100) AS 
 
 BEGIN
 
  IF @SType = 'SAVE'
	BEGIN
	  INSERT INTO dbo.Table_Group (Groupname, orderby,inactive)
      VALUES (@Groupname, @orderby, @inactive)
	 SELECT 'Successfully Saved' AS MGS
	END 
	
  IF @SType = 'UPDATE'
  BEGIN
    
 UPDATE dbo.Table_Group
SET  
	Groupname= @Groupname,
	 
	orderby = @orderby,
	inactive = @inactive
	
  WHERE  tablegroup_id = @uid

   
    SELECT 'Successfully Updated' AS MGS
    
  END
  
  IF @SType = 'DELETE'
  BEGIN
    
   
    SELECT 'Successfully Deleted' AS MGS
    
  END
  END


CREATE PROCEDURE [dbo].[Exec_TaxType] 
 @taxtype VARCHAR (100) ,
 @shortname VARCHAR (100),
 @uid BIGINT=0,@SType VARCHAR(100) AS 
 
 BEGIN
 
  IF @SType = 'SAVE'
	BEGIN
	  INSERT INTO dbo.taxtype (taxtype, shortname)
      VALUES (@taxtype, @shortname)
	 SELECT 'Successfully Saved' AS MGS
	END 
	
  IF @SType = 'UPDATE'
  BEGIN
    
 UPDATE dbo.taxtype
SET  
	taxtype= @taxtype,
	 
	
	shortname = @shortname
	
  WHERE  taxid = @uid

   
    SELECT 'Successfully Updated' AS MGS
    
  END
  
  IF @SType = 'DELETE'
  BEGIN
    
   
    SELECT 'Successfully Deleted' AS MGS
    
  END
  END


CREATE PROCEDURE [dbo].[Exec_TableMaster] 
 @Tablename VARCHAR (100) ,
 @ServiceTax VARCHAR(100),
 @ord BIGINT,
 @tablegroupid VARCHAR (100),

 @uid BIGINT=0,@SType VARCHAR(100) AS 
 
 BEGIN
 
  IF @SType = 'SAVE'
	BEGIN
	  INSERT INTO dbo.Tablemas (Tablename, ServiceTax,ord,tablegroupid)
      VALUES (@Tablename, @ServiceTax, @ord, @tablegroupid)
	 SELECT 'Successfully Saved' AS MGS
	END 
	
  IF @SType = 'UPDATE'
  BEGIN
    
 UPDATE dbo.Tablemas
SET  
	Tablename= @Tablename,
	 
	
	ServiceTax = @ServiceTax,
	
	
	
	ord= @ord,

	tablegroupid=@tablegroupid
	
  WHERE  Tableid = @uid

   
    SELECT 'Successfully Updated' AS MGS
    
  END
  
  IF @SType = 'DELETE'
  BEGIN
    
   
    SELECT 'Successfully Deleted' AS MGS
    
  END
  	
 
 END






alter PROCEDURE [dbo].[Exec_TaxType] 
 @taxtype VARCHAR (100) ,
 @shortname VARCHAR (100),
 @uid BIGINT=0,@SType VARCHAR(100) AS 
 
 BEGIN
 
  IF @SType = 'SAVE'
	BEGIN
	  INSERT INTO dbo.taxtype (taxtype, shortname)
      VALUES (@taxtype, @shortname)
	 SELECT 'Successfully Saved' AS MGS
	END 
	
  IF @SType = 'UPDATE'
  BEGIN
    
 UPDATE dbo.taxtype
SET  
	taxtype= @taxtype,
	 
	
	shortname = @shortname
	
  WHERE  taxid = @uid

   
    SELECT 'Successfully Updated' AS MGS
    
  END
  
  IF @SType = 'DELETE'
  BEGIN
    
   
    SELECT 'Successfully Deleted' AS MGS
    
  END
  END



CREATE PROCEDURE [dbo].[Get_TaxType] @ID BIGINT=0 as 

BEGIN  
 SELECT * FROM  taxtype
                     
WHERE taxid  =(CASE WHEN @ID=0 THEN taxid ELSE @ID END ) order by taxid END




alter table employee add isfa varchar(1000)





ALTER TABLE Stock_itemmmas
ADD Taxsetupid BIGINT

ALTER TABLE itemgroup
ADD inactive BIGINT


ALTER TABLE supplier
ADD inactive BIGINT

ALTER TABLE Bar_itemmmas
ADD hsncode BIGINT

ALTER TABLE Bar_itemmmas
ADD Discountres BIGINT
 



ALTER Procedure [dbo].[Get_Mlmaster] @ID BIGINT=0 as BEGIN 
Select Mlqty,Mltype,MlDescription,inactive,Mlid from Barmltype

WHERE Mlid  =(CASE WHEN @ID=0 THEN Mlid ELSE @ID END ) order by Mlid desc END



ALTER Procedure [dbo].[Get_ItemGroup] @ID BIGINT=0 as BEGIN 
Select ig.inactive,taxsetupname,itemcategory,ig.Itemgroupid,ig.Itemgroup,ig.ORDBY,ig.percentage,ig.nccostperc,ig.Itemcategoryid,ig.taxsetupid,ig.Barorfood,ig.Itemgroup,ig.isimport,ig.icecreamorfood,ig.hotitems,ig.beeritems,ig.otheritems from itemgroup ig
inner join  Itemcategory ic on ic.itemcategoryid=ig.Itemcategoryid
inner join taxsetupmas tsm on tsm.Taxsetupid=ig.taxsetupid
WHERE Itemgroupid  =(CASE WHEN @ID=0 THEN itemgroupid ELSE @ID END ) order by Itemgroupid desc END



ALTER Procedure [dbo].[Get_Supplier] @ID BIGINT=0 as BEGIN 
Select City,* from Supplier ms
inner join  Mas_City mc on mc.City_Id=ms.Cityid
WHERE Supplierid  =(CASE WHEN @ID=0 THEN Supplierid ELSE @ID END ) order by Supplierid desc END



CREATE Procedure [dbo].[Get_City] @ID BIGINT=0 as BEGIN 
Select *from Mas_City
WHERE City_Id =(CASE WHEN @ID=0 THEN City_Id ELSE @ID END )  END




ALTER Procedure [dbo].[Get_FireGroup] @ID BIGINT=0 as BEGIN 
Select Fireid,Firename from mas_fire

WHERE Fireid  =(CASE WHEN @ID=0 THEN Fireid ELSE @ID END ) order by Fireid desc END



create Procedure [dbo].[Get_EmployeeMaster] @ID BIGINT=0 as BEGIN 
Select Employee,Employeeid,iscapttion,isfa,istabsteward,inactive from Employee
WHERE Employeeid  =(CASE WHEN @ID=0 THEN Employeeid ELSE @ID END ) order by Employeeid desc END




create Procedure [dbo].[Get_BarItemMaster] @ID BIGINT=0 as BEGIN 
Select Firename,bm.orderby,bm.BarItemid,bm.BarItemcode,bm.inactive,bm.Rate,bm.orderby,bm.Discountres,bm.hsncode,bm.roomrate,bm.costperc,bm.salesvalue,bm.iscocktail,bm.Fireid,bm.BarItemname,bm.ml,bm.StoreItemid from Bar_itemmmas bm
inner join  mas_fire mf on mf.Fireid= bm.Fireid
WHERE BarItemid  =(CASE WHEN @ID=0 THEN BarItemid ELSE @ID END ) order by BarItemid desc END




CREATE PROCEDURE [dbo].[Exec_BarItemMaster]
 @BarItemid BIGINT,
 @Baritemcode NVARCHAR(100),
 @storeitemid BIGINT,
 @qty BIGINT,
 @IDD NVARCHAR(10),@SType VARCHAR(100) AS 

 
 BEGIN
 DECLARE @BarItemname NVARCHAR(100),@Rate BIGINT,@Fireid NVARCHAR(100),@iscocktail NVARCHAR(100), @salesvalue NVARCHAR(100),@costperc NVARCHAR(100),@roomrate NVARCHAR(100),@orderby NVARCHAR(100),@hsncode NVARCHAR(100),@Discountres NVARCHAR(100),@inactive BIGINT
 

  IF @SType = 'SAVE'
	BEGIN

	 INSERT INTO  Bar_itemmmas (BarItemcode,BarItemname,Rate,Fireid,iscocktail,salesvalue,costperc,roomrate,orderby,hsncode,Discountres)
     values(@BarItemcode,@BarItemname,@Rate,@Fireid,@iscocktail,@salesvalue,@costperc,@roomrate,@orderby,@hsncode,@Discountres)

	  SET @BarItemid = SCOPE_IDENTITY()

	  INSERT INTO bar_itemdet_id (RefBarItemid,Baritemcode,storeitemid,qty)
	  VALUES ( @BarItemid,@Baritemcode,@storeitemid,@qty)
	  
	 SELECT 'Successfully Saved' AS MGS
	END 

  IF @SType = 'UPDATE'
  BEGIN

    UPDATE Bar_itemmmas 
SET 
	BarItemcode = @Baritemcode,BarItemname=@BarItemname,Rate=@Rate,Fireid=@Fireid,iscocktail=@iscocktail,salesvalue=@salesvalue,costperc=@costperc,roomrate=@roomrate,orderby=@orderby,hsncode=@hsncode, Discountres=@Discountres,inactive=@inactive WHERE @BarItemid = @IDD   
 
    	

  DELETE FROM bar_itemdet_id WHERE RefBarItemid=@IDD
   
 INSERT INTO bar_itemdet_id (RefBarItemid,Baritemcode,storeitemid,qty)
    VALUES ( @BarItemid,@Baritemcode,@storeitemid,@qty)

    SELECT 'Successfully Updated' AS MGS 
	
 END
 END 


 



create Procedure [dbo].[Get_StoreMaster] @ID BIGINT=0 as BEGIN 
Select Itemid,Itemname from Stock_itemmmas ig
WHERE Itemid  =(CASE WHEN @ID=0 THEN Itemid ELSE @ID END ) order by Itemid desc END



create Procedure [dbo].[Get_StoreItemMaster] @ID BIGINT=0 as BEGIN 
Select Itemgroup, ig.Itemcode,ig.Itemname,ig.Rate,ig.bottpercase,ig.mlperbottle,ig.Itemgroupid,ig.sTKRATE,ig.salrate,ig.addedval,ig.addedper,ig.orderby,ig.pegml,ig.Taxsetupid,ig.Itemid,ig.inactive from Stock_itemmmas ig
inner join  itemgroup ic on ic.Itemgroupid=ig.Itemgroupid
WHERE Itemid  =(CASE WHEN @ID=0 THEN Itemid ELSE @ID END ) order by Itemid desc END


insert into submenu(submenu,MNID,act,des)values('Bar Item', 1, 9,'Add_BarItemMaster')
insert into submenu(submenu,MNID,act,des)values('Employee', 1, 11,'Add_EmployeeMaster')
insert into submenu(submenu,MNID,act,des)values('ML', 1, 12,'Add_MLMaster')
insert into submenu(submenu,MNID,act,des)values('Supplier', 1, 13,'Add_Supplier')
insert into submenu(submenu,MNID,act,des)values('Store Item', 1, 10,'Add_StoreItemMaster')
insert into submenu(submenu,MNID,act,des)values('Item Group', 1, 8,'Add_ItemGroup')

CREATE PROCEDURE [dbo].[Get_TableMasterzzz] @ID BIGINT=0 as 

BEGIN  
SELECT * FROM Table_Group 
                    
WHERE tablegroup_id  =(CASE WHEN @ID=0 THEN  tablegroup_id ELSE @ID END ) order by  tablegroup_id desc END


CREATE PROCEDURE [dbo].[Get_Get_TableGroupz] @ID BIGINT=0 as 
BEGIN  
select * from Table_Group
WHERE tablegroup_id  =(CASE WHEN @ID=0 THEN  tablegroup_id ELSE @ID END ) order by  tablegroup_id desc END



CREATE PROCEDURE [dbo].[Get_ItemCategorys] @ID BIGINT=0 as 
BEGIN  
SELECT * FROM Mas_accountledger
WHERE accledgerid  =(CASE WHEN @ID=0 THEN accledgerid ELSE @ID END ) order by accledgerid desc END


== 18.10.2023===


update menu set menu='Reports' where  UCID=3



insert into submenu (submenu,mnid,act,des) values('Kot Bill Cancellation',3,1,'KotBill_cancellation')
insert into submenu (submenu,mnid,act,des) values('NC-Kot Type',3,2,'NCKotType')
insert into submenu (submenu,mnid,act,des) values('Discount',3,3,'Discount')
insert into submenu (submenu,mnid,act,des) values('As On Date Sales ',3,7,'SalesReport')



create procedure Get__Taxsetup
@ID bigint=0
As

select * from taxsetupmas where taxsetupid=(case when @ID=0 then taxsetupid else @ID  end)


insert into submenu(submenu,MNID,act,des)values('Tax Setup', 1, 14,'TaxSetup')


create procedure Get__Taxtype
@ID bigint=0

As

select * from taxtype where taxid=(case when @ID=0 then taxid else @ID end) and isnull(inactive,0)<>1



create table temp__taxmas(masid int identity(1,1) primary key , taxsetupid bigint, percentage numeric(12,2))

create table temp__taxdet(detid int identity(1,1) primary key , masid bigint, accid bigint)

alter procedure exec__temptaxmas
@accid bigint,@per numeric(12,2)
AS

declare @exists bigint

set @exists = (select count(*) from temp__taxmas where taxsetupid =@accid )

if(@exists = 1)
begin
     update temp__taxmas set percentage = @per where taxsetupid = @accid
	
end
else
begin
	 insert into temp__taxmas(taxsetupid,percentage)values(@accid,@per)
end



select ident_current('temp__taxmas') as masid,@accid as accountid






create procedure exec__temptaxdet 
@masid bigint, @accid bigint, @chos varchar(10)

As

if(@chos = 'save') 
	begin
		insert into temp__taxdet(masid,accid) values(@masid,@accid)
	end

else
	begin
		delete from temp__taxdet where masid=@masid and accid=@accid
	end


alter procedure DeleteTempTax
	@id bigint
	As
	delete from temp__taxdet where masid = (select masid from temp__taxmas where taxsetupid=@id)
	delete from temp__taxmas where taxsetupid=@id


create procedure clear_temptax
	As
	truncate table temp__taxdet
	truncate table temp__taxmas



  create procedure  Exec__taxsetupmas
@name varchar(1000), @remark varchar(1000), @ID bigint
AS

IF(@ID =0)
	BEGIN
		insert into taxsetupmas(taxsetupname, remarks)values(@name,@remark)
		select ident_current('taxsetupmas') as id
	END
ELSE
	BEGIN
		update taxsetupmas set taxsetupname=@name, remarks=@remark where taxsetupid=@ID
		select @ID  as id
	END

=====================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================
create procedure Get__tempmas
 @ID bigint=0
As
select * from temp__taxmas where masid = (case when @ID=0 then masid else @ID end)


create procedure Get__tempdet
 @ID bigint=0
As
select * from temp__taxdet where masid = (case when @ID=0 then masid else @ID end)


USE [shlock]
GO
/****** Object:  StoredProcedure [dbo].[Get_NCKot]    Script Date: 19/10/2023 15:40:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
alter PROCEDURE [dbo].[Get_NCKot] @ID BIGINT=0 as 
BEGIN  
SELECT * FROM Trans_BARKot_mas c 
                    INNER JOIN Mas_nckottype  s ON s.typeid= c.nctypeid
					where c.nctypeid =  @ID order by Kotid desc END



USE [shlock]
GO
/****** Object:  StoredProcedure [dbo].[Get_NCKotype]    Script Date: 19/10/2023 15:39:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Get_NCKotype] @ID BIGINT=0 as 
BEGIN  
select * from mas_nckottype

WHERE typeid  =(CASE WHEN @ID=0 THEN  typeid  ELSE @ID END ) order by  typeid  desc END


USE [shlock]
GO
/****** Object:  StoredProcedure [dbo].[Get_Discount]    Script Date: 19/10/2023 15:39:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Get_Discount] @ID BIGINT=0 as 
BEGIN  
select * from trans_barkotbillraise_mas where discamount > 0
and  Billid =(CASE WHEN @ID=0 THEN Billid ELSE @ID END ) order by Billid desc END




create procedure  Get__itemgroups
@ID bigint
As

select * from itemgroup  where itemgroupid = (case when @ID=0 then itemgroupid else @ID end) and isnull(inactive,0)<>1



create procedure  Get__suppliers
@ID bigint
As

select * from supplier  where supplierid = (case when @ID=0 then supplierid else @ID end) and isnull(inactive,0)<>1


CREATE PROCEDURE [dbo].[Get_KotCancell]  
@Fromdate DATETIME,@Todate DATETIME  
AS  
BEGIN  
SELECT * FROM Trans_barKot_mas mas  
  INNER JOIN Employee emp ON emp.Employeeid = mas.Stwid
  INNER JOIN Username usrs on usrs.Userid=mas.Userid where Kotdate BETWEEN @Fromdate AND @Todate 
	and isnull(cancelornorm,'')='C' 
END  


CREATE PROCEDURE [dbo].[Get_ItemReport] @ID BIGINT=0 as 
BEGIN  
select * from Stock_itemmmas
WHERE Itemgroupid  =(CASE WHEN @ID=0 THEN  Itemgroupid ELSE @ID END ) order by  Itemgroupid  desc END


CREATE PROCEDURE [dbo].[Get_ItemGroupReport] @ID BIGINT=0 as 
BEGIN  
select * from itemgroup  
WHERE Itemgroupid  =(CASE WHEN @ID=0 THEN Itemgroupid ELSE @ID END ) order by Itemgroupid desc END


============================corrections given by padthu sir 26.10.2023==============================================


delete from submenu where MNID=1

create table mainmenu(
mainmenuid int identity(1,1) primary key, submenuid bigint, menu varchar(200),act bigint, ord bigint,des varchar(200))


insert into mainmenu(submenuid,menu,act,ord,des)values(10037, '')

insert into mainmenu(submenuid,menu,act,ord,des)values(10037,'Table Group', 1, 1,'Add_TableGroup')
insert into mainmenu(submenuid,menu,act,ord,des)values(10037,'Table', 1, 2,'Add_TableMaster')
insert into mainmenu(submenuid,menu,act,ord,des)values(10038,'Store Item', 1, 3,'Add_StoreItemMaster')
insert into mainmenu(submenuid,menu,act,ord,des)values(10038,'Item Group', 1, 2,'Add_ItemGroup')
insert into mainmenu(submenuid,menu,act,ord,des)values(10044,'Tax Setup', 1, 13,'TaxSetup')
insert into mainmenu(submenuid,menu,act,ord,des)values(10038,'Bar Item', 1, 4,'Add_BarItemMaster')
insert into mainmenu(submenuid,menu,act,ord,des)values(10038,'Item Category', 1, 1,'Add_itemCategory')
insert into mainmenu(submenuid,menu,act,ord,des)values(10044,'Tax Type', 1, 1,'Add_taxType')


insert into submenu(submenu,MNID,act,des)values('Table', 1, 1,'')
insert into submenu(submenu,MNID,act,des)values('Item', 1, 2,'')
insert into submenu(submenu,MNID,act,des)values('Employee', 1, 3,'Add_EmployeeMaster')
insert into submenu(submenu,MNID,act,des)values('ML', 1, 4,'Add_MLMaster')
insert into submenu(submenu,MNID,act,des)values('Supplier', 1, 5,'Add_Supplier')
insert into submenu(submenu,MNID,act,des)values('NC KOT', 1, 6,'Add_nonChangeKOT')
insert into submenu(submenu,MNID,act,des)values('NC Account', 1,7,'Add_nonChargeAccount')
insert into submenu(submenu,MNID,act,des)values('Tax', 1, 8,'')
insert into submenu(submenu,MNID,act,des)values('Fire Master', 1, 9,'Add_fireMaster')




create procedure Get__mainmenu
@ID bigint

As

 select * from mainmenu where submenuid=@ID  order by ord


alter PROCEDURE [dbo].[Exec_TaxType] 
 @taxtype VARCHAR (100) ,
 @shortname VARCHAR (100),
 @uid BIGINT=0,@SType VARCHAR(100),@inactive bigint AS 
 
 BEGIN
 
  IF @SType = 'SAVE'
	BEGIN
	  INSERT INTO dbo.taxtype (taxtype, shortname,inactive)
      VALUES (@taxtype, @shortname,@inactive)
	 SELECT 'Successfully Saved' AS MGS
	END 
	
  IF @SType = 'UPDATE'
  BEGIN
    
 UPDATE dbo.taxtype
SET  
	taxtype= @taxtype,
	 
	
	shortname = @shortname,
	inactive = @inactive
	
  WHERE  taxid = @uid

   
    SELECT 'Successfully Updated' AS MGS
    
  END
  
  IF @SType = 'DELETE'
  BEGIN
    
   
    SELECT 'Successfully Deleted' AS MGS
    
  END
  END



CREATE PROCEDURE [dbo].[Get_TaxType_set] @ID BIGINT=0 as 

BEGIN  
 SELECT * FROM  taxtype
                     
WHERE taxid  =(CASE WHEN @ID=0 THEN taxid ELSE @ID END ) and isnull(inactive,0)<>1 order by taxid END




alter PROCEDURE [dbo].[Exec_TableMaster] 
 @Tablename VARCHAR (100) ,
 @ServiceTax VARCHAR(100),
 @ord BIGINT,
 @tablegroupid VARCHAR (100),

 @uid BIGINT=0,@SType VARCHAR(100),@inactive bigint AS 
 
 BEGIN
 
  IF @SType = 'SAVE'
	BEGIN
	  INSERT INTO dbo.Tablemas (Tablename, ServiceTax,ord,tablegroupid,inactive)
      VALUES (@Tablename, @ServiceTax, @ord, @tablegroupid,@inactive)
	 SELECT 'Successfully Saved' AS MGS
	END 
	
  IF @SType = 'UPDATE'
  BEGIN
    
 UPDATE dbo.Tablemas
SET  
	Tablename= @Tablename,
	 
	
	ServiceTax = @ServiceTax,
	
	
	
	ord= @ord,

	tablegroupid=@tablegroupid,
	inactive=@inactive
	
  WHERE  Tableid = @uid

   
    SELECT 'Successfully Updated' AS MGS
    
  END
  
  IF @SType = 'DELETE'
  BEGIN
    
   
    SELECT 'Successfully Deleted' AS MGS
    
  END
  	
 
 END




 
alter PROCEDURE [dbo].[Get_TableMaster] @ID BIGINT=0 as 

BEGIN  
SELECT c.inactive as inac ,* FROM Tablemas c 
                     INNER JOIN Table_Group  s ON s.tablegroup_id = c.tablegroupid
					WHERE Tableid  =(CASE WHEN @ID=0 THEN Tableid ELSE @ID END ) order by Tableid desc END



alter table itemcategory add inactive bigint

alter PROCEDURE [dbo].[Exec_ItemCategory] 
 @itemcategory VARCHAR (100) ,
 @accledgerid BIGINT,
 @uid BIGINT=0,@SType VARCHAR(100),@inactive bigint AS 
 
 BEGIN
 
  IF @SType = 'SAVE'
	BEGIN
	  INSERT INTO dbo.Itemcategory (itemcategory, accledgerid,inactive)
      VALUES (@itemcategory, @accledgerid,@inactive)
	 SELECT 'Successfully Saved' AS MGS
	END 
	
  IF @SType = 'UPDATE'
  BEGIN
    
 UPDATE dbo.Itemcategory
SET  
	itemcategory= @itemcategory,
	 
	
	accledgerid = @accledgerid,inactive=@inactive
	
  WHERE  itemcategoryid = @uid

   
    SELECT 'Successfully Updated' AS MGS
    
  END
  
  IF @SType = 'DELETE'
  BEGIN
    
   
    SELECT 'Successfully Deleted' AS MGS
    
  END
  END




alter table Mas_nckottype add inactive bigint
alter PROCEDURE [dbo].[Exec_NonchangeKOT] 
 @typename VARCHAR (100) ,

 @uid BIGINT=0,@SType VARCHAR(100), @inactive bigint AS 
 
 BEGIN
 
  IF @SType = 'SAVE'
	BEGIN
	  INSERT INTO dbo.Mas_nckottype (typename,inactive)
      VALUES (@typename,@inactive)
	 SELECT 'Successfully Saved' AS MGS
	END 
	
  IF @SType = 'UPDATE'
  BEGIN
    
 UPDATE dbo.Mas_nckottype
SET  
	typename = @typename,
	inactive=@inactive
	
  WHERE  typeid = @uid

   
    SELECT 'Successfully Updated' AS MGS
    
  END
  
  IF @SType = 'DELETE'
  BEGIN
    
   
    SELECT 'Successfully Deleted' AS MGS
    
  END
  END



alter table Mas_nckotaccount add inactive bigint

alter PROCEDURE [dbo].[Exec_NonChargeAccount] 
 @accountname VARCHAR (100) ,
 @typeid BIGINT,
 @uid BIGINT=0,@SType VARCHAR(100),@inactive bigint AS 
 
 BEGIN
 
  IF @SType = 'SAVE'
	BEGIN
	  INSERT INTO dbo.Mas_nckotaccount (accountname, typeid,inactive)
      VALUES (@accountname, @typeid,@inactive)
	 SELECT 'Successfully Saved' AS MGS
	END 
	
  IF @SType = 'UPDATE'
  BEGIN
    
 UPDATE dbo.Mas_nckotaccount
SET  
	accountname= @accountname,
	 
	
	typeid = @typeid,
	inactive = @inactive
	
  WHERE  accid = @uid

   
    SELECT 'Successfully Updated' AS MGS
    
  END
  
  IF @SType = 'DELETE'
  BEGIN
    
   
    SELECT 'Successfully Deleted' AS MGS
    
  END
  END



alter PROCEDURE [dbo].[Get_NonChargeAccount] @ID BIGINT=0 as 
BEGIN  
SELECT c.inactive as inac, * FROM Mas_nckotaccount c 
INNER JOIN Mas_nckottype  s ON s.typeid = c.typeid
WHERE accid  =(CASE WHEN @ID=0 THEN accid ELSE @ID END ) order by accid desc END


alter table mas_fire add inactive bigint
alter PROCEDURE [dbo].[Exec_FireMaster] 
@Firename VARCHAR (100) ,
@orderby BIGINT,
@uid BIGINT=0,@SType VARCHAR(100),@inactive bigint AS 
BEGIN
 IF @SType = 'SAVE'
	BEGIN
	  INSERT INTO dbo.mas_fire (Firename, orderby,inactive)
      VALUES (@Firename, @orderby,@inactive)
	 SELECT 'Successfully Saved' AS MGS
	END 
	
  IF @SType = 'UPDATE'
  BEGIN
    
 UPDATE dbo.mas_fire
SET  
	Firename= @Firename,
	 inactive = @inactive,
	
	orderby = @orderby 
	
  WHERE  Fireid = @uid

   
    SELECT 'Successfully Updated' AS MGS
    
  END
  
  IF @SType = 'DELETE'
  BEGIN
    
   
    SELECT 'Successfully Deleted' AS MGS
    
  END
  END








alter procedure  Exec__taxsetupmas
@name varchar(1000), @remark varchar(1000), @ID bigint,@inactive bigint
AS

IF(@ID =0)
	BEGIN
		insert into taxsetupmas(taxsetupname, remarks,inactive)values(@name,@remark,@inactive)
		select ident_current('taxsetupmas') as id
	END
ELSE
	BEGIN
		update taxsetupmas set taxsetupname=@name, remarks=@remark,inactive=@inactive where taxsetupid=@ID
		select @ID  as id
	END



ALTER PROCEDURE [dbo].[Get_InwardReport]  
@Fromdate DATETIME,@Todate DATETIME,@entryno varchar(100)
AS  
BEGIN  
select * from Trans_Bar_InwardMas mas 
		inner join  Trans_Bar_Inwarddet det on det.Inwid=mas.Inwid
		inner join Stock_itemmmas sto on sto.itemid=det.itemid 
		where Entrydate BETWEEN @Fromdate AND @Todate  and mas.entryno=@entryno order by mas.Entrydate
		
END  



alter PROCEDURE [dbo].[Get_PurchaseEntry]  
@Fromdate DATETIME,@Todate DATETIME,@Entryno VARCHAR(100)
AS  
BEGIN  
select * from Trans_Bar_purchaseMas mas 
		inner join Trans_Bar_purchaseDet det on det.Purid=mas.Purid
		inner join Stock_itemmmas sto on sto.itemid=det.itemid where Entrydate BETWEEN @Fromdate AND @Todate AND mas.Entryno=@Entryno order by mas.Entrydate
		
END  



 alter table Application_Settings add baritemcode_autogenrate int


update Application_Settings set baritemcode_autogenrate=1 


alter FUNCTION [dbo].[itemcode]()

RETURNS varchar(2000) AS  BEGIN

DECLARE @STRN VARCHAR(5000);
DECLARE @STR VARCHAR(5000);
DECLARE @STR2 VARCHAR(5000);
DECLARE @code VARCHAR(5000);
DECLARE @Date1 VARCHAR(5000);
DECLARE @Date2 VARCHAR(5000);






IF isnull (@STRN,0) = 1
BEGIN

    SET @STR=(SELECT RIGHT('0000000000'+ (Convert(varchar(10),substring(max(BarItemcode),4,13)+ 1)) ,10) from Bar_itemmmas WHERE  len(BarItemcode)=13)
    
    IF @STR IS NULL
    BEGIN
    SET @STR2 = '0000000001'
    SET @code ='BIC'
    END
    
    ELSE
    BEGIN
    SET @STR2 = (SELECT RIGHT('0000000000'+ (Convert(varchar(10),substring(max(BarItemcode),4,13)+ 1)) ,10) from Bar_itemmmas WHERE  len(BarItemcode)=13)
    SET @code ='BIC'
    END
    
END
IF isnull(@STRN,0) <> '1'
BEGIN

    SET @STR=(SELECT RIGHT('00000'+ (Convert(varchar(10),substring(max(BarItemcode),4,13)+ 2)) ,5) from Bar_itemmmas WHERE len(BarItemcode)=8)

    IF @STR IS NULL
    BEGIN
    SET @STR2 = '00001'
    SET @code ='BIC'
    END
    
    ELSE
    BEGIN
    SET @STR2 = (SELECT RIGHT('00000'+ (Convert(varchar(10),substring(max(BarItemcode),4,13)+ 1)) ,5) from Bar_itemmmas WHERE  len(BarItemcode)=8)
    SET @code ='BIC'
    END
    
END
RETURN @code+@STR2
END





ALTER PROCEDURE [dbo].[Exec_BarItemMaster]
 @Baritemcode NVARCHAR(100),
 @BarItemname NVARCHAR(100),
 @Rate NVARCHAR(10),
 @Fireid NVARCHAR(100),
 @iscocktail NVARCHAR(100),
 @salesvalue NVARCHAR(100),
 @costperc NVARCHAR(100),
 @roomrate NVARCHAR(100),
 @orderby NVARCHAR(100),
 @hsncode NVARCHAR(100),
 @Discountres NVARCHAR(100),
 @inactive NVARCHAR(10), 
 @id BIGINT=0,@SType VARCHAR(100) AS  
 BEGIN
 
  IF @SType = 'SAVE'
	BEGIN
	 INSERT INTO  Bar_itemmmas (BarItemcode,BarItemname,Rate,Fireid,iscocktail,salesvalue,costperc,roomrate,orderby,hsncode,Discountres)
     values(@BarItemcode,@BarItemname,@Rate,@Fireid,@iscocktail,@salesvalue,@costperc,@roomrate,@orderby,@hsncode,@Discountres)
	  
	  select IDENT_CURRENT('Bar_itemmmas') as id
	END 
  IF @SType = 'UPDATE'
  BEGIN

    UPDATE Bar_itemmmas SET BarItemcode = @BarItemcode,BarItemname=@BarItemname,Rate=@Rate,Fireid=@Fireid,iscocktail=@iscocktail,salesvalue=@salesvalue,costperc=@costperc,roomrate=@roomrate,orderby=@orderby,hsncode=@hsncode,Discountres=@Discountres,inactive=@inactive WHERE BarItemid = @id   
     select @id as id
 
 END
 END





create PROCEDURE [dbo].[Exec_BarItem] 
@BarItemid NVARCHAR(100),@storeitemid VARCHAR (100) ,
@qty BIGINT,
@Baritemcode NVARCHAR(100) AS 
 

 INSERT INTO bar_itemdet_id (RefBarItemid,Baritemcode,storeitemid,qty)
 VALUES (@BarItemid,@Baritemcode, @storeitemid,@qty)
	
SELECT 'Successfully Saved' AS MGS



ALTER Procedure [dbo].[Get_Mlmaster] @ID BIGINT=0 as BEGIN 
Select Mlqty,Mltype,MlDescription,inactive,Mlid from Barmltype

WHERE Mlid  =(CASE WHEN @ID=0 THEN Mlid ELSE @ID END ) order by Mlid desc END


ALTER Procedure [dbo].[Get_StoreMaster] @ID BIGINT=0 as BEGIN 
Select Itemid,Itemname,Itemcode,Sbarstockqty,mlperbottle from Stock_itemmmas 
WHERE Itemid  =(CASE WHEN @ID=0 THEN Itemid ELSE @ID END ) order by Itemid desc END




ALTER Procedure [dbo].[Get_FireGroup] @ID BIGINT=0 as BEGIN 
Select Fireid,Firename from mas_fire

WHERE Fireid  =(CASE WHEN @ID=0 THEN Fireid ELSE @ID END ) order by Fireid desc END



 alter Procedure [dbo].[Get_BarItemMaster] @ID BIGINT=0 as BEGIN 
Select Firename,bm.orderby,bm.BarItemid,bm.BarItemcode,bm.inactive,bm.Rate,bm.orderby,bm.Discountres,bm.hsncode,bm.roomrate,bm.costperc,bm.salesvalue,bm.iscocktail,bm.Fireid,bm.BarItemname,bm.ml,bm.StoreItemid,bm.discountnotapplicable from Bar_itemmmas bm
left join  mas_fire mf on mf.Fireid= bm.Fireid
WHERE BarItemid  =(CASE WHEN @ID=0 THEN BarItemid ELSE @ID END ) order by BarItemid desc END


ALTER PROCEDURE [dbo].[Exec_BarItemMaster]
 @Baritemcode NVARCHAR(100),
 @BarItemname NVARCHAR(100),
 @Rate NVARCHAR(10),
 @Fireid NVARCHAR(100),
 @iscocktail NVARCHAR(100),
 @salesvalue NVARCHAR(100),
 @costperc NVARCHAR(100),
 @roomrate NVARCHAR(100),
 @orderby NVARCHAR(100),
 @hsncode NVARCHAR(100),
 @Discountres NVARCHAR(100)='',
 @inactive NVARCHAR(10), 
 @id BIGINT=0,@SType VARCHAR(100),@discountapply bigint AS  
 BEGIN
 
  IF @SType = 'SAVE'
	BEGIN
	 INSERT INTO  Bar_itemmmas (BarItemcode,BarItemname,Rate,Fireid,iscocktail,salesvalue,costperc,roomrate,orderby,hsncode,Discountres,discountnotapplicable)
     values(@BarItemcode,@BarItemname,@Rate,@Fireid,@iscocktail,@salesvalue,@costperc,@roomrate,@orderby,@hsncode,@Discountres,@discountapply)
	  
	  select IDENT_CURRENT('Bar_itemmmas') as id
	END 
  IF @SType = 'UPDATE'
  BEGIN

    UPDATE Bar_itemmmas SET BarItemcode = @BarItemcode,BarItemname=@BarItemname,Rate=@Rate,Fireid=@Fireid,iscocktail=@iscocktail,salesvalue=@salesvalue,costperc=@costperc,roomrate=@roomrate,orderby=@orderby,hsncode=@hsncode,Discountres=@Discountres,inactive=@inactive,discountnotapplicable=@discountapply WHERE BarItemid = @id   
     select @id as id
 
 END
 END

create procedure Get_nightaudit_date
As
select * from Date_change_bar






=========================================corrections given by kathir 30.10.2023=============



alter PROCEDURE [dbo].[Get_TableMasterzzz] @ID BIGINT=0 as 

BEGIN  
SELECT * FROM Table_Group 
                    
WHERE tablegroup_id  =(CASE WHEN @ID=0 THEN  tablegroup_id ELSE @ID END ) and isnull(inactive,0)<>1 order by  tablegroup_id desc END


alter PROCEDURE [dbo].[Get_ItemCategorys] @ID BIGINT=0 as 
BEGIN  
SELECT * FROM Mas_accountledger
WHERE accledgerid  =(CASE WHEN @ID=0 THEN accledgerid ELSE @ID END ) and isnull(inactive,0)<>1 order by accledgerid desc END



alter PROCEDURE [dbo].[Get_ItemCategory] @ID BIGINT=0 as 
BEGIN  
SELECT * FROM Itemcategory c 
INNER JOIN Mas_accountledger  s ON s.accledgerid = c.accledgerid
WHERE itemcategoryid  =(CASE WHEN @ID=0 THEN itemcategoryid ELSE @ID END ) and isnull(c.inactive,0)<>1 order by itemcategoryid desc END



create PROCEDURE [dbo].[Get_ItemCategory_list] @ID BIGINT=0 as 
BEGIN  
SELECT * FROM Itemcategory c 
INNER JOIN Mas_accountledger  s ON s.accledgerid = c.accledgerid
WHERE itemcategoryid  =(CASE WHEN @ID=0 THEN itemcategoryid ELSE @ID END )  order by itemcategoryid desc END




alter Procedure [dbo].[Get_FireGroup] @ID BIGINT=0 as BEGIN 
Select Fireid,Firename from mas_fire
WHERE Fireid  =(CASE WHEN @ID=0 THEN Fireid ELSE @ID END ) and isnull(inactive,0)<>1 order by Fireid desc END




ALTER PROCEDURE [dbo].[Get_NonChargeAccountz] @ID BIGINT=0 as 
BEGIN  
select * from Mas_nckottype
WHERE typeid  =(CASE WHEN @ID=0 THEN typeid ELSE @ID END )  and isnull(inactive,0)<>1 order by typeid desc END

insert into submenu (submenu,mnid,act,des) values('As On Date Sales ',3,7,'SalesReport')

insert into submenu (submenu,mnid,act,des) values('Stock Report ',3,8,'StockReport')


USE [shlock]
GO
/****** Object:  StoredProcedure [dbo].[Get_ItemReport]    Script Date: 31/10/2023 12:56:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_ItemReport] @ID BIGINT=0 as 
BEGIN  
select * from Stock_itemmmas
WHERE Itemgroupid  =(CASE WHEN @ID=0 THEN  Itemgroupid ELSE @ID END ) order by  Itemgroupid  desc END


USE [shlock]
GO
/****** Object:  StoredProcedure [dbo].[Get_StoreStock]    Script Date: 31/10/2023 12:57:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_StoreStock]  
@Fromdate DATETIME,@Todate DATETIME,@Itemid BIGINT
AS  
BEGIN  
Select Si.Storeopstock,si.orderby as sorderby,itemgroup.ordby as orderby, Si.itemname,si.bottpercase, oldpur.purqty Oldpur ,oldinward.qtybtl Oldqtybtl, oldadj.qty oldadjustqty ,newPur.purQty newpurchase,  newInward.qtybtl as Newissue,newadj.newadjqty newAdjustqty,newPhy.qty newPhysical,itemgroup.itemgroup, isnull(itemgroup.barorfood,0) barorfood, isnull(hotitems,0) hotitems, isnull(beeritems,0) beeritems, isnull(otheritems,0) otheritems   from Stock_itemmmas Si   
left outer join ( Select Sum(oldpur.Purqty)purqty ,oldpur.itemid from   Trans_Bar_purchasemas oldmas,Trans_Bar_purchasedet oldpur where oldpur.purid=oldmas.purid and Entrydate<@Fromdate group by itemid) as oldpur on oldpur.itemid=si.itemid   
left outer join ( Select Sum(oldinw.qtybtl) as qtybtl,oldinw.itemid from   Trans_Bar_inwardmas oldinwmas,Trans_Bar_inwarddet oldinw where oldinw.inwid=oldinwmas.inwid and convert(datetime,Entrydate,101)<@Fromdate group by itemid) as oldinward on oldinward.itemid=si.itemid   
left outer join (Select Sum(oldadjdet.qty * (convert(numeric,oldadjdet.Addorless + '1'))) as qty ,oldadjdet.itemid from   Trans_Bar_StockAdjustmentmas oldadjmas,Trans_Bar_StockAdjustmentdet oldadjdet   where oldadjdet.adjid=oldadjmas.adjid and oldadjmas.Baroorstore='S' and Entrydate<@Fromdate group by itemid) oldadj  on  oldadj.itemid=si.itemid   
left outer join ( Select Sum(newpur.Purqty)as purqty ,newpur.itemid from   Trans_Bar_purchasemas newmas,Trans_Bar_purchasedet newpur where newpur.purid=newmas.purid and Entrydate between @Fromdate and @Todate group by itemid) as newpur on newpur.itemid=si.itemid   
left outer join (Select Sum(newadjdet.qty * (convert(numeric,newadjdet.Addorless + '1'))) as newadjqty ,newadjdet.itemid from   Trans_Bar_StockAdjustmentmas newadjmas,Trans_Bar_StockAdjustmentdet newadjdet   where newadjdet.adjid=newadjmas.adjid and newadjmas.Baroorstore='S' and Entrydate between @Fromdate and @Todate group by itemid) newadj  on  newadj.itemid=si.itemid   
left outer join ( Select Sum(newinw.qtybtl) as qtybtl,newinw.itemid from   Trans_Bar_inwardmas newinwmas,Trans_Bar_inwarddet newinw where newinw.inwid=newinwmas.inwid and Entrydate between @Fromdate and @Todate group by itemid) as newinward on newinward.itemid=si.itemid   
left outer join (Select Sum(newphydet.qty) as qty ,newphydet.itemid from   Trans_Bar_physicalmas newphymas,Trans_Bar_physicaldet newphydet   where newphydet.adjid=newphymas.adjid and Entrydate between @Fromdate and @Todate and   newphymas.Baroorstore='S'   group by itemid) newphy  on  newphy.itemid=si.itemid   /*inner join Itemgroup on itemgroup.itemgroupid=si.itemgroupid AND itemgroup.itemgroup not in ('FOOD') */  
inner join Itemgroup on itemgroup.itemgroupid=si.itemgroupid AND isnull(itemgroup.barorfood,0) = 1    and isnull(si.inactive,0)=0 AND si.Itemid=@Itemid order by itemgroup.ordby,si.orderby,si.itemname 
END




USE [shlock]
GO
/****** Object:  StoredProcedure [dbo].[Get_BarReport]    Script Date: 31/10/2023 13:00:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_BarReport]  
@Fromdate DATETIME,@Todate DATETIME,@Itemid BIGINT
AS  
BEGIN  
Select isnull(Si.Baropstock,0) as baropstock,Si.itemid, itemgroup.ORDBY ,Si.itemname,si.mlperbottle,(isnull(oldsal.salqty,0)) Oldsales ,(isnull(oldinward.qtybtl,0)) OldIssue, (isnull(oldadj.qty,0)) OldAdjustqty ,(isnull(newsal.salQty,0)) NewsalesT, (isnull(newsalR1.salQty,0)) NewsalesR,(isnull(newInward.qtybtl,0)) as Newissue, (isnull(newadj.newadjqty,0)) newAdjustqty,(isnull(newPhy.qty,0)) newPhysical,Itemgroup.Itemgroup, isnull(itemgroup.beeritems,0) beeritems, isnull(itemgroup.otheritems,0) otheritems,si.pegml from Stock_itemmmas Si 
                left outer join (Select Sum(oldsal.qty * oldkd.qty)salqty,oldkd.storeitemid from Trans_Barkot_mas oldmas, Trans_Barkot_det oldsal, Trans_Barkotdet_id oldkd where oldsal.kotid=oldmas.kotid and oldsal.kotdetid=oldkd.refkotdetid and kotdate < @Fromdate AND isnull(oldmas.Cancelornorm,'N')<>'C' group by oldkd.storeitemid) as oldsal on oldsal.storeitemid=si.itemid 
                 left outer join (Select Sum(oldinw.qty) as qtybtl,oldinw.itemid from Trans_Bar_inwardmas oldinwmas, Trans_Bar_inwarddet oldinw where oldinw.inwid=oldinwmas.inwid and convert(datetime,Entrydate,101) < @Fromdate and isnull(oldinwmas.restypeid,0)=0 group by itemid) as oldinward on oldinward.itemid=si.itemid 
                 left outer join (Select Sum(oldadjdet.qty * (convert(numeric,oldadjdet.Addorless + '1'))) as qty ,oldadjdet.itemid from Trans_Bar_StockAdjustmentmas oldadjmas,Trans_Bar_StockAdjustmentdet oldadjdet where oldadjdet.adjid=oldadjmas.adjid and oldadjmas.Baroorstore='B' and convert(date,Entrydate,101) < @Fromdate group by itemid) oldadj on  oldadj.itemid=si.itemid 
                 left outer join (Select Sum(newsal.qty * newkd.qty)salqty, newkd.storeitemid from Trans_Barkot_mas newmas, Trans_Barkot_det newsal, Trans_Barkotdet_id newkd where newsal.kotid=newmas.kotid  and newsal.kotdetid=newkd.refkotdetid and kotdate between @Fromdate and @Todate AND isnull(newmas.Cancelornorm,'N')<>'C' AND rOOMORTAB='T' group by newkd.storeitemid) as newsal on newsal.storeitemid=si.itemid 
                 left outer join (Select Sum(newsal.qty * newkd.qty)salqty, newkd.storeitemid from Trans_Barkot_mas newmas, Trans_Barkot_det newsal, Trans_Barkotdet_id newkd where newsal.kotid=newmas.kotid and newsal.kotdetid=newkd.refkotdetid and kotdate between @Fromdate and @Todate AND isnull(newmas.Cancelornorm,'N')<>'C' AND rOOMORTAB='R' group by newkd.storeitemid) as newsalR1 on newsalR1.storeitemid=si.itemid 
                 left outer join (Select Sum(newadjdet.qty * (convert(numeric,newadjdet.Addorless + '1'))) as newadjqty, newadjdet.itemid from   Trans_Bar_StockAdjustmentmas newadjmas,Trans_Bar_StockAdjustmentdet newadjdet where newadjdet.adjid=newadjmas.adjid and newadjmas.Baroorstore='B' and convert(date,Entrydate,101) between @Fromdate and @Todate group by itemid) newadj on newadj.itemid=si.itemid 
                 left outer join (Select Sum(newinw.qty) as qtybtl,newinw.itemid from Trans_Bar_inwardmas newinwmas, Trans_Bar_inwarddet newinw where newinw.inwid=newinwmas.inwid and convert(date,Entrydate,101) between @Fromdate and @Todate and isnull(newinwmas.restypeid,0)=0 group by itemid) as newinward on newinward.itemid=si.itemid 
                left outer join (Select Sum(newphydet.qty) as qty ,newphydet.itemid from Trans_Bar_physicalmas newphymas, Trans_Bar_physicaldet newphydet   where newphydet.adjid=newphymas.adjid and convert(date,Entrydate,101) between @Fromdate and @Todate and newphymas.Baroorstore='B' group by itemid) newphy  on  newphy.itemid=si.itemid 
                 inner join Itemgroup on itemgroup.itemgroupid=si.itemgroupid WHERE isnull(ITEMGROUP.barorfood,0)=1 and isnull(ITEMGROUP.otheritems,0) <> 1 AND si.Itemid=@itemid order by Itemgroup.ordby,itemgroup,si.orderby,SI.ITEMNAME 
END



insert into submenu (submenu,mnid,act,des) values('Bar Stock Report ',3,9,'BarReport')

insert into submenu (submenu,mnid,act,des) values('Bar Stock Report2 ',3,9,'BarReport2')



========================corrections given by senthil sir 1.11.2023======================================

alter procedure Get_purchase_mas 
@ID bigint = 0
As

select * from trans_bar_purchasemas where purid=(case when @ID=0 then purid else @ID end) order by purid desc



alter procedure Get__Inwardmas

@ID bigint=0

As


select * from trans_bar_inwardmas where Inwid=(case when @ID=0 then inwid else @ID end) order by inwid desc




alter PROCEDURE EXEC_PURCHASE_DET
@PURID BIGINT, @ITEMID BIGINT,@CASES VARCHAR(10),@PURQTY BIGINT, 
@RATE NUMERIC(12,2),@ADDED NUMERIC(12,2)=0.00,@AMOUNT NUMERIC(12,2),@edit bigint =0,@totalqty numeric(12,2)

AS


--IF(@edit =1 )
--	BEGIN
--		DELETE FROM TRANS_BAR_PURCHASEDET WHERE PURID=@PURID
--	END


INSERT INTO TRANS_BAR_PURCHASEDET (PURID,ITEMID,CASES,PURQTY,RATE,ADDED,AMOUNT,totalqty)
VALUES(@PURID,@ITEMID,@CASES,@totalqty,@RATE,@ADDED,@AMOUNT,@PURQTY)

SELECT 'SUCCESS' AS MGS



create procedure Get__Taxsetup1
@ID bigint=0
As

select * from taxsetupmas where taxsetupid=(case when @ID=0 then taxsetupid else @ID  end) and isnull(inactive,0)<>1



alter PROCEDURE [dbo].[Get_Discount] @Fromdate DATETIME,@Todate DATETIME,@Billno VARCHAR(100)  as 
BEGIN  
select * from trans_barkotbillraise_mas where Billdate BETWEEN @Fromdate AND @Todate and  discamount > 0
and  Billno = @Billno order by Billdate desc END




insert into submenu(submenu,MNID,act,des)values('Stock Opening', 2, 4,'Stockopening')



CREATE TABLE [dbo].[Trans_BarStoreopening_mas](
	[Opening_Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Openingdate] [datetime] NULL,
	[Userid] [bigint] NULL,
	[Draftmode] [bigint] NULL,
	[openingqty] [bigint] NULL
) ON [PRIMARY]

GO


CREATE TABLE [dbo].[Trans_BarStoreopening_det](
	[Openingdet_id] [bigint] NULL,
	[Opening_id] [bigint] NULL,
	[itemid] [bigint] NULL,
	[openingty] [decimal](18, 0) NULL,
	[openingqty] [bigint] NULL,
	[Stock] [bigint] NULL,
	[Draftmode] [bigint] NULL
) ON [PRIMARY]

GO

 SELECT * FROM Trans_BarStoreopening_mas
 ALTER TABLE Trans_BarStoreopening_det ADD Draftmode BIGINT
  ALTER TABLE Trans_BarStoreopening_det ADD openingqty BIGINT 
    ALTER TABLE Trans_BarStoreopening_DET ADD Stock BIGINT 


update submenu set submenu='Steward/captain' where msid=10023


GO
/****** Object:  StoredProcedure [dbo].[Exec_Stockopening]    Script Date: 02/11/2023 17:00:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[Exec_Stockopening]
 @Storeopstock BIGINT,
 @Openingdate datetime,
 @stock BIGINT,
 @Itemcode BIGINT,
 @opening BIGINT,
 @Type BIGINT,
 @SType VARCHAR(100)  AS  
 BEGIN
 
 IF @Type = '0'
	BEGIN
	  INSERT INTO Trans_BarStoreopening_mas (Openingdate,Draftmode)
      VALUES (@Openingdate,@opening)
	 SELECT 'Successfully Saved' AS MGS
END
IF @SType = 'SAVE'
BEGIN
--DELETE FROM Trans_BarStoreopening_det where Draftmode='1'
DECLARE  @id NVARCHAR
SET @id=(SELECT IDENT_CURRENT('Trans_BarStoreopening_mas') as id)	      

	  INSERT INTO Trans_BarStoreopening_det (Opening_id,itemid,openingqty,Stock,Draftmode)
      VALUES (@id,@Itemcode,@Storeopstock,@stock,@opening)
	 SELECT 'Successfully Saved' AS MGS	 
	END
 END







GO
/****** Object:  StoredProcedure [dbo].[Get_Stockopening]    Script Date: 02/11/2023 17:01:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  Procedure Get_Stockopening @ID BIGINT=0 as BEGIN 
Select ig.Itemid, ig.Itemcode,ig.Itemname,det.itemid, det.Stock,det.Draftmode,det.openingqty from Trans_BarStoreopening_det det
Inner join Stock_itemmmas ig on ig.Itemid=det.itemid
Inner join Trans_BarStoreopening_mas mas on mas.Draftmode=det.Draftmode
WHERE Openingdet_id  =(CASE WHEN @ID=0 THEN Openingdet_id ELSE @ID END ) order by Openingdet_id desc END



GO
/****** Object:  StoredProcedure [dbo].[Get_StoreMaster]    Script Date: 02/11/2023 17:02:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[Get_StoreMaster] @ID BIGINT=0 as BEGIN 
Select Itemid,Itemname,Itemcode,Sbarstockqty,mlperbottle from Stock_itemmmas 
WHERE Itemid  =(CASE WHEN @ID=0 THEN Itemid ELSE @ID END ) order by Itemid desc END



============================changes on 04.11.2023====================================================

ALTER PROCEDURE [dbo].[Exec_BarItemMaster]
 @Baritemcode NVARCHAR(100),
 @BarItemname NVARCHAR(100),
 @Rate NVARCHAR(10),
 @Fireid NVARCHAR(100),
 @iscocktail NVARCHAR(100),
 @costperc NVARCHAR(100),
 @roomrate NVARCHAR(100),
 @orderby NVARCHAR(100),
 @hsncode NVARCHAR(100),
 @Discountres NVARCHAR(100)='',
 @inactive NVARCHAR(10), 
 @id BIGINT=0,@SType VARCHAR(100),@discountapply bigint AS  
 BEGIN
 
  IF @SType = 'SAVE'
	BEGIN
	 INSERT INTO  Bar_itemmmas (BarItemcode,BarItemname,Rate,Fireid,iscocktail,costperc,roomrate,orderby,hsncode,Discountres,discountnotapplicable)
     values(@BarItemcode,@BarItemname,@Rate,@Fireid,@iscocktail,@costperc,@roomrate,@orderby,@hsncode,@Discountres,@discountapply)
	  
	  select IDENT_CURRENT('Bar_itemmmas') as id
	END 
  IF @SType = 'UPDATE'
  BEGIN

    UPDATE Bar_itemmmas SET BarItemcode = @BarItemcode,BarItemname=@BarItemname,Rate=@Rate,Fireid=@Fireid,iscocktail=@iscocktail,costperc=@costperc,roomrate=@roomrate,orderby=@orderby,hsncode=@hsncode,Discountres=@Discountres,inactive=@inactive,discountnotapplicable=@discountapply WHERE BarItemid = @id   
     select @id as id
 END
 END



Alter Procedure [dbo].[Get_Stockmaster] @ID BIGINT=0 as BEGIN 
Select Draftmode,Stock, Openingdate from Trans_BarStoreopening_det
WHERE Itemid  =(CASE WHEN @ID=0 THEN Itemid ELSE @ID END ) order by Itemid desc END




ALTER PROCEDURE [dbo].[Exec_Stockmas]
 @Storeopstock BIGINT,
 @Openingdate datetime,
 @stock BIGINT,
 @Itemcode BIGINT,
 @opening BIGINT,
 @Type BIGINT,
 @SType VARCHAR(100)  AS  
 BEGIN
 IF @Type = '0'
	BEGIN
	  INSERT INTO Trans_BarStoreopening_mas (Openingdate,Draftmode)
      VALUES (@Openingdate,@opening)
	 SELECT 'Successfully Saved' AS MGS
END
END


Create table Trans_BarStoreopening_det
(
Openingdet_id bigint  identity(1,1),
Opening_id bigint,
itemid bigint,
openingqty decimal,
Stock bigint,
Draftmode bigint
)


Alter Procedure [dbo].[Get_Stockmaster] @ID BIGINT=0 as BEGIN 
Select d.Draftmode,d.Stock, m.Openingdate from Trans_BarStoreopening_det d
inner join Trans_BarStoreopening_mas m on m.Opening_Id= d.Opening_id
WHERE Itemid  =(CASE WHEN @ID=0 THEN Itemid ELSE @ID END ) order by Itemid desc END




 alter Procedure [dbo].[Get_BarItemMaster] @ID BIGINT=0 as BEGIN 
Select Firename,bm.orderby,bm.BarItemid,bm.BarItemcode,bm.inactive,
bm.Rate,bm.orderby,bm.Discountres,bm.hsncode,bm.roomrate,bm.costperc,bm.salesvalue,bm.iscocktail,bm.Fireid,bm.BarItemname,bm.ml,bm.StoreItemid,bm.discountnotapplicable from Bar_itemmmas bm
left join  mas_fire mf on mf.Fireid= bm.Fireid
WHERE BarItemid  =(CASE WHEN @ID=0 THEN BarItemid ELSE @ID END ) order by BarItemcode asc END


=================Merging transactions and masters and reports 05.12.2023============================


ALTER PROCEDURE [dbo].[Exec_TableMaster] 
 @Tablename VARCHAR (100) ,
 @ServiceTax VARCHAR(100),
 @ord BIGINT,
 @tablegroupid VARCHAR (100),

 @uid BIGINT=0,@SType VARCHAR(100),@inactive bigint AS 
 
 BEGIN
 
  IF @SType = 'SAVE'
	BEGIN
	  INSERT INTO dbo.Tablemas (Tablename, ServiceTax,ord,tablegroupid,inactive,isbar,status)
      VALUES (@Tablename, @ServiceTax, @ord, @tablegroupid,@inactive,1,'S')
	 SELECT 'Successfully Saved' AS MGS
	END 
	
  IF @SType = 'UPDATE'
  BEGIN
    
 UPDATE dbo.Tablemas
SET  
	Tablename= @Tablename,
	 
	
	ServiceTax = @ServiceTax,
	
	
	
	ord= @ord,

	tablegroupid=@tablegroupid,
	inactive=@inactive
	
  WHERE  Tableid = @uid

   
    SELECT 'Successfully Updated' AS MGS
    
  END
  
  IF @SType = 'DELETE'
  BEGIN
    
   
    SELECT 'Successfully Deleted' AS MGS
    
  END
  	
 
 END



 ==== transaction correction 09.12.2023==========================


 ALTER TABLE trans_bar_purchasemas 
ALTER COLUMN invdate datetime



ALTER TABLE trans_bar_inwardmas 
ALTER COLUMN entrydate datetime




USE [shlock]
GO
/****** Object:  Trigger [dbo].[Insert_BarStock_Inward]    Script Date: 11/12/2023 15:00:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[Insert_BarStock_Inward] ON [dbo].[Trans_Bar_Inwarddet]
FOR INSERT
AS
declare @itemid integer
declare @Qty  NUMERIC(14,3)
declare @Qtybtl NUMERIC(14,3),@counterid bigint,@barinwid bigint,@cnt bigint
declare @enablebarcounterbasedkotbillinward bigint,@restypeid bigint
declare barinw cursor for select qty ,itemid,qtybtl,inwid from inserted ins
Open barinw
Fetch next from barinw into @Qty,@itemid,@qtybtl,@barinwid
While @@Fetch_Status=0
begin
   
   select @enablebarcounterbasedkotbillinward = (Select isnull(enablebarcounterbasedkotbillinward,0) as enablebarcounterbasedkotbillinward from application_settings)
   
   if @enablebarcounterbasedkotbillinward >0
   begin
	   select @counterid = (select counterid from trans_bar_inwardmas where inwid = @barinwid)
	   select @restypeid = (select restypeid from trans_bar_inwardmas where inwid = @barinwid)
	   select @cnt = (select count(*) ccnt from stock_itemmmas_counter where 
	   storeitemid = @itemid and counterid = @counterid)
	   if @cnt=0
	   begin
	     if @counterid >0
	     begin
		   insert into stock_itemmmas_counter(storeitemid,barstockqty,counterid)values(@itemid,@qty,@counterid)
		 end
	   end
	   else
	   begin
	     if @counterid > 0
	     begin
		    Update stock_itemmmas_counter Set BarStockqty=isnull(BarStockqty,0) +@qty where storeitemid=@itemid and counterid=@counterid
		 end
	   end
   end
   if @restypeid >0
   begin   
     Update Stock_itemmmas Set
	  StoreStockqty = isnull(StoreStockqty,0)  - @qtybtl where itemid=@itemid
   end
   else
   begin
      Update Stock_itemmmas Set BarStockqty=isnull(BarStockqty,0) +@qty ,
	  StoreStockqty = isnull(StoreStockqty,0)  - @qtybtl, barissueqty=isnull(StoreStockqty,0)  - @qtybtl where itemid=@itemid
   end

Fetch next from barinw into @Qty,@itemid,@qtybtl,@barinwid
end

Close barinw
Deallocate barinw





ALTER PROCEDURE [dbo].[EXEC_INWARD_DET]
@INWID BIGINT, @ITEMID BIGINT,@QTY BIGINT, @QTYBOTT BIGINT, @qtyml bigint

AS



INSERT INTO TRANS_BAR_INWARDDET (INWID,ITEMID,QTY,QTYBTL,qtyml)VALUES(@INWID,@ITEMID,@QTY,@QTYBOTT,@qtyml)

SELECT 'SUCCESS' AS MGS

==========messages 15.12.2023 ========================================

CREATE TABLE [dbo].[Outbox](
	[msgid] [int] IDENTITY(1,1) NOT NULL,
	[MobileNumber] [nvarchar](20) NULL,
	[SMSMessage] [varchar](2000) NULL,
	[DateCreated] [datetime] NULL,
	[smsflag] [int] NULL,
	[flg] [int] NULL,
	[outboxdate] [datetime] NULL,
	[Box] [char](1) NULL,
	[notsentflag] [bigint] NULL,
	[updatestatus] [bigint] NULL,
	[mode] [varchar](25) NULL,
	[frommobilenumber] [nvarchar](20) NULL,
	[createdtime] [datetime] NULL,
	[senduserid] [bigint] NULL,
	[reason] [varchar](1000) NULL,
	[msgdate] [datetime] NULL,
	[msgfromtime] [datetime] NULL,
	[msgtotime] [datetime] NULL,
	[sentmsgid] [bigint] NULL,
	[UpTime] [datetime] NULL,
	[smstemplateid] [varchar](500) NULL,
	[bdayflag] [bigint] NULL,
	[annidayflag] [bigint] NULL,
	[campaign] [varchar](500) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


alter table mas_smsmessage add loginmsg varchar(2000)
alter table mas_smsmessage add koteditmsg varchar(2000)
alter table mas_smsmessage add kotcancelmsg varchar(2000)


update mas_smsmessage set loginmsg='Login Details: Username: *username* Date & Time : *datetime*.'
update mas_smsmessage set koteditmsg='BAR Kot Item Edited Kotno= *kotno*, Kotdate= *kotdate*, UserName= *username*, Old ItemName=*olditemname*, OldQty=*olditemqty*, OldAmount=*olditemamount*, NewItemname =*newitemname*,  Qty=*newitemqty*, Amount=*newitemamount*.'
update mas_smsmessage set kotcancelmsg='BAR CANCEL KOT NO : *kotno*, AMOUNT : *amount* CANCELLED BY *user*.'




insert into menu(menu,act) values('Settings', '1')

insert into submenu(submenu,mnid,act,des)values('Data Purging', 4,1,'DataPurging')








alter procedure datapurging
@key varchar(20)
AS

if(@key='MASTER')
	BEGin
		 truncate table Bar_itemmmas
		 truncate table bar_itemdet_id
		 truncate table Employee
		 truncate table mas_fire
		 truncate table Itemcategory
		 truncate table Itemgroup
		 truncate table Barmltype
		 truncate table Mas_nckottype
		 truncate table Mas_nckotaccount
		 truncate table Stock_itemmmas
		 truncate table Supplier
		 truncate table Table_Group
		 truncate table Tablemas
		 truncate table taxsetupmas
		 truncate table taxsetupdet
		 truncate table taxsetupacdet
		 truncate table taxtype

	END

if(@key='Transaction')
	BEGIN
		truncate table Trans_Bar_InwardMas
		truncate table Trans_Bar_Inwarddet
		truncate table trans_bar_purchasemas
		truncate table Trans_bar_purchasedet
		truncate table Trans_BarStoreopening_mas
		truncate table Trans_BarStoreopening_det
		truncate table trans_bar_stockadjustmentdet
		truncate table trans_bar_stockadjustmentmas
		truncate table Trans_BARKot_det
		truncate table Trans_BARKot1_det
		truncate table Trans_BARKot_mas
		truncate table Trans_BARKot1_mas
		truncate table Trans_BARKotdet_id
		update tablemas set status='S'
		truncate table Trans_BARKotSettlement_mas
		truncate table Trans_BARKotSettlement1_det
		truncate table Trans_BARKotSettlement_det
		truncate table temp_settlement
		truncate table Trans_BARKotBillraise_mas
		truncate table Trans_BARKotBillraise_det

	END




	





  ===============================================2014 server=============================================



  
truncate table mainmenu

truncate table submenu


	insert into mainmenu(submenuid,menu,act,ord,des)values(1,'Table Group', 1, 1,'Add_TableGroup')
insert into mainmenu(submenuid,menu,act,ord,des)values(1,'Table', 1, 2,'Add_TableMaster')
insert into mainmenu(submenuid,menu,act,ord,des)values(2,'Store Item', 1, 3,'Add_StoreItemMaster')
insert into mainmenu(submenuid,menu,act,ord,des)values(2,'Item Group', 1, 2,'Add_ItemGroup')
insert into mainmenu(submenuid,menu,act,ord,des)values(8,'Tax Setup', 1, 13,'TaxSetup')
insert into mainmenu(submenuid,menu,act,ord,des)values(2,'Bar Item', 1, 4,'Add_BarItemMaster')
insert into mainmenu(submenuid,menu,act,ord,des)values(2,'Item Category', 1, 1,'Add_itemCategory')
insert into mainmenu(submenuid,menu,act,ord,des)values(8,'Tax Type', 1, 1,'Add_taxType')




insert into submenu(submenu,MNID,act,des)values('Table', 1, 1,'')
insert into submenu(submenu,MNID,act,des)values('Item', 1, 2,'')
insert into submenu(submenu,MNID,act,des)values('Employee', 1, 3,'Add_EmployeeMaster')
insert into submenu(submenu,MNID,act,des)values('ML', 1, 4,'Add_MLMaster')
insert into submenu(submenu,MNID,act,des)values('Supplier', 1, 5,'Add_Supplier')
insert into submenu(submenu,MNID,act,des)values('NC KOT', 1, 6,'Add_nonChangeKOT')
insert into submenu(submenu,MNID,act,des)values('NC Account', 1,7,'Add_nonChargeAccount')
insert into submenu(submenu,MNID,act,des)values('Tax', 1, 8,'')
insert into submenu(submenu,MNID,act,des)values('Fire Master', 1, 9,'Add_fireMaster')


/*******    settings form */



insert into submenu(submenu,mnid,act,des)values('Bar Settings', 4,2,'BarSettings')


alter table submenu alter column submenu varchar(1000)
alter table menu alter column menu varchar(1000)



insert into submenu(submenu,MNID,act,des)values('Purchase Entry', 2, 1,'Purchase_Entry')
insert into submenu(submenu,MNID,act,des)values('Inward', 2, 2,'Inward')
insert into submenu(submenu,MNID,act,des)values('Stock Adjustment', 2, 3,'Adjustment')
insert into submenu(submenu,MNID,act,des)values('Stock Opening', 2, 4,'Stockopening')


insert into submenu (submenu,mnid,act,des) values('Kot Bill Cancellation',3,1,'KotBill_cancellation')
insert into submenu (submenu,mnid,act,des) values('NC-Kot Type',3,2,'NCKotType')
insert into submenu (submenu,mnid,act,des) values('Discount',3,3,'Discount')
insert into submenu (submenu,mnid,act,des) values('As On Date Sales ',3,7,'SalesReport')
insert into submenu (submenu,mnid,act,des) values('Stock Report ',3,8,'StockReport')
insert into submenu (submenu,mnid,act,des) values('Bar Stock Report ',3,9,'BarReport')
insert into submenu (submenu,mnid,act,des) values('Bar Stock Report2 ',3,10,'BarReport2')



/*** Bar item master save query --- by durga 08.01.2024 -- ****/


ALTER PROCEDURE [dbo].[Exec_BarItem] 
@BarItemid NVARCHAR(100),@storeitemid VARCHAR (100) ,
@qty BIGINT,
@Baritemcode NVARCHAR(100) AS 

 INSERT INTO bar_itemdet_id (RefBarItemid,Baritemcode,storeitemid,qty,mlid)
 VALUES (@BarItemid,@Baritemcode, @storeitemid,(select mlqty from barmltype where Mlid=@qty),@qty)
	
SELECT 'Successfully Saved' AS MGS


/** nc kot ---10.01.2024 */



USE [diamondnew]
GO
/****** Object:  StoredProcedure [dbo].[kot__save__two]    Script Date: 10/01/2024 11:17:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[kot__save__two]
@tableid bigint,@counter bigint, @sessionid bigint, @tokenno bigint,@refdate datetime,@reftime datetime,@noofpax bigint,@Stwid bigint
As

declare @qty bigint ,@part varchar(100),@itemid bigint ,@tqty bigint,@trat numeric(12,2),@tamt numeric(12,2), @bool bigint=0,
@iscoktail varchar(2),@storeitemid bigint,@kotid bigint,@splinstruction varchar(1000),@kitmsg varchar(1000),
@nccoversion varchar(1000),
@Tamt1 numeric(12,2), @sum11 numeric(12,2),@ncreson varchar(1000),@Employeeid bigint,@billid bigint, @baritemname varchar(500),
@pax bigint, @sbarstockqty bigint,@icecreamorfood bigint,@otheritems bigint,@bool1 bigint,@nckotaccounttype bigint,@nctype varchar(100),
@itemname  varchar(100),@nc bigint, @nctypeid bigint, @ncaccid bigint,@amt numeric(12,2),@rate numeric(12,2)
set @sum11=0
set @sum11=0
set @amt=0

  INSERT INTO dbo.Trans_BARKot_mas(Refno,Raised,counterid,noofpax,part,tableid,Stwid,Kotno,Kotdate,  Kottime, totalamount, rOOMORTAB,Userid,sessionid,tokenno,NCconversionreson,refkotdate,refkottime) 
  VALUES ('','0',@counter,@noofpax,@part,@tableid,@Stwid,  dbo.RotNo(),@refdate,@reftime, @sum11,'T',1,@sessionid, @tokenno,@ncreson,convert(VARCHAR,getdate(),101), convert(VARCHAR,getdate(),108)) 
 set @billid=(Select SCOPE_IDENTITY())

declare kotitemsfetch170719 cursor for 
SELECT DISTINCT btm.BarItemname,tk2.NCconversionreson,nckotaccounttype,nctype,
					Splinstruction,KITMSG,tk2.Noofpax,tk2.storeitemid,iscocktail,tk2.TRat,Kot_Id,Tqty,tk2.Itemid,
					s.Itemname,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Stock_Itemmmas s on s.Itemid=tk2.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid
					and tk2.Approved ='1'
set @bool1=0
open kotitemsfetch170719 
     

   FETCH NEXT FROM kotitemsfetch170719 INTO  @baritemname,@nccoversion,@nckotaccounttype,@nctype,@splinstruction,@kitmsg,
 @pax,@storeitemid,@iscoktail,@trat,@kotid,@tqty,@itemid,@itemname,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool1 = 1
				IF(@nckotaccounttype=0)
					BEGIN
						set @nc=0
						set @nctypeid=0
						set @rate = @trat
						set @amt=@tamt
						set @ncaccid=0
					END
				ELSE
				    BEGIN
						set @nc=1
						set @nctypeid=@nctype
						set @rate = 0.00
						set @amt=0.00
						set @ncaccid=@nckotaccounttype
					END
				
				INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,storeitemid,qty1,added,tkotid,Splinstruction,KITCHENMSG,nckot,nctypeid,ncaccid)
				values(@part,@billid,@itemid,@tqty,@rate,@amt,@tableid,@iscoktail,@storeitemid,@tqty,0,@kotid,@splinstruction,@kitmsg,@nc,@nctypeid,@ncaccid)
				INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,@tqty,ident_current('Trans_BARKot_det '))
				set	@Tamt1=@amt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
					
                    
               FETCH NEXT FROM kotitemsfetch170719 INTO  @baritemname,@nccoversion,@nckotaccounttype,@nctype,@splinstruction,@kitmsg,
 @pax,@storeitemid,@iscoktail,@trat,@kotid,@tqty,@itemid,@itemname,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt
                END
                CLOSE kotitemsfetch170719
                DEALLOCATE kotitemsfetch170719



declare kotitemsfetch170720 cursor for 


SELECT DISTINCT btm.BarItemname,tk2.NCconversionreson,Splinstruction,KITMSG,tk2.Noofpax,iscocktail,tk2.TRat,Kot_Id,Tqty,
tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					INNER JOIN Stock_Itemmmas s on s.Itemid=bid.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 				
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid
					and tk2.Approved ='1' and iscocktail ='Y'
					group by tk2.Itemid,btm.BarItemname,tk2.NCconversionreson,tk2.Noofpax,iscocktail,tk2.TRat,Kot_Id,Tqty,TableId,tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt,Tqty,Splinstruction,KITMSG
open kotitemsfetch170720        


    FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg, @pax,
@iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool1 = 1
				IF(@nckotaccounttype=0)
					BEGIN
						set @rate = @trat
						set @amt=@tamt
						
					END
				ELSE
				    BEGIN
					
						set @rate = 0.00
						set @amt=0.00
						
					END
				    INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,storeitemid,qty1,added,tkotid,Splinstruction,KITCHENMSG,nckot,nctypeid,ncaccid)
				values(@part,@billid,@itemid,@tqty,@rate,@amt,@tableid,@iscoktail,@storeitemid,@tqty,0,@kotid,@splinstruction,@kitmsg,@nc,@nctypeid,@ncaccid)
					INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,@tqty,ident_current('Trans_BARKot_det '))

				
				set	@Tamt1=@amt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
                    
                FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg, @pax,
                @iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt
                END
                CLOSE kotitemsfetch170720
                DEALLOCATE kotitemsfetch170720

				if(@bool1=1)
				BEGIN
					select @Employeeid = Employeeid from employee WHERE istabsteward='1'
				END

					
--UPdate Mas
  UPdate dbo.Trans_BARKot_mas set part=@part, totalamount=@sum11,nckot=@nc,nctypeid=@nctypeid where Kotid=@billid

 update Tablemas set Status='K' where Tableid=@tableid
 Delete from temp_kot2 where Tableid=@tableid
 select @billid as ID

 /**  10.01.2024 -- */

 ALTER PROCEDURE [dbo].[Get_NCKot] @ID BIGINT=0 ,@fromdate datetime,@todate datetime
as 
BEGIN  
SELECT * FROM Trans_BARKot_mas c 
                    INNER JOIN Mas_nckottype  s ON s.typeid= c.nctypeid
					where c.nctypeid =  @ID and kotdate between @fromdate and @todate
					order by Kotid desc END

=========================================18.01.2024 Reports ======================================================

insert into submenu(submenu,mnid,act,des)values('NC KOT Bill Wise', '3','1', 'NcKotBillWise')


 ALTER PROCEDURE [dbo].[Get_NCKot] @ID BIGINT=0 ,@fromdate datetime,@todate datetime
as 
BEGIN  
SELECT * FROM Trans_BARKot_mas c 
                    INNER JOIN Mas_nckottype  s ON s.typeid= c.nctypeid
					inner join tablemas t on t.Tableid=c.tableid
					where c.nctypeid =  @ID and kotdate between @fromdate and @todate
					order by Kotid desc END


insert into submenu(submenu,mnid,act,des)values('Date Wise Hourly Sales', '3','3', 'DateWiseHSales')




/* for hidinig the menu tables - diamond club 01.02.2024 */
use diamond


select pass,* from username


ALTER procedure [dbo].[Get__submenu]
@menuid bigint 
As

select * from submenu where MNID=@menuid  order by act asc



ALTER procedure [dbo].[Get__menu]
As

select * from menu 






create procedure [dbo].[Get__menu1]
As

select * from menu where menu not in('Transaction', 'Settings')


create procedure [dbo].[Get__submenu1]
@menuid bigint 
As

select * from submenu where MNID=@menuid and submenu not in('ML','Tax','Fire Master', 'As on date sales', 
'stock report', 'Bar stock report','Bar stock report 2') order by act asc



/* print nor barkot print not workin issue -- solved 03.02.2024 */



ALTER procedure [dbo].[kot__save__two]
@tableid bigint,@counter bigint, @sessionid bigint, @tokenno bigint,@refdate datetime,@reftime datetime,@noofpax bigint,@Stwid bigint
As

declare @qty bigint ,@part varchar(100),@itemid bigint ,@tqty bigint,@trat numeric(12,2),@tamt numeric(12,2), @bool bigint=0,
@iscoktail varchar(2),@storeitemid bigint,@kotid bigint,@splinstruction varchar(1000),@kitmsg varchar(1000),
@nccoversion varchar(1000),
@Tamt1 numeric(12,2), @sum11 numeric(12,2),@ncreson varchar(1000),@Employeeid bigint,@billid bigint, @baritemname varchar(500),
@pax bigint, @sbarstockqty bigint,@icecreamorfood bigint,@otheritems bigint,@bool1 bigint,@nckotaccounttype bigint,@nctype varchar(100),
@itemname  varchar(100),@nc bigint, @nctypeid bigint, @ncaccid bigint,@amt numeric(12,2),@rate numeric(12,2)
set @sum11=0
set @sum11=0
set @amt=0

  INSERT INTO dbo.Trans_BARKot_mas(Refno,Raised,counterid,noofpax,part,tableid,Stwid,Kotno,Kotdate,  Kottime, totalamount, rOOMORTAB,Userid,sessionid,tokenno,NCconversionreson,refkotdate,refkottime) 
  VALUES ('','0',@counter,@noofpax,@part,@tableid,@Stwid,  dbo.RotNo(),@refdate,@reftime, @sum11,'T',1,@sessionid, @tokenno,@ncreson,convert(VARCHAR,getdate(),101), convert(VARCHAR,getdate(),108)) 
 set @billid=(Select SCOPE_IDENTITY())

declare kotitemsfetch170719 cursor for 
SELECT DISTINCT btm.BarItemname,tk2.NCconversionreson,nckotaccounttype,nctype,
					Splinstruction,KITMSG,tk2.Noofpax,tk2.storeitemid,iscocktail,tk2.TRat,Kot_Id,Tqty,tk2.Itemid,
					s.Itemname,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Stock_Itemmmas s on s.Itemid=tk2.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid
					and tk2.Approved ='1'
set @bool1=0
open kotitemsfetch170719 
     

   FETCH NEXT FROM kotitemsfetch170719 INTO  @baritemname,@nccoversion,@nckotaccounttype,@nctype,@splinstruction,@kitmsg,
 @pax,@storeitemid,@iscoktail,@trat,@kotid,@tqty,@itemid,@itemname,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool1 = 1
				IF(@nckotaccounttype=0)
					BEGIN
						set @nc=0
						set @nctypeid=0
						set @rate = @trat
						set @amt=@tamt
						set @ncaccid=0
					END
				ELSE
				    BEGIN
						set @nc=1
						set @nctypeid=@nctype
						set @rate = 0.00
						set @amt=0.00
						set @ncaccid=@nckotaccounttype
					END
				
				INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,storeitemid,qty1,added,tkotid,Splinstruction,KITCHENMSG,nckot,nctypeid,ncaccid)
				values(@part,@billid,@itemid,@tqty,@rate,@amt,@tableid,@iscoktail,@storeitemid,@tqty,0,@kotid,@splinstruction,@kitmsg,@nc,@nctypeid,@ncaccid)
				INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,@tqty,ident_current('Trans_BARKot_det '))
				set	@Tamt1=@amt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
					
                    
               FETCH NEXT FROM kotitemsfetch170719 INTO  @baritemname,@nccoversion,@nckotaccounttype,@nctype,@splinstruction,@kitmsg,
 @pax,@storeitemid,@iscoktail,@trat,@kotid,@tqty,@itemid,@itemname,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt
                END
                CLOSE kotitemsfetch170719
                DEALLOCATE kotitemsfetch170719



declare kotitemsfetch170720 cursor for 


SELECT DISTINCT btm.BarItemname,tk2.NCconversionreson,Splinstruction,KITMSG,tk2.Noofpax,iscocktail,tk2.TRat,Kot_Id,Tqty,
tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					INNER JOIN Stock_Itemmmas s on s.Itemid=bid.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 				
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid
					and tk2.Approved ='1' and iscocktail ='Y'
					group by tk2.Itemid,btm.BarItemname,tk2.NCconversionreson,tk2.Noofpax,iscocktail,tk2.TRat,Kot_Id,Tqty,TableId,tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt,Tqty,Splinstruction,KITMSG
open kotitemsfetch170720        


    FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg, @pax,
@iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool1 = 1
				IF(@nckotaccounttype=0)
					BEGIN
						set @rate = @trat
						set @amt=@tamt
						
					END
				ELSE
				    BEGIN
					
						set @rate = 0.00
						set @amt=0.00
						
					END
				    INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,storeitemid,qty1,added,tkotid,Splinstruction,KITCHENMSG,nckot,nctypeid,ncaccid)
				values(@part,@billid,@itemid,@tqty,@rate,@amt,@tableid,@iscoktail,@storeitemid,@tqty,0,@kotid,@splinstruction,@kitmsg,@nc,@nctypeid,@ncaccid)
					INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,@tqty,ident_current('Trans_BARKot_det '))

				
				set	@Tamt1=@amt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
                    
                FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg, @pax,
                @iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt
                END
                CLOSE kotitemsfetch170720
                DEALLOCATE kotitemsfetch170720

				if(@bool1=1)
				BEGIN
					select @Employeeid = Employeeid from employee WHERE istabsteward='1'
				END

					
--UPdate Mas
  UPdate dbo.Trans_BARKot_mas set part=@part, totalamount=@sum11,nckot=@nc,nctypeid=@nctypeid where Kotid=@billid

 update Tablemas set Status='K' where Tableid=@tableid
 --Delete from temp_kot2 where Tableid=@tableid
 select @billid as ID




 ==============================  repeater amouont shows 0 issue ===============================

 USE [diamond]
GO
/****** Object:  StoredProcedure [dbo].[kot__save__two]    Script Date: 05/02/2024 16:18:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[kot__save__two]
@tableid bigint,@counter bigint, @sessionid bigint, @tokenno bigint,@refdate datetime,@reftime datetime,@noofpax bigint,@Stwid bigint
As

declare @qty bigint ,@part varchar(100),@itemid bigint ,@tqty bigint,@trat numeric(12,2),@tamt numeric(12,2), @bool bigint=0,
@iscoktail varchar(2),@storeitemid bigint,@kotid bigint,@splinstruction varchar(1000),@kitmsg varchar(1000),
@nccoversion varchar(1000),
@Tamt1 numeric(12,2), @sum11 numeric(12,2),@ncreson varchar(1000),@Employeeid bigint,@billid bigint, @baritemname varchar(500),
@pax bigint, @sbarstockqty bigint,@icecreamorfood bigint,@otheritems bigint,@bool1 bigint,@nckotaccounttype bigint,@nctype varchar(100),
@itemname  varchar(100),@nc bigint, @nctypeid bigint, @ncaccid bigint,@amt numeric(12,2),@rate numeric(12,2)
set @sum11=0
set @sum11=0
set @amt=0

  INSERT INTO dbo.Trans_BARKot_mas(Refno,Raised,counterid,noofpax,part,tableid,Stwid,Kotno,Kotdate,  Kottime, totalamount, rOOMORTAB,Userid,sessionid,tokenno,NCconversionreson,refkotdate,refkottime) 
  VALUES ('','0',@counter,@noofpax,@part,@tableid,@Stwid,  dbo.RotNo(),@refdate,@reftime, @sum11,'T',1,@sessionid, @tokenno,@ncreson,convert(VARCHAR,getdate(),101), convert(VARCHAR,getdate(),108)) 
 set @billid=(Select SCOPE_IDENTITY())

declare kotitemsfetch170719 cursor for 
SELECT DISTINCT btm.BarItemname,tk2.NCconversionreson,isnull(tk2.nckotaccounttype,0) as nckotaccounttype ,nctype,
					Splinstruction,KITMSG,tk2.Noofpax,tk2.storeitemid,iscocktail,tk2.TRat,Kot_Id,Tqty,tk2.Itemid,
					s.Itemname,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Stock_Itemmmas s on s.Itemid=tk2.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=3
					and tk2.Approved ='1'
set @bool1=0
open kotitemsfetch170719 
     

   FETCH NEXT FROM kotitemsfetch170719 INTO  @baritemname,@nccoversion,@nckotaccounttype,@nctype,@splinstruction,@kitmsg,
 @pax,@storeitemid,@iscoktail,@trat,@kotid,@tqty,@itemid,@itemname,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool1 = 1
				IF(@nckotaccounttype=0)
					BEGIN
						set @nc=0
						set @nctypeid=0
						set @rate = @trat
						set @amt=@tamt
						set @ncaccid=0
					END
				ELSE
				    BEGIN
						set @nc=1
						set @nctypeid=@nctype
						set @rate = 0.00
						set @amt=0.00
						set @ncaccid=@nckotaccounttype
					END
				
				INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,storeitemid,qty1,added,tkotid,Splinstruction,KITCHENMSG,nckot,nctypeid,ncaccid)
				values(@part,@billid,@itemid,@tqty,@rate,@amt,@tableid,@iscoktail,@storeitemid,@tqty,0,@kotid,@splinstruction,@kitmsg,@nc,@nctypeid,@ncaccid)
				INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,@tqty,ident_current('Trans_BARKot_det '))
				set	@Tamt1=@amt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
					
                    
               FETCH NEXT FROM kotitemsfetch170719 INTO  @baritemname,@nccoversion,@nckotaccounttype,@nctype,@splinstruction,@kitmsg,
 @pax,@storeitemid,@iscoktail,@trat,@kotid,@tqty,@itemid,@itemname,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt
                END
                CLOSE kotitemsfetch170719
                DEALLOCATE kotitemsfetch170719



declare kotitemsfetch170720 cursor for 


SELECT DISTINCT btm.BarItemname,tk2.NCconversionreson,Splinstruction,KITMSG,tk2.Noofpax,iscocktail,tk2.TRat,Kot_Id,Tqty,
tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					INNER JOIN Stock_Itemmmas s on s.Itemid=bid.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 				
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid
					and tk2.Approved ='1' and iscocktail ='Y'
					group by tk2.Itemid,btm.BarItemname,tk2.NCconversionreson,tk2.Noofpax,iscocktail,tk2.TRat,Kot_Id,Tqty,TableId,tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt,Tqty,Splinstruction,KITMSG
open kotitemsfetch170720        


    FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg, @pax,
@iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool1 = 1
				IF(@nckotaccounttype=0)
					BEGIN
						set @rate = @trat
						set @amt=@tamt
						
					END
				ELSE
				    BEGIN
					
						set @rate = 0.00
						set @amt=0.00
						
					END
				    INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,storeitemid,qty1,added,tkotid,Splinstruction,KITCHENMSG,nckot,nctypeid,ncaccid)
				values(@part,@billid,@itemid,@tqty,@rate,@amt,@tableid,@iscoktail,@storeitemid,@tqty,0,@kotid,@splinstruction,@kitmsg,@nc,@nctypeid,@ncaccid)
					INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,@tqty,ident_current('Trans_BARKot_det '))

				
				set	@Tamt1=@amt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
                    
                FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg, @pax,
                @iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt
                END
                CLOSE kotitemsfetch170720
                DEALLOCATE kotitemsfetch170720

				if(@bool1=1)
				BEGIN
					select @Employeeid = Employeeid from employee WHERE istabsteward='1'
				END

					
--UPdate Mas
  UPdate dbo.Trans_BARKot_mas set part=@part, totalamount=@sum11,nckot=@nc,nctypeid=@nctypeid where Kotid=@billid

 update Tablemas set Status='K' where Tableid=@tableid
 --Delete from temp_kot2 where Tableid=@tableid
 select @billid as ID



 ============================Dashboard ===============================

 
create procedure [dbo].[weeklysettlement__dashboard]
 @fromdate datetime, @todate datetime
 As
 select isnull(sum(se.totalamount),0) as totalAmount, SettleDate from Trans_BARKotSettlement_mas se
 where se.SettleDate between @fromdate and @todate
 group by SettleDate
 order by SettleDate



 alter procedure [dbo].[daysettlement__dashboard]
 @fromdate datetime,@todate datetime
 as
 select isnull(sum(det.amount),0) as amount, pm.paymode from Trans_BARKotSettlement_mas
  se inner join Trans_BARKotSettlement_det det on se.Settlid=det.Setllid
 inner join paymode pm on pm.Payid = det.Paymodeid
 where se.SettleDate between @fromdate  and @todate
 group by pm.paymode , det.amount



===============Company master 05/02/2024 =========================



insert into submenu (SUBMENU,mnid,act,des)values('General', '1','1','')
insert into mainmenu(submenuid,menu,act,des,ord)values(31,'Company',1,'Add_Company',1)




create procedure Exec__Company
 @restypeid bigint,@name varchar(1000),@name1 varchar(1000),@address1 varchar(1000), @address2 varchar(1000),
 @city varchar(1000),@phone varchar(1000),@mobile varchar(1000),@email varchar(1000),@reporttype varchar(1000),@gstno varchar(1000),
  @narration varchar(1000),@narration1 varchar(1000),@fssai varchar(1000)
  as
  
  declare @count bigint
  
  set @count = (select count(*) from headings where restypeid=@restypeid)
  
  if(@count <>0)
	begin
		update headings set name=@name,name1=@name1,address1=@address1,address2=@address2,city=@city,
		phone=@phone,mobileno=@mobile,email=@email,ReportType=@reporttype,tinno=@gstno,bottomnarration=@narration,
		bottomnarration1=@narration1,fssai=@fssai where restypeid=@restypeid
	end 


alter table headings add bottomnarration1 varchar(1000)
alter table headings add fssai varchar(1000)

alter table Itemcategory add shortname varchar(10)




ALTER procedure [dbo].[kot__save__two]
@tableid bigint,@counter bigint, @sessionid bigint, @tokenno bigint,@refdate datetime,@reftime datetime,@noofpax bigint,@Stwid bigint
As

declare @qty bigint ,@part varchar(100),@itemid bigint ,@tqty bigint,@trat numeric(12,2),@tamt numeric(12,2), @bool bigint=0,
@iscoktail varchar(2),@storeitemid bigint,@kotid bigint,@splinstruction varchar(1000),@kitmsg varchar(1000),
@nccoversion varchar(1000),
@Tamt1 numeric(12,2), @sum11 numeric(12,2),@ncreson varchar(1000),@Employeeid bigint,@billid bigint, @baritemname varchar(500),
@pax bigint, @sbarstockqty bigint,@icecreamorfood bigint,@otheritems bigint,@bool1 bigint,@nckotaccounttype bigint,@nctype varchar(100),
@itemname  varchar(100),@nc bigint, @nctypeid bigint, @ncaccid bigint,@amt numeric(12,2),@rate numeric(12,2)
set @sum11=0
set @sum11=0
set @amt=0

  INSERT INTO dbo.Trans_BARKot_mas(Refno,Raised,counterid,noofpax,part,tableid,Stwid,Kotno,Kotdate,  Kottime, totalamount, rOOMORTAB,Userid,sessionid,tokenno,NCconversionreson,refkotdate,refkottime) 
  VALUES ('','0',@counter,@noofpax,@part,@tableid,@Stwid,  dbo.RotNo(),@refdate,@reftime, @sum11,'T',1,@sessionid, @tokenno,@ncreson,convert(VARCHAR,getdate(),101), convert(VARCHAR,getdate(),108)) 
 set @billid=(Select SCOPE_IDENTITY())

declare kotitemsfetch170719 cursor for 
SELECT DISTINCT btm.BarItemname,tk2.NCconversionreson,isnull(tk2.nckotaccounttype,0) as nckotaccounttype ,nctype,
					Splinstruction,KITMSG,tk2.Noofpax,tk2.storeitemid,iscocktail,tk2.TRat,Kot_Id,Tqty,tk2.Itemid,
					s.Itemname,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Stock_Itemmmas s on s.Itemid=tk2.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid
					and tk2.Approved ='1'
set @bool1=0
open kotitemsfetch170719 
     

   FETCH NEXT FROM kotitemsfetch170719 INTO  @baritemname,@nccoversion,@nckotaccounttype,@nctype,@splinstruction,@kitmsg,
 @pax,@storeitemid,@iscoktail,@trat,@kotid,@tqty,@itemid,@itemname,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool1 = 1
				IF(@nckotaccounttype=0)
					BEGIN
						set @nc=0
						set @nctypeid=0
						set @rate = @trat
						set @amt=@tamt
						set @ncaccid=0
					END
				ELSE
				    BEGIN
						set @nc=1
						set @nctypeid=@nctype
						set @rate = 0.00
						set @amt=0.00
						set @ncaccid=@nckotaccounttype
					END
				
				INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,storeitemid,qty1,added,tkotid,Splinstruction,KITCHENMSG,nckot,nctypeid,ncaccid)
				values(@part,@billid,@itemid,@tqty,@rate,@amt,@tableid,@iscoktail,@storeitemid,@tqty,0,@kotid,@splinstruction,@kitmsg,@nc,@nctypeid,@ncaccid)
				INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,@tqty,ident_current('Trans_BARKot_det '))
				set	@Tamt1=@amt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
					
                    
               FETCH NEXT FROM kotitemsfetch170719 INTO  @baritemname,@nccoversion,@nckotaccounttype,@nctype,@splinstruction,@kitmsg,
 @pax,@storeitemid,@iscoktail,@trat,@kotid,@tqty,@itemid,@itemname,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt
                END
                CLOSE kotitemsfetch170719
                DEALLOCATE kotitemsfetch170719



declare kotitemsfetch170720 cursor for 


SELECT DISTINCT btm.BarItemname,tk2.NCconversionreson,Splinstruction,KITMSG,tk2.Noofpax,iscocktail,tk2.TRat,Kot_Id,Tqty,
tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					INNER JOIN Stock_Itemmmas s on s.Itemid=bid.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 				
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid
					and tk2.Approved ='1' and iscocktail ='Y'
					group by tk2.Itemid,btm.BarItemname,tk2.NCconversionreson,tk2.Noofpax,iscocktail,tk2.TRat,Kot_Id,Tqty,TableId,tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt,Tqty,Splinstruction,KITMSG
open kotitemsfetch170720        


    FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg, @pax,
@iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool1 = 1
				IF(@nckotaccounttype=0)
					BEGIN
						set @rate = @trat
						set @amt=@tamt
						
					END
				ELSE
				    BEGIN
					
						set @rate = 0.00
						set @amt=0.00
						
					END
				    INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,storeitemid,qty1,added,tkotid,Splinstruction,KITCHENMSG,nckot,nctypeid,ncaccid)
				values(@part,@billid,@itemid,@tqty,@rate,@amt,@tableid,@iscoktail,@storeitemid,@tqty,0,@kotid,@splinstruction,@kitmsg,@nc,@nctypeid,@ncaccid)
					INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,@tqty,ident_current('Trans_BARKot_det '))

				
				set	@Tamt1=@amt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
                    
                FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg, @pax,
                @iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt
                END
                CLOSE kotitemsfetch170720
                DEALLOCATE kotitemsfetch170720

				if(@bool1=1)
				BEGIN
					select @Employeeid = Employeeid from employee WHERE istabsteward='1'
				END

					
--UPdate Mas
  UPdate dbo.Trans_BARKot_mas set part=@part, totalamount=@sum11,nckot=@nc,nctypeid=@nctypeid where Kotid=@billid

 update Tablemas set Status='K' where Tableid=@tableid
 --Delete from temp_kot2 where Tableid=@tableid
 select @billid as ID





 ALTER PROCEDURE [dbo].[Exec_ItemCategory] 
 @itemcategory VARCHAR (100) ,
 @accledgerid BIGINT,
 @uid BIGINT=0,@SType VARCHAR(100),@inactive bigint, @shortname varchar(10) AS 
 
 BEGIN
 
  IF @SType = 'SAVE'
	BEGIN
	  INSERT INTO dbo.Itemcategory (itemcategory, accledgerid,inactive,shortname)
      VALUES (@itemcategory, @accledgerid,@inactive,@shortname)
	 SELECT 'Successfully Saved' AS MGS
	END 
	
  IF @SType = 'UPDATE'
  BEGIN
    
 UPDATE dbo.Itemcategory
SET  
	itemcategory= @itemcategory,
	 
	
	accledgerid = @accledgerid,inactive=@inactive,shortname=@shortname
	
  WHERE  itemcategoryid = @uid

   
    SELECT 'Successfully Updated' AS MGS
    
  END
  
  IF @SType = 'DELETE'
  BEGIN
    
    SELECT 'Successfully Deleted' AS MGS
    
  END
  END




create PROCEDURE KotBarBillItemt__summary @id BIGINT as
SELECT i.barItemname AS Itemname,
isnull(sum(d.qty),0)qty,isnull(sum(d.Rate),0)as Rate,isnull(sum(d.Amount),0) as 
Amount FROM Trans_BARKot_mas m
INNER JOIN Trans_BARKot_det d ON d.kotid=m.Kotid
INNER JOIN Bar_itemmmas  i ON i.barItemid=d.itemid
 INNER JOIN Stock_itemmmas stk on stk.Itemid=d.storeitemid
  INNER JOIN itemgroup ig on ig.Itemgroupid=stk.Itemgroupid 
  INNER JOIN Itemcategory ic on ic.itemcategoryid=ig.Itemcategoryid 
WHERE isnull(m.Raised,0)=0 AND m.tableid=@id and isnull(d.cANCELORNORM,'')<>'C'  
 and isnull(SplitBillRaised,0)=0 
 group by i.BarItemname 
order by Kottime desc



ALTER PROCEDURE [dbo].[KotBarBillItemt__summary] @id BIGINT as
SELECT i.barItemname AS Itemname,
isnull(sum(d.qty),0)qty,isnull(sum(d.Rate),0)as Rate,isnull(sum(d.Amount),0) as Amount
 FROM Trans_BARKot_mas m
INNER JOIN Trans_BARKot_det d ON d.kotid=m.Kotid
INNER JOIN Bar_itemmmas  i ON i.barItemid=d.itemid
 INNER JOIN Stock_itemmmas stk on stk.Itemid=d.storeitemid
  INNER JOIN itemgroup ig on ig.Itemgroupid=stk.Itemgroupid 
  INNER JOIN Itemcategory ic on ic.itemcategoryid=ig.Itemcategoryid 
WHERE isnull(m.Raised,0)=0 AND m.tableid=@id and isnull(d.cANCELORNORM,'')<>'C'  
 and isnull(SplitBillRaised,0)=0 
 group by i.BarItemname 


insert into submenu (submenu,mnid,act,des) values('Kot Cancellation',3,9,'KotBill_cancellation')



/** outbox table changes --10.02.2024 --------------**/

alter table outbox add hotelcode varchar(100)


/*** Hotelcode random number generation *////

alter table headings add hotelcode varchar(100);

alter table extraoption add enablewhatsappsms bigint


create PROCEDURE [dbo].[Log_TabUser_tab] @pass VARCHAR(100)
as

SELECT * FROM username WHERE pass=@pass and pass='tabuser'


/*** suer with kotedit/delete and bill cancel restricted 14.02.2024*//
update username set username='Baruser' ,pass='baruser' where userid=4

/*** usernanme validation 14.02.2024 **/

ALTER PROCEDURE [dbo].[Log_TabUser_tab] @pass VARCHAR(100),@username varchar(1000)
as

SELECT * FROM username WHERE pass=@pass and pass='tabuser' and username=@username


ALTER PROCEDURE [dbo].[Log_TabUser] @pass VARCHAR(100),@username varchar(1000)
as

SELECT * FROM username WHERE pass=@pass and username=@username



/*** stock validation  corrections -- 16.02.2024 **/

USE [diamond]
GO
/****** Object:  StoredProcedure [dbo].[kot__save__one]    Script Date: 16/02/2024 12:29:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[kot__save__one]
@tableid bigint,@counter bigint, @sessionid bigint, @tokenno bigint,@noofpax bigint,@Employee varchar(100)
As

declare @maskotcoout bigint=0
declare @qty bigint ,@part varchar(100),@itemid bigint ,@tqty bigint,@trat numeric(12,2),
@tamt numeric(12,2), @bool bigint=0,
@iscoktail varchar(2),@storeitemid bigint,@kotid bigint,@splinstruction varchar(1000),@kitmsg varchar(1000),
@nccoversion varchar(1000),
@Tamt1 numeric(12,2), @sum11 numeric(12,2)=0,@ncreson varchar(1000),@Employeeid bigint,@billid bigint


set @maskotcoout= (select count(*) from trans_barkot_mas)


declare kotitemsfetch170719 cursor for 

SELECT DISTINCT bid.qty ,tk2.part,tk2.Itemid,Tqty,tk2.TRat,Tamt,iscocktail,
tk2.storeitemid,Kot_Id,Splinstruction,KITMSG,tk2.NCconversionreson
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Stock_Itemmmas s on s.Itemid=tk2.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid
					--and isnull(tk2.Approved,0) =0
					 and  iscocktail <>'D'

open kotitemsfetch170719
set @maskotcoout= (select count(*) from trans_barkot_mas) 
set @billid= (select ident_current('Trans_BARKot_mas'))
		if(@billid > 1 and @maskotcoout >0)
		BEGIN
			set @billid = @billid+1						
		END       

    FETCH NEXT FROM kotitemsfetch170719 INTO  @qty,@part,@itemid,@tqty,@trat,@tamt,@iscoktail,@storeitemid,@kotid,@splinstruction,@kitmsg,@nccoversion
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool = 1
				INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,storeitemid,qty1,added,tkotid,Splinstruction,KITCHENMSG)values(@part,@billid,@itemid,@tqty,@trat,@tamt,@tableid,@iscoktail,@storeitemid,@tqty,0,@kotid,@splinstruction,@kitmsg)
				INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,@tqty,ident_current('Trans_BARKot_det '))
				set	@Tamt1=@tamt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
                    
                FETCH NEXT FROM kotitemsfetch170719 INTO @qty,@part,@itemid,@tqty,@trat,@tamt,@iscoktail,@storeitemid,@kotid,@splinstruction,@kitmsg,@nccoversion
                END
                CLOSE kotitemsfetch170719
                DEALLOCATE kotitemsfetch170719




declare @baritemname varchar(500),@pax bigint, @sbarstockqty bigint,@icecreamorfood bigint,@otheritems bigint,@bool1 bigint
set @bool = 0

declare kotitemsfetch170720 cursor for 

SELECT DISTINCT btm.BarItemname,tk2.NCconversionreson,Splinstruction,KITMSG,tk2.Noofpax,iscocktail,tk2.TRat,
Kot_Id,Tqty,tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					INNER JOIN Stock_Itemmmas s on s.Itemid=bid.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 				
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid
					and tk2.Approved ='1' 
					and iscocktail ='D'
					--and iscocktail ='Y'
					group by tk2.Itemid,btm.BarItemname,tk2.Noofpax,iscocktail,tk2.NCconversionreson,tk2.TRat,Kot_Id,Tqty,TableId,tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt,Tqty,Splinstruction,KITMSG

open kotitemsfetch170720        

set @maskotcoout= (select count(*) from trans_barkot_mas)
set @billid= (select ident_current('Trans_BARKot_mas'))
		if(@billid >1 and @maskotcoout >0)
		BEGIN
			set @billid = @billid+1						
		END
    FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg,@pax,
	@iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool = 1
				
					INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,qty1,added,
					tkotid,Splinstruction,KITCHENMSG)values
					(@part,@billid,@itemid,@tqty,@trat,@tamt,@tableid,@iscoktail,@tqty,0,@kotid,@splinstruction,@kitmsg ) 
					INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,@tqty,ident_current('Trans_BARKot_det '))

				
				set	@Tamt1=@tamt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
                    
                FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg,@pax,
	            @iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt
                END
                CLOSE kotitemsfetch170720
                DEALLOCATE kotitemsfetch170720

			set @Employeeid = (select Employeeid from employee WHERE Employee=@Employee)
				

				
				
  INSERT INTO dbo.Trans_BARKot_mas(Refno,Raised,counterid,noofpax,part,tableid,Stwid,Kotno,Kotdate, 
  Kottime, totalamount, rOOMORTAB,Userid,sessionid,tokenno,NCconversionreson) 
  VALUES ('','0',@counter,@noofpax,@part,@tableid,@Employeeid,
  dbo.RotNo(),convert(VARCHAR,getdate(),101), convert(VARCHAR,getdate(),108), @sum11,'T',1,@sessionid,
 @tokenno,@ncreson) 





ALTER procedure [dbo].[datapurging]
@key varchar(20)
AS

if(@key='MASTER')
	BEGin
		 truncate table Bar_itemmmas
		 truncate table bar_itemdet_id
		 truncate table Employee
		 truncate table mas_fire
		 truncate table Itemcategory
		 truncate table Itemgroup
		 truncate table Barmltype
		 truncate table Mas_nckottype
		 truncate table Mas_nckotaccount
		 truncate table Stock_itemmmas
		 truncate table Supplier
		 truncate table Table_Group
		 truncate table Tablemas
		 truncate table taxsetupmas
		 truncate table taxsetupdet
		 truncate table taxsetupacdet
		 truncate table taxtype

	END

if(@key='Transaction')
	BEGIN
		truncate table Trans_Bar_InwardMas
		truncate table Trans_Bar_Inwarddet
		truncate table trans_bar_purchasemas
		truncate table Trans_bar_purchasedet
		truncate table Trans_BarStoreopening_mas
		truncate table Trans_BarStoreopening_det
		truncate table trans_bar_stockadjustmentdet
		truncate table trans_bar_stockadjustmentmas
		truncate table Trans_BARKot_det
		truncate table Trans_BARKot1_det
		truncate table Trans_BARKot_mas
		truncate table Trans_BARKot1_mas
		truncate table Trans_BARKotdet_id
		update tablemas set status='S'
		truncate table Trans_BARKotSettlement_mas
		truncate table Trans_BARKotSettlement1_det
		truncate table Trans_BARKotSettlement_det
		truncate table temp_settlement
		truncate table Trans_BARKotBillraise_mas
		truncate table Trans_BARKotBillraise_det
		update Stock_itemmmas set BarStockqty=0,BariSsueqty=0,StoreStockqty=0,StorePurqty=0,BarSalqty=0

	END


----=================================== stock opening changes --21-02-2024 ============================================================================================================


ALTER PROCEDURE [dbo].[Exec_Stockmas]
-- @Storeopstock BIGINT,
 @Openingdate datetime,
 --@stock BIGINT,
 --@Itemcode BIGINT,
 @opening BIGINT,
 @Type BIGINT
 --@SType VARCHAR(100)  
 AS  
 BEGIN
 IF @Type = '0'
	BEGIN
	  INSERT INTO Trans_BarStoreopening_mas (Openingdate,Draftmode)
      VALUES (@Openingdate,@opening)
	 SELECT 'Successfully Saved' AS MGS
END
END


ALTER procedure [dbo].[datapurging]
@key varchar(20)
AS

if(@key='MASTER')
	BEGin
		 truncate table Bar_itemmmas
		 truncate table bar_itemdet_id
		 truncate table Employee
		 truncate table mas_fire
		 truncate table Itemcategory
		 truncate table Itemgroup
		 truncate table Barmltype
		 truncate table Mas_nckottype
		 truncate table Mas_nckotaccount
		 truncate table Stock_itemmmas
		 truncate table Supplier
		 truncate table Table_Group
		 truncate table Tablemas
		 truncate table taxsetupmas
		 truncate table taxsetupdet
		 truncate table taxsetupacdet
		 truncate table taxtype

	END

if(@key='Transaction')
	BEGIN
		truncate table Trans_Bar_InwardMas
		truncate table Trans_Bar_Inwarddet
		truncate table trans_bar_purchasemas
		truncate table Trans_bar_purchasedet
		truncate table Trans_BarStoreopening_mas
		truncate table Trans_BarStoreopening_det
		truncate table trans_bar_stockadjustmentdet
		truncate table trans_bar_stockadjustmentmas
		truncate table Trans_BARKot_det
		truncate table Trans_BARKot1_det
		truncate table Trans_BARKot_mas
		truncate table Trans_BARKot1_mas
		truncate table Trans_BARKotdet_id
		update tablemas set status='S'
		truncate table Trans_BARKotSettlement_mas
		truncate table Trans_BARKotSettlement1_det
		truncate table Trans_BARKotSettlement_det
		truncate table temp_settlement
		truncate table Trans_BARKotBillraise_mas
		truncate table Trans_BARKotBillraise_det
		update Stock_itemmmas set BarStockqty=0,BariSsueqty=0,StoreStockqty=0,StorePurqty=0,BarSalqty=0,storeopstock=0,StoreAdjQty=0,Baropstock=0,BarAdjQty=0

	END




---------------------------------------------corrections elanza stock validation 23.02.2024-----------------------


ALTER PROCEDURE [dbo].[Get_ItemReport] @ID BIGINT=0,@BID bigint=0 as 
BEGIN  
select * from Stock_itemmmas
WHERE Itemgroupid  =(CASE WHEN @ID=0 THEN  Itemgroupid ELSE @ID END ) and Itemid=(CASE WHEN @BID=0 THEN  Itemid ELSE @BID END )
 order by  Itemgroupid  desc END





ALTER PROCEDURE [dbo].[KotBarBillItemt] @id BIGINT as
SELECT 
ic.itemcategoryid,i.Servicetax,d.kotdetid,m.noofpax,SplitBillRaised,d.storeitemid,
Kottime,Stwid,i.Surchrgs,i.discountnotapplicable,i.Saltax,d.itemid,m.Kotid,m.Kotno,
i.barItemname AS Itemname,d.qty,d.Rate,d.Amount
 FROM Trans_BARKot_mas m
INNER JOIN Trans_BARKot_det d ON d.kotid=m.Kotid
INNER JOIN Bar_itemmmas  i ON i.barItemid=d.itemid
inner join bar_itemdet_id bd on bd.RefBarItemid=i.BarItemid
 INNER JOIN Stock_itemmmas stk on stk.Itemid=bd.storeitemid
  INNER JOIN itemgroup ig on ig.Itemgroupid=stk.Itemgroupid 
  INNER JOIN Itemcategory ic on ic.itemcategoryid=ig.Itemcategoryid 
WHERE isnull(m.Raised,0)=0 AND m.tableid=@id and isnull(d.cANCELORNORM,'')<>'C'  
 and isnull(SplitBillRaised,0)=0 
order by Kottime desc




ALTER PROCEDURE [dbo].[KotBarBillItemt__summary] @id BIGINT as
SELECT i.barItemname AS Itemname,
isnull(sum(d.qty),0)qty,isnull(sum(d.Rate),0)as Rate,isnull(sum(d.Amount),0) as Amount FROM Trans_BARKot_mas m
INNER JOIN Trans_BARKot_det d ON d.kotid=m.Kotid
INNER JOIN Bar_itemmmas  i ON i.barItemid=d.itemid
inner join bar_itemdet_id bd on bd.RefBarItemid=i.BarItemid
 INNER JOIN Stock_itemmmas stk on stk.Itemid=bd.storeitemid
  INNER JOIN itemgroup ig on ig.Itemgroupid=stk.Itemgroupid 
  INNER JOIN Itemcategory ic on ic.itemcategoryid=ig.Itemcategoryid 
WHERE isnull(m.Raised,0)=0 AND m.tableid=@id and isnull(d.cANCELORNORM,'')<>'C'  
 and isnull(SplitBillRaised,0)=0 
 group by i.BarItemname 








 
ALTER PROCEDURE [dbo].[Get_BarReport]  
@Fromdate DATETIME,@Todate DATETIME,@Itemid BIGINT
AS  
BEGIN  
Select isnull(Si.Baropstock,0) as baropstock,Si.itemid, itemgroup.ORDBY ,Si.itemname,
si.mlperbottle,(isnull(oldsal.salqty,0)) Oldsales ,
(isnull(oldinward.qtybtl,0)) OldIssue, (isnull(oldadj.qty,0)) OldAdjustqty ,
(isnull(newsal.salQty,0)) NewsalesT, (isnull(newsalR1.salQty,0)) NewsalesR,
(isnull(newInward.qtybtl,0)) as Newissue, (isnull(newadj.newadjqty,0)) newAdjustqty,(isnull(newPhy.qty,0)) newPhysical,Itemgroup.Itemgroup, isnull(itemgroup.beeritems,0) beeritems, isnull(itemgroup.otheritems,0) otheritems,si.pegml
 from Stock_itemmmas Si 
                left outer join (Select Sum(oldsal.qty)salqty,oldkd.storeitemid from Trans_Barkot_mas oldmas, Trans_Barkot_det oldsal, Trans_Barkotdet_id oldkd where oldsal.kotid=oldmas.kotid and oldsal.kotdetid=oldkd.refkotdetid and kotdate < @Fromdate AND isnull(oldmas.Cancelornorm,'N')<>'C' group by oldkd.storeitemid) as oldsal on oldsal.storeitemid=si.itemid 
                 left outer join (Select Sum(oldinw.qty) as qtybtl,oldinw.itemid from Trans_Bar_inwardmas oldinwmas, Trans_Bar_inwarddet oldinw where oldinw.inwid=oldinwmas.inwid and convert(datetime,Entrydate,101) < @Fromdate and isnull(oldinwmas.restypeid,0)=0 group by itemid) as oldinward on oldinward.itemid=si.itemid 
                 left outer join (Select Sum(oldadjdet.qty * (convert(numeric,oldadjdet.Addorless + '1'))) as qty ,oldadjdet.itemid from Trans_Bar_StockAdjustmentmas oldadjmas,Trans_Bar_StockAdjustmentdet oldadjdet where oldadjdet.adjid=oldadjmas.adjid and oldadjmas.Baroorstore='B' and convert(date,Entrydate,101) < @Fromdate group by itemid) oldadj on  oldadj.itemid=si.itemid 
                 left outer join (Select Sum(newsal.qty)salqty, 
				 newkd.storeitemid from Trans_Barkot_mas newmas, Trans_Barkot_det newsal, 
				 Trans_Barkotdet_id newkd where newsal.kotid=newmas.kotid  and
				  newsal.kotdetid=newkd.refkotdetid and kotdate between 
				  @Fromdate and @Todate AND isnull(newmas.Cancelornorm,'N')<>'C' 
				  AND rOOMORTAB='T' group by newkd.storeitemid) as newsal 
				  on newsal.storeitemid=si.itemid 
                 left outer join (Select Sum(newsal.qty)salqty, newkd.storeitemid from Trans_Barkot_mas newmas, Trans_Barkot_det newsal, Trans_Barkotdet_id newkd where newsal.kotid=newmas.kotid and newsal.kotdetid=newkd.refkotdetid and kotdate between @Fromdate and @Todate AND isnull(newmas.Cancelornorm,'N')<>'C' AND rOOMORTAB='R' group by newkd.storeitemid) as newsalR1 on newsalR1.storeitemid=si.itemid 
                 left outer join (Select Sum(newadjdet.qty * (convert(numeric,newadjdet.Addorless + '1'))) as newadjqty, newadjdet.itemid from   Trans_Bar_StockAdjustmentmas newadjmas,Trans_Bar_StockAdjustmentdet newadjdet where newadjdet.adjid=newadjmas.adjid and newadjmas.Baroorstore='B' and convert(date,Entrydate,101) between @Fromdate and @Todate group by itemid) newadj on newadj.itemid=si.itemid 
                 left outer join (Select Sum(newinw.qty) as qtybtl,newinw.itemid from Trans_Bar_inwardmas newinwmas, Trans_Bar_inwarddet newinw where newinw.inwid=newinwmas.inwid and convert(date,Entrydate,101) between @Fromdate and @Todate and isnull(newinwmas.restypeid,0)=0 group by itemid) as newinward on newinward.itemid=si.itemid 
                left outer join (Select Sum(newphydet.qty) as qty ,newphydet.itemid from Trans_Bar_physicalmas newphymas, Trans_Bar_physicaldet newphydet   where newphydet.adjid=newphymas.adjid and convert(date,Entrydate,101) between @Fromdate and @Todate and newphymas.Baroorstore='B' group by itemid) newphy  on  newphy.itemid=si.itemid 
                 inner join Itemgroup on itemgroup.itemgroupid=si.itemgroupid WHERE isnull(ITEMGROUP.barorfood,0)=1 and isnull(ITEMGROUP.otheritems,0) <> 1 AND si.Itemid=@itemid order by Itemgroup.ordby,itemgroup,si.orderby,SI.ITEMNAME 
END







------ db changes elanza -----

USE [elanza]
GO
/****** Object:  Trigger [dbo].[Insert_Adjust_barraise]    Script Date: 23/02/2024 18:02:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[Insert_Adjust_barraise] ON [dbo].[Trans_Bar_StockAdjustmentdet]
FOR INSERT
AS
declare @itemid integer
declare @adjid integer
declare @qty numeric(12,2)
declare @addorless  varchar(2)
declare @storeorbar varchar(2),@billdetid bigint
declare @retqty numeric(12,2),@kotno as varchar(25),@cnt bigint
declare @enablebarcounterbasedkotbillinward bigint,@counterid bigint,@ml numeric(12,2)
declare barfirstins cursor for select itemid,qty,Adjid,addorless,billdetid,retqty,kotno from inserted ins
Open barfirstins
Fetch next from barfirstins into @itemid,@qty,@adjid,@addorless,@billdetid,@retqty,@kotno

While @@Fetch_Status=0
begin
      select @ml = (Select mlperbottle from Stock_itemmmas where Itemid=@itemid)
     select @enablebarcounterbasedkotbillinward = (Select isnull(enablebarcounterbasedkotbillinward,0) as enablebarcounterbasedkotbillinward from application_settings)
     Select @storeorbar=baroorstore,@counterid=counterid from trans_bar_stockadjustmentmas where adjid=@adjid
     if   @Storeorbar='B' 
      begin
             if @addorless='+'
 		     begin
	                     
	               if @billdetid >0 
	               begin
	                  if substring(@kotno,1,1)='K'
						  begin
						  update trans_barkotbillraise_det set brqty = isnull(brqty,0) + @retqty where billdetid=@billdetid
						  end
	                  else if substring(@kotno,1,1)='S'
						  begin
						  update trans_barkotbillraise1_det set brqty = isnull(brqty,0) + @retqty where billdetid=@billdetid
						  end
	               end
	               else
					   begin	
						   if @enablebarcounterbasedkotbillinward >0
						   begin		
							   select @cnt = (select count(*) ccnt from stock_itemmmas_counter where storeitemid = @itemid and counterid = @counterid)
							   if @cnt=0
							   begin
								 insert into stock_itemmmas_counter(storeitemid,barstockqty,BarAdjQty,counterid)values(@itemid,(isnull(@qty,0)*@ml),(isnull(@qty,0)*@ml),@counterid)
							   end
							   else
							   begin
								 Update stock_itemmmas_counter Set BarStockqty=isnull(BarStockqty,0) +(isnull(@qty,0)*@ml),BarAdjQty =ISNULL(BarAdjQty,0)  + (isnull(@qty,0)*@ml) where storeitemid=@itemid and counterid=@counterid
							   end
						   end
					      Update Stock_itemmmas Set BarStockqty= ISNULL(BarStockqty,0) + (isnull(@qty,0)*@ml),BarAdjQty =ISNULL(BarAdjQty,0)  + (isnull(@qty,0)*@ml)  where itemid=@itemid
					   end
		     end
	        if @addorless='-'
 		     begin
 		     
 		     		      if @enablebarcounterbasedkotbillinward >0
						   begin							
							  Update stock_itemmmas_counter Set BarStockqty=isnull(BarStockqty,0) - (isnull(@qty,0)*@ml),BarAdjQty =ISNULL(BarAdjQty,0)  - (isnull(@qty,0)*@ml) where storeitemid=@itemid and counterid=@counterid							   
						   end
	                       Update Stock_itemmmas Set BarStockqty= ISNULL(BarStockqty,0) - (isnull(@qty,0)*@ml),BarAdjQty =ISNULL(BarAdjQty,0)  - (isnull(@qty,0)*@ml)  where itemid=@itemid

		     end
    end
         if   @Storeorbar='S' 
      begin
                     if @addorless='+'
 		     begin
	                     Update Stock_itemmmas Set StoreStockqty= ISNULL(StoreStockqty,0) + (isnull(@qty,0)*@ml),StoreAdjQty =ISNULL(StoreAdjQty,0)  + (isnull(@qty,0)*@ml)  where itemid=@itemid
		     end
	        if @addorless='-'
 		     begin
	                       Update Stock_itemmmas Set StoreStockqty= ISNULL(StoreStockqty,0) - (isnull(@qty,0)*@ml),StoreAdjQty =ISNULL(StoreAdjQty,0) - (isnull(@qty,0)*@ml)  where itemid=@itemid

		     end
    end
    

Fetch next from barfirstins into @itemid,@qty,@adjid,@addorless,@billdetid,@retqty,@kotno
end
Close barfirstins
Deallocate barfirstins


USE elanza
GO
/****** Object:  Trigger [dbo].[Delete_Adjust_barraise]    Script Date: 23/02/2024 18:02:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[Delete_Adjust_barraise] ON [dbo].[Trans_Bar_StockAdjustmentdet]
FOR Delete
AS
declare @itemid integer
declare @adjid integer
declare @qty numeric(12,2)
declare @addorless  varchar(2)
declare @storeorbar varchar(2),@billdetid bigint
declare @retqty numeric(12,2),@kotno as varchar(25),@cnt bigint
declare @enablebarcounterbasedkotbillinward bigint,@counterid bigint

declare barfirstadj cursor for select itemid,qty,Adjid,addorless,billdetid,retqty,kotno  from Deleted ins
Open barfirstadj
Fetch next from barfirstadj into @itemid,@qty,@adjid,@addorless,@billdetid,@retqty,@kotno

While @@Fetch_Status=0
begin
     select @enablebarcounterbasedkotbillinward = (Select isnull(enablebarcounterbasedkotbillinward,0) as enablebarcounterbasedkotbillinward from application_settings)
     Select @storeorbar=baroorstore,@counterid=counterid from trans_bar_stockadjustmentmas where adjid=@adjid
     if   @Storeorbar='B' 
      begin
             if @addorless='+'
 		     begin
	               
	               if @billdetid >0 
	               begin
	                  if substring(@kotno,1,1)='K'
						  begin
						  update trans_barkotbillraise_det set brqty = isnull(brqty,0) - @retqty where billdetid=@billdetid
						  end
	                  else if substring(@kotno,1,1)='S'
						  begin
						  update trans_barkotbillraise1_det set brqty = isnull(brqty,0) - @retqty where billdetid=@billdetid
						  end
	               end
	               else
	               begin
						  if @enablebarcounterbasedkotbillinward > 0
						  begin
							 Update Stock_itemmmas_counter Set BarStockqty= ISNULL(BarStockqty,0) - isnull(@qty,0),BarAdjQty =ISNULL(BarAdjQty,0)  - isnull(@qty,0)  where storeitemid=@itemid and counterid  =@counterid
						  end
						  Update Stock_itemmmas Set BarStockqty= ISNULL(BarStockqty,0) - isnull(@qty,0),BarAdjQty =ISNULL(BarAdjQty,0)  - isnull(@qty,0)  where itemid=@itemid
	               end
		     end
	        if @addorless='-'
 		     begin
 		              if @enablebarcounterbasedkotbillinward > 0
	                  begin
	                     Update Stock_itemmmas_counter Set BarStockqty= ISNULL(BarStockqty,0)  + isnull(@qty,0),BarAdjQty =ISNULL(BarAdjQty,0) + isnull(@qty,0)  where storeitemid=@itemid and counterid =@counterid
	                  end
	                  Update Stock_itemmmas Set BarStockqty= ISNULL(BarStockqty,0)  + isnull(@qty,0),BarAdjQty =ISNULL(BarAdjQty,0) + isnull(@qty,0)  where itemid=@itemid

		     end
    end
         if   @Storeorbar='S' 
      begin
                     if @addorless='+'
 		     begin
	                     Update Stock_itemmmas Set StoreStockqty= ISNULL(StoreStockqty,0) - isnull(@qty,0),StoreAdjQty =ISNULL(StoreAdjQty,0)  - isnull(@qty,0)  where itemid=@itemid
		     end
	        if @addorless='-'
 		     begin
	                       Update Stock_itemmmas Set StoreStockqty= ISNULL(StoreStockqty,0) + isnull(@qty,0),StoreAdjQty =ISNULL(StoreAdjQty,0) + isnull(@qty,0)  where itemid=@itemid

		     end
    end
    

Fetch next from barfirstadj into @itemid,@qty,@adjid,@addorless,@billdetid,@retqty,@kotno
end
Close barfirstadj
Deallocate barfirstadj




USE elanza
GO
/****** Object:  Trigger [dbo].[Del_KOTBAR_barraise]    Script Date: 23/02/2024 18:04:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[Del_KOTBAR_barraise] ON [dbo].[Trans_BarKotdet_id]
FOR delete
AS
declare @Refbarid integer
declare @storeitemid integer
declare @num float
declare @qty integer,@tmpiscocktail as varchar(25),@counterid bigint,@kotid bigint,@ml numeric(12,2)

declare barfirstkotupd cursor for select Refkotdetid,storeitemid,qty from deleted ins
Open barfirstkotupd
Fetch next from barfirstkotupd into @Refbarid,@storeitemid,@qty
While @@Fetch_Status=0
begin

    set @num = (select qty from Trans_barkot_det where kotdetid=@Refbarid)
    select @kotid = (select kotid from trans_barkot_det where kotdetid = @refbarid)
    select @counterid = (Select isnull(counterid,0) as counterid from trans_barkot_mas where kotid=@kotid)   
       select @ml = (Select mlperbottle from Stock_itemmmas where Itemid=@storeitemid)
    set @tmpiscocktail = (select iscocktail from Trans_barkot_det where kotdetid=@Refbarid)
    
    if @tmpiscocktail <> 'D'
    begin
       if @counterid > 0
       begin
         --Update Stock_itemmmas_counter Set Barstockqty=Barstockqty +(@num* @qty ),barsalqty=barsalqty - (@num* @qty)  where storeitemid=@storeitemid and counterid = @counterid
		 Update Stock_itemmmas_counter Set Barstockqty=Barstockqty +(@ml* @qty ),barsalqty=barsalqty - (@ml* @qty)  where storeitemid=@storeitemid and counterid = @counterid
       end
       --Update Stock_itemmmas Set Barstockqty=Barstockqty +(@num* @qty ),barsalqty=barsalqty - (@num* @qty)  where itemid=@storeitemid
	    Update Stock_itemmmas Set Barstockqty=Barstockqty +(@ml* @qty ),barsalqty=barsalqty - (@ml* @qty)  where itemid=@storeitemid
    end

    Fetch next from barfirstkotupd into @Refbarid,@storeitemid,@qty
end

Close barfirstkotupd
Deallocate barfirstkotupd




USE elanza
GO
/****** Object:  Trigger [dbo].[Insert_KOTBAR_barraise]    Script Date: 23/02/2024 18:05:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[Insert_KOTBAR_barraise] ON [dbo].[Trans_BarKotdet_id]
FOR INSERT
AS
declare @Refbarid integer
declare @storeitemid integer
declare @num float
declare @qty integer,@tmpiscocktail as varchar(25),@counterid bigint,@kotid bigint,@ml numeric(12,2)

declare barfirstkotins cursor for select Refkotdetid,storeitemid,qty from inserted ins
Open barfirstkotins
Fetch next from barfirstkotins into @Refbarid,@storeitemid,@qty
While @@Fetch_Status=0
begin

    set @num = (select qty from Trans_barkot_det where kotdetid=@Refbarid)
    set @tmpiscocktail = (select iscocktail from Trans_barkot_det where kotdetid=@Refbarid)
    select @kotid = (select kotid from trans_barkot_det where kotdetid = @refbarid)
    select @counterid = (Select isnull(counterid,0) as counterid from trans_barkot_mas where kotid=@kotid)
   select @ml = (Select mlperbottle from Stock_itemmmas where Itemid=@storeitemid)
    if @tmpiscocktail <> 'D'
    begin
        if @counterid > 0
        begin
          -- Update Stock_itemmmas_counter Set Barstockqty=ISNULL(Barstockqty,0) -(@num* @qty ),barsalqty=ISNULL(barsalqty,0) + (@num* @qty)  where storeitemid=@storeitemid and ISNULL(Barstockqty,0)>0 and counterid =@counterid
		   Update Stock_itemmmas_counter Set Barstockqty=ISNULL(Barstockqty,0) -(@ml* @qty ),barsalqty=ISNULL(barsalqty,0) + (@ml* @qty)  where storeitemid=@storeitemid and ISNULL(Barstockqty,0)>0 and counterid =@counterid
        end
        --Update Stock_itemmmas Set Barstockqty=ISNULL(Barstockqty,0) -(@num* @qty ),barsalqty=ISNULL(barsalqty,0) + (@num* @qty)  where itemid=@storeitemid and ISNULL(Barstockqty,0)>0
		Update Stock_itemmmas Set Barstockqty=ISNULL(Barstockqty,0) -(@ml* @qty ),barsalqty=ISNULL(barsalqty,0) + (@ml* @qty)  where itemid=@storeitemid and ISNULL(Barstockqty,0)>0
    end

    Fetch next from barfirstkotins into @Refbarid,@storeitemid,@qty
end

Close barfirstkotins
Deallocate barfirstkotins






ALTER PROCEDURE [dbo].[Exec_Stockmas]
-- @Storeopstock BIGINT,
 @Openingdate datetime,
 --@stock BIGINT,
 --@Itemcode BIGINT,
 @opening BIGINT,
 @Type varchar(10)
 --@SType VARCHAR(100)  
 AS  
 BEGIN
 IF @Type = 'SAVE'
	BEGIN
	  INSERT INTO Trans_BarStoreopening_mas (Openingdate,Draftmode)
      VALUES (@Openingdate,@opening)
	 SELECT 'Successfully Saved' AS MGS
END
END


USE elanza
GO
/****** Object:  StoredProcedure [dbo].[kot__save__one]    Script Date: 23/02/2024 18:30:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[kot__save__one]
@tableid bigint,@counter bigint, @sessionid bigint, @tokenno bigint,@noofpax bigint,@Employee varchar(100)
As

declare @maskotcoout bigint=0
declare @qty bigint ,@part varchar(100),@itemid bigint ,@tqty bigint,@trat numeric(12,2),
@tamt numeric(12,2), @bool bigint=0,
@iscoktail varchar(2),@storeitemid bigint,@kotid bigint,@splinstruction varchar(1000),@kitmsg varchar(1000),
@nccoversion varchar(1000),
@Tamt1 numeric(12,2), @sum11 numeric(12,2)=0,@ncreson varchar(1000),@Employeeid bigint,@billid bigint


set @maskotcoout= (select count(*) from trans_barkot_mas)


declare kotitemsfetch170719 cursor for 

SELECT DISTINCT bid.qty ,tk2.part,tk2.Itemid,Tqty,tk2.TRat,Tamt,iscocktail,
tk2.storeitemid,Kot_Id,Splinstruction,KITMSG,tk2.NCconversionreson
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Stock_Itemmmas s on s.Itemid=tk2.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid
					--and isnull(tk2.Approved,0) =0
					 and  iscocktail <>'D'

open kotitemsfetch170719
set @maskotcoout= (select count(*) from trans_barkot_mas) 
set @billid= (select ident_current('Trans_BARKot_mas'))
		if(@billid > 1 and @maskotcoout >0)
		BEGIN
			set @billid = @billid+1						
		END       

    FETCH NEXT FROM kotitemsfetch170719 INTO  @qty,@part,@itemid,@tqty,@trat,@tamt,@iscoktail,@storeitemid,@kotid,@splinstruction,@kitmsg,@nccoversion
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool = 1
				INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,storeitemid,qty1,added,tkotid,Splinstruction,KITCHENMSG)values(@part,@billid,@itemid,@tqty,@trat,@tamt,@tableid,@iscoktail,@storeitemid,@tqty,0,@kotid,@splinstruction,@kitmsg)
				INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,@tqty,ident_current('Trans_BARKot_det '))
				set	@Tamt1=@tamt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
                    
                FETCH NEXT FROM kotitemsfetch170719 INTO @qty,@part,@itemid,@tqty,@trat,@tamt,@iscoktail,@storeitemid,@kotid,@splinstruction,@kitmsg,@nccoversion
                END
                CLOSE kotitemsfetch170719
                DEALLOCATE kotitemsfetch170719




declare @baritemname varchar(500),@pax bigint, @sbarstockqty bigint,@icecreamorfood bigint,@otheritems bigint,@bool1 bigint
set @bool = 0

declare kotitemsfetch170720 cursor for 

SELECT DISTINCT btm.BarItemname,tk2.NCconversionreson,Splinstruction,KITMSG,tk2.Noofpax,iscocktail,tk2.TRat,
Kot_Id,Tqty,tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					INNER JOIN Stock_Itemmmas s on s.Itemid=bid.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 				
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid
					and tk2.Approved ='1' 
					and iscocktail ='D'
					--and iscocktail ='Y'
					group by tk2.Itemid,btm.BarItemname,tk2.Noofpax,iscocktail,tk2.NCconversionreson,tk2.TRat,Kot_Id,Tqty,TableId,tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt,Tqty,Splinstruction,KITMSG

open kotitemsfetch170720        

set @maskotcoout= (select count(*) from trans_barkot_mas)
set @billid= (select ident_current('Trans_BARKot_mas'))
		if(@billid >1 and @maskotcoout >0)
		BEGIN
			set @billid = @billid+1						
		END
    FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg,@pax,
	@iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool = 1
				
					INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,qty1,added,
					tkotid,Splinstruction,KITCHENMSG)values
					(@part,@billid,@itemid,@tqty,@trat,@tamt,@tableid,@iscoktail,@tqty,0,@kotid,@splinstruction,@kitmsg ) 
					INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,@tqty,ident_current('Trans_BARKot_det '))

				
				set	@Tamt1=@tamt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
                    
                FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg,@pax,
	            @iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt
                END
                CLOSE kotitemsfetch170720
                DEALLOCATE kotitemsfetch170720

		
				
				
					
					
					
set @Employeeid = (select Employeeid from employee WHERE Employee=@Employee)
				

				
				
  INSERT INTO dbo.Trans_BARKot_mas(Refno,Raised,counterid,noofpax,part,tableid,Stwid,Kotno,Kotdate, 
  Kottime, totalamount, rOOMORTAB,Userid,sessionid,tokenno,NCconversionreson) 
  VALUES ('','0',@counter,@noofpax,@part,@tableid,@Employeeid,
  dbo.RotNo(),convert(VARCHAR,getdate(),101), convert(VARCHAR,getdate(),108), @sum11,'T',1,@sessionid,
 @tokenno,@ncreson) 





USE elanza
GO
/****** Object:  StoredProcedure [dbo].[kot__save__two]    Script Date: 23/02/2024 18:31:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[kot__save__two]
@tableid bigint,@counter bigint, @sessionid bigint, @tokenno bigint,@refdate datetime,@reftime datetime,@noofpax bigint,@Stwid bigint
As

declare @qty bigint ,@part varchar(100),@itemid bigint ,@tqty bigint,@trat numeric(12,2),@tamt numeric(12,2), @bool bigint=0,
@iscoktail varchar(2),@storeitemid bigint,@kotid bigint,@splinstruction varchar(1000),@kitmsg varchar(1000),
@nccoversion varchar(1000),
@Tamt1 numeric(12,2), @sum11 numeric(12,2),@ncreson varchar(1000),@Employeeid bigint,@billid bigint, @baritemname varchar(500),
@pax bigint, @sbarstockqty bigint,@icecreamorfood bigint,@otheritems bigint,@bool1 bigint,@nckotaccounttype bigint,@nctype varchar(100),
@itemname  varchar(100),@nc bigint, @nctypeid bigint, @ncaccid bigint,@amt numeric(12,2),@rate numeric(12,2)
set @sum11=0
set @sum11=0
set @amt=0

  INSERT INTO dbo.Trans_BARKot_mas(Refno,Raised,counterid,noofpax,part,tableid,Stwid,Kotno,Kotdate,  Kottime, totalamount, rOOMORTAB,Userid,sessionid,tokenno,NCconversionreson,refkotdate,refkottime) 
  VALUES ('','0',@counter,@noofpax,@part,@tableid,@Stwid,  dbo.RotNo(),@refdate,@reftime, @sum11,'T',1,@sessionid, @tokenno,@ncreson,convert(VARCHAR,getdate(),101), convert(VARCHAR,getdate(),108)) 
 set @billid=(Select SCOPE_IDENTITY())

declare kotitemsfetch170719 cursor for 
SELECT DISTINCT btm.BarItemname,tk2.NCconversionreson,isnull(tk2.nckotaccounttype,0) as nckotaccounttype ,nctype,
					Splinstruction,KITMSG,tk2.Noofpax,tk2.storeitemid,iscocktail,tk2.TRat,Kot_Id,Tqty,tk2.Itemid,
					s.Itemname,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Stock_Itemmmas s on s.Itemid=tk2.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid
					and tk2.Approved ='1'
set @bool1=0
open kotitemsfetch170719 
     

   FETCH NEXT FROM kotitemsfetch170719 INTO  @baritemname,@nccoversion,@nckotaccounttype,@nctype,@splinstruction,@kitmsg,
 @pax,@storeitemid,@iscoktail,@trat,@kotid,@tqty,@itemid,@itemname,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool1 = 1
				IF(@nckotaccounttype=0)
					BEGIN
						set @nc=0
						set @nctypeid=0
						set @rate = @trat
						set @amt=@tamt
						set @ncaccid=0
					END
				ELSE
				    BEGIN
						set @nc=1
						set @nctypeid=@nctype
						set @rate = 0.00
						set @amt=0.00
						set @ncaccid=@nckotaccounttype
					END
		
				
				INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,storeitemid,qty1,added,tkotid,Splinstruction,KITCHENMSG,nckot,nctypeid,ncaccid)
				values(@part,@billid,@itemid,@tqty,@rate,@amt,@tableid,@iscoktail,@storeitemid,@tqty,0,@kotid,@splinstruction,@kitmsg,@nc,@nctypeid,@ncaccid)
				INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,@tqty,ident_current('Trans_BARKot_det '))
				set	@Tamt1=@amt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
					
                    
               FETCH NEXT FROM kotitemsfetch170719 INTO  @baritemname,@nccoversion,@nckotaccounttype,@nctype,@splinstruction,@kitmsg,
 @pax,@storeitemid,@iscoktail,@trat,@kotid,@tqty,@itemid,@itemname,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt
                END
                CLOSE kotitemsfetch170719
                DEALLOCATE kotitemsfetch170719



declare kotitemsfetch170720 cursor for 


SELECT DISTINCT btm.BarItemname,tk2.NCconversionreson,Splinstruction,KITMSG,tk2.Noofpax,iscocktail,tk2.TRat,Kot_Id,Tqty,
tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					INNER JOIN Stock_Itemmmas s on s.Itemid=bid.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 				
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid
					and tk2.Approved ='1' and iscocktail ='Y'
					group by tk2.Itemid,btm.BarItemname,tk2.NCconversionreson,tk2.Noofpax,iscocktail,tk2.TRat,Kot_Id,Tqty,TableId,tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt,Tqty,Splinstruction,KITMSG
open kotitemsfetch170720        


    FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg, @pax,
@iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool1 = 1
				IF(@nckotaccounttype=0)
					BEGIN
						set @rate = @trat
						set @amt=@tamt
						
					END
				ELSE
				    BEGIN
					
						set @rate = 0.00
						set @amt=0.00
						
					END
				    INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,storeitemid,qty1,added,tkotid,Splinstruction,KITCHENMSG,nckot,nctypeid,ncaccid)
				values(@part,@billid,@itemid,@tqty,@rate,@amt,@tableid,@iscoktail,@storeitemid,@tqty,0,@kotid,@splinstruction,@kitmsg,@nc,@nctypeid,@ncaccid)
					INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,@tqty,ident_current('Trans_BARKot_det '))

				
				set	@Tamt1=@amt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
                    
                FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg, @pax,
                @iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt
                END
                CLOSE kotitemsfetch170720
                DEALLOCATE kotitemsfetch170720

				if(@bool1=1)
				BEGIN
					select @Employeeid = Employeeid from employee WHERE istabsteward='1'
				END

					
--UPdate Mas
  UPdate dbo.Trans_BARKot_mas set part=@part, totalamount=@sum11,nckot=@nc,nctypeid=@nctypeid where Kotid=@billid

 update Tablemas set Status='K' where Tableid=@tableid
 --Delete from temp_kot2 where Tableid=@tableid
 select @billid as ID




 alter table trans_barkot_det add  itemprepare bigint







 USE elanza
GO
/****** Object:  StoredProcedure [dbo].[kot__save__one]    Script Date: 23/02/2024 19:18:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[kot__save__one]
@tableid bigint,@counter bigint, @sessionid bigint, @tokenno bigint,@noofpax bigint,@Employee varchar(100)
As

declare @maskotcoout bigint=0
declare @qty bigint ,@part varchar(100),@itemid bigint ,@tqty bigint,@trat numeric(12,2),
@tamt numeric(12,2), @bool bigint=0,
@iscoktail varchar(2),@storeitemid bigint,@kotid bigint,@splinstruction varchar(1000),@kitmsg varchar(1000),
@nccoversion varchar(1000),
@Tamt1 numeric(12,2), @sum11 numeric(12,2)=0,@ncreson varchar(1000),@Employeeid bigint,@billid bigint


set @maskotcoout= (select count(*) from trans_barkot_mas)


declare kotitemsfetch170719 cursor for 

SELECT DISTINCT bid.qty ,tk2.part,tk2.Itemid,Tqty,tk2.TRat,Tamt,iscocktail,
tk2.storeitemid,Kot_Id,Splinstruction,KITMSG,tk2.NCconversionreson
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Stock_Itemmmas s on s.Itemid=tk2.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid
					--and isnull(tk2.Approved,0) =0
					 and  iscocktail <>'D'

open kotitemsfetch170719
set @maskotcoout= (select count(*) from trans_barkot_mas) 
set @billid= (select ident_current('Trans_BARKot_mas'))
		if(@billid > 1 and @maskotcoout >0)
		BEGIN
			set @billid = @billid+1						
		END       

    FETCH NEXT FROM kotitemsfetch170719 INTO  @qty,@part,@itemid,@tqty,@trat,@tamt,@iscoktail,@storeitemid,@kotid,@splinstruction,@kitmsg,@nccoversion
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool = 1
				INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,storeitemid,qty1,added,tkotid,Splinstruction,KITCHENMSG)values(@part,@billid,@itemid,@tqty,@trat,@tamt,@tableid,@iscoktail,@storeitemid,@tqty,0,@kotid,@splinstruction,@kitmsg)
				INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,@tqty,ident_current('Trans_BARKot_det '))
				set	@Tamt1=@tamt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
                    
                FETCH NEXT FROM kotitemsfetch170719 INTO @qty,@part,@itemid,@tqty,@trat,@tamt,@iscoktail,@storeitemid,@kotid,@splinstruction,@kitmsg,@nccoversion
                END
                CLOSE kotitemsfetch170719
                DEALLOCATE kotitemsfetch170719




declare @baritemname varchar(500),@pax bigint, @sbarstockqty bigint,@icecreamorfood bigint,@otheritems bigint,@bool1 bigint
set @bool = 0

declare kotitemsfetch170720 cursor for 

SELECT DISTINCT btm.BarItemname,tk2.NCconversionreson,Splinstruction,KITMSG,tk2.Noofpax,iscocktail,tk2.TRat,
Kot_Id,Tqty,tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					INNER JOIN Stock_Itemmmas s on s.Itemid=bid.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 				
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid
					and tk2.Approved ='1' 
					and iscocktail ='D'
					--and iscocktail ='Y'
					group by tk2.Itemid,btm.BarItemname,tk2.Noofpax,iscocktail,tk2.NCconversionreson,tk2.TRat,Kot_Id,Tqty,TableId,tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt,Tqty,Splinstruction,KITMSG

open kotitemsfetch170720        

set @maskotcoout= (select count(*) from trans_barkot_mas)
set @billid= (select ident_current('Trans_BARKot_mas'))
		if(@billid >1 and @maskotcoout >0)
		BEGIN
			set @billid = @billid+1						
		END
    FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg,@pax,
	@iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool = 1
				
					INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,qty1,added,
					tkotid,Splinstruction,KITCHENMSG,storeitemid)values
					(@part,@billid,@itemid,@tqty,@trat,@tamt,@tableid,@iscoktail,@tqty,0,@kotid,@splinstruction,@kitmsg,@storeitemid ) 
					INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,@tqty,ident_current('Trans_BARKot_det '))

				
				set	@Tamt1=@tamt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
                    
                FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg,@pax,
	            @iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt
                END
                CLOSE kotitemsfetch170720
                DEALLOCATE kotitemsfetch170720

		
				
				
					
					
					
set @Employeeid = (select Employeeid from employee WHERE Employee=@Employee)
				

				
				
  INSERT INTO dbo.Trans_BARKot_mas(Refno,Raised,counterid,noofpax,part,tableid,Stwid,Kotno,Kotdate, 
  Kottime, totalamount, rOOMORTAB,Userid,sessionid,tokenno,NCconversionreson) 
  VALUES ('','0',@counter,@noofpax,@part,@tableid,@Employeeid,
  dbo.RotNo(),convert(VARCHAR,getdate(),101), convert(VARCHAR,getdate(),108), @sum11,'T',1,@sessionid,
 @tokenno,@ncreson) 









USE [diamond]
GO
/****** Object:  Trigger [dbo].[Delete_Stock_barraise]    Script Date: 24/02/2024 09:43:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
ALTER TRIGGER [dbo].[Delete_Stock_barraise] ON [dbo].[Trans_Bar_purchaseDet]
FOR DELETE
AS
declare @itemid integer
declare @purqty numeric(12,2)
declare @spurqty numeric(12,2)
declare @ml numeric(12,2)
declare c1 cursor for select itemid,purqty,spurqty from deleted ins
Open c1
Fetch next from c1 into @itemid,@purqty,@spurqty
While @@Fetch_Status=0
begin
set @ml = (select mlperbottle from Stock_itemmmas where itemid=@itemid)
 Update Stock_itemmmas Set Storepurqty=isnull(Storepurqty,0) - (@Purqty*@ml),StoreStockqty=isnull(storeStockqty,0) -(@Purqty*@ml) where itemid=@itemid and isnull(storestockqty,0) > 0
 Update Stock_itemmmas set SStorepurqty=isnull(SStorepurqty,0) - (@sPurqty*@ml),SStoreStockqty=isnull(SstoreStockqty,0) -(@sPurqty*@ml)  where itemid=@itemid --and itemgroupid<>8
 
 -- Update Stock_itemmmas Set Storepurqty=Storepurqty - @Purqty,StoreStockqty=storeStockqty -@Purqty ,SStorepurqty=SStorepurqty - @sPurqty,SStoreStockqty=SstoreStockqty -@sPurqty  where itemid=@itemid
  Fetch next from c1 into @itemid,@purqty,@spurqty
end

Close c1
Deallocate c1










USE [diamond]
GO
/****** Object:  Trigger [dbo].[Insert_Stock_barraise]    Script Date: 24/02/2024 09:43:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
ALTER TRIGGER [dbo].[Insert_Stock_barraise] ON [dbo].[Trans_Bar_purchaseDet]
FOR INSERT
AS
declare @itemid integer
declare @purqty numeric(12,2)
declare @spurqty numeric(12,2)
declare @ml numeric(12,2)
declare c1 cursor for select itemid,purqty,spurqty from inserted ins
Open c1
Fetch next from c1 into @itemid,@purqty,@spurqty
While @@Fetch_Status=0
begin

set @ml = (select mlperbottle from Stock_itemmmas where itemid=@itemid)

  Update Stock_itemmmas Set Storepurqty=isnull(Storepurqty,0) + (@Purqty*@ml) ,StoreStockqty=isnull(storeStockqty,0) + (@Purqty*@ml) where itemid=@itemid
  Update stock_itemmmas Set SStorepurqty=isnull(SStorepurqty,0) + (@sPurqty*@ml),SStoreStockqty=isnull(SstoreStockqty,0) + (@sPurqty*@ml)  where itemid=@itemid --and itemgroupid<>8

 -- Update Stock_itemmmas Set Storepurqty=Storepurqty + @Purqty,StoreStockqty=storeStockqty + @Purqty,SStorepurqty=SStorepurqty + @sPurqty,SStoreStockqty=SstoreStockqty + @sPurqty  where itemid=@itemid
  Fetch next from c1 into @itemid,@purqty,@spurqty
end

Close c1
Deallocate c1





USE [diamond]
GO
/****** Object:  Trigger [dbo].[DELETE_BarStock_Inward]    Script Date: 24/02/2024 09:44:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[DELETE_BarStock_Inward] ON [dbo].[Trans_Bar_Inwarddet]
FOR DELETE
AS
declare @itemid integer
declare @Qty numeric(12,2)
declare @qtybtl numeric(12,2),@barinwid bigint,@cnt bigint,@counterid bigint
declare @enablebarcounterbasedkotbillinward bigint
declare barinwl cursor for select qty ,itemid,qtybtl,inwid  from Deleted  ins
Open barinwl
Fetch next from barinwl into @Qty,@itemid,@qtybtl,@barinwid
While @@Fetch_Status=0
begin

   select @enablebarcounterbasedkotbillinward = (Select isnull(enablebarcounterbasedkotbillinward,0) as enablebarcounterbasedkotbillinward from application_settings)
   
   if @enablebarcounterbasedkotbillinward >0
   begin
	   select @counterid = (select counterid from trans_bar_inwardmas where inwid = @barinwid)
	   select @cnt = (select count(*) ccnt from stock_itemmmas_counter where storeitemid = @itemid and counterid = @counterid)
	   if @cnt>0
	   begin
		 Update stock_itemmmas_counter Set BarStockqty=isnull(BarStockqty,0) - @qty where storeitemid=@itemid and counterid=@counterid
	   end
   end

   Update Stock_itemmmas Set BarStockqty=isnull(BarStockqty,0) -@qty where itemid=@itemid
   Update Stock_itemmmas Set  StoreStockqty = isnull(StoreStockqty,0)  + @qty  where itemid=@itemid
Fetch next from barinwl into @Qty,@itemid,@qtybtl,@barinwid
end

Close barinwl
Deallocate barinwl





USE [diamond]
GO
/****** Object:  Trigger [dbo].[Insert_BarStock_Inward]    Script Date: 24/02/2024 09:44:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[Insert_BarStock_Inward] ON [dbo].[Trans_Bar_Inwarddet]
FOR INSERT
AS
declare @itemid integer
declare @Qty  NUMERIC(14,3)
declare @Qtybtl NUMERIC(14,3),@counterid bigint,@barinwid bigint,@cnt bigint
declare @enablebarcounterbasedkotbillinward bigint,@restypeid bigint
declare barinw cursor for select qty ,itemid,qtybtl,inwid from inserted ins
Open barinw
Fetch next from barinw into @Qty,@itemid,@qtybtl,@barinwid
While @@Fetch_Status=0
begin
   
   select @enablebarcounterbasedkotbillinward = (Select isnull(enablebarcounterbasedkotbillinward,0) as enablebarcounterbasedkotbillinward from application_settings)
   
   if @enablebarcounterbasedkotbillinward >0
   begin
	   select @counterid = (select counterid from trans_bar_inwardmas where inwid = @barinwid)
	   select @restypeid = (select restypeid from trans_bar_inwardmas where inwid = @barinwid)
	   select @cnt = (select count(*) ccnt from stock_itemmmas_counter where 
	   storeitemid = @itemid and counterid = @counterid)
	   if @cnt=0
	   begin
	     if @counterid >0
	     begin
		   insert into stock_itemmmas_counter(storeitemid,barstockqty,counterid)values(@itemid,@qty,@counterid)
		 end
	   end
	   else
	   begin
	     if @counterid > 0
	     begin
		    Update stock_itemmmas_counter Set BarStockqty=isnull(BarStockqty,0) +@qty where storeitemid=@itemid and counterid=@counterid
		 end
	   end
   end
   if @restypeid >0
   begin   
     Update Stock_itemmmas Set
	  StoreStockqty = isnull(StoreStockqty,0)  - @qty where itemid=@itemid
   end
   else
   begin
      Update Stock_itemmmas Set BarStockqty=isnull(BarStockqty,0) +@qty ,
	  StoreStockqty = isnull(StoreStockqty,0)  - @qty,
	  -- barissueqty=isnull(StoreStockqty,0)  - @qtybtl
	  barissueqty=@qty
	   where itemid=@itemid
   end

Fetch next from barinw into @Qty,@itemid,@qtybtl,@barinwid
end

Close barinw
Deallocate barinw




---------  changes 24.02.2024 ------------------------
create Procedure [dbo].[Get_StoreItemMaster1] @ID BIGINT=0 as BEGIN 
Select Itemgroup, ig.Itemcode,ig.Itemname,ig.Rate,ig.bottpercase,ig.mlperbottle,
ig.Itemgroupid,ig.sTKRATE,ig.salrate,ig.addedval,ig.addedper,ig.orderby,ig.pegml,ig.Taxsetupid,ig.Itemid,ig.inactive from Stock_itemmmas ig
inner join  itemgroup ic on ic.Itemgroupid=ig.Itemgroupid
WHERE Itemid  =(CASE WHEN @ID=0 THEN Itemid ELSE @ID END ) and isnull(ic.icecreamorfood,0)<>1 order by Itemid asc END





----- changes 26.02.2024



USE [elanza]
GO
/****** Object:  Trigger [dbo].[Del_KOTBAR_barraise]    Script Date: 26/02/2024 13:42:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[Del_KOTBAR_barraise] ON [dbo].[Trans_BarKotdet_id]
FOR delete
AS
declare @Refbarid integer
declare @storeitemid integer
declare @num float
declare @qty integer,@tmpiscocktail as varchar(25),@counterid bigint,@kotid bigint,@ml numeric(12,2)

declare barfirstkotupd cursor for select Refkotdetid,storeitemid,qty from deleted ins
Open barfirstkotupd
Fetch next from barfirstkotupd into @Refbarid,@storeitemid,@qty
While @@Fetch_Status=0
begin

    set @num = (select qty from Trans_barkot_det where kotdetid=@Refbarid)
    select @kotid = (select kotid from trans_barkot_det where kotdetid = @refbarid)
    select @counterid = (Select isnull(counterid,0) as counterid from trans_barkot_mas where kotid=@kotid)   
       select @ml = (Select mlperbottle from Stock_itemmmas where Itemid=@storeitemid)
    set @tmpiscocktail = (select iscocktail from Trans_barkot_det where kotdetid=@Refbarid)
    
    if @tmpiscocktail <> 'D'
    begin
       if @counterid > 0
       begin
         Update Stock_itemmmas_counter Set Barstockqty=Barstockqty +(@num* @qty ),barsalqty=barsalqty - (@num* @qty)  where storeitemid=@storeitemid and counterid = @counterid
		-- Update Stock_itemmmas_counter Set Barstockqty=Barstockqty +(@ml* @qty ),barsalqty=barsalqty - (@ml* @qty)  where storeitemid=@storeitemid and counterid = @counterid
       end
       Update Stock_itemmmas Set Barstockqty=Barstockqty +(@num* @qty ),barsalqty=barsalqty - (@num* @qty)  where itemid=@storeitemid
	    --Update Stock_itemmmas Set Barstockqty=Barstockqty +(@ml* @qty ),barsalqty=barsalqty - (@ml* @qty)  where itemid=@storeitemid
    end

    Fetch next from barfirstkotupd into @Refbarid,@storeitemid,@qty
end

Close barfirstkotupd
Deallocate barfirstkotupd


USE [elanza]
GO
/****** Object:  Trigger [dbo].[Insert_KOTBAR_barraise]    Script Date: 26/02/2024 13:37:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[Insert_KOTBAR_barraise] ON [dbo].[Trans_BarKotdet_id]
FOR INSERT
AS
declare @Refbarid integer
declare @storeitemid integer
declare @num float
declare @qty integer,@tmpiscocktail as varchar(25),@counterid bigint,@kotid bigint,@ml numeric(12,2)

declare barfirstkotins cursor for select Refkotdetid,storeitemid,qty from inserted ins
Open barfirstkotins
Fetch next from barfirstkotins into @Refbarid,@storeitemid,@qty
While @@Fetch_Status=0
begin

    set @num = (select qty from Trans_barkot_det where kotdetid=@Refbarid)
    set @tmpiscocktail = (select iscocktail from Trans_barkot_det where kotdetid=@Refbarid)
    select @kotid = (select kotid from trans_barkot_det where kotdetid = @refbarid)
    select @counterid = (Select isnull(counterid,0) as counterid from trans_barkot_mas where kotid=@kotid)
   select @ml = (Select mlperbottle from Stock_itemmmas where Itemid=@storeitemid)
    if @tmpiscocktail <> 'D'
    begin
        if @counterid > 0
        begin
           Update Stock_itemmmas_counter Set Barstockqty=ISNULL(Barstockqty,0) -(@num* @qty ),barsalqty=ISNULL(barsalqty,0) + (@num* @qty)  where storeitemid=@storeitemid and ISNULL(Barstockqty,0)>0 and counterid =@counterid
		  -- Update Stock_itemmmas_counter Set Barstockqty=ISNULL(Barstockqty,0) -(@ml* @qty ),barsalqty=ISNULL(barsalqty,0) + (@ml* @qty)  where storeitemid=@storeitemid and ISNULL(Barstockqty,0)>0 and counterid =@counterid
        end
        Update Stock_itemmmas Set Barstockqty=ISNULL(Barstockqty,0) -(@num* @qty ),barsalqty=ISNULL(barsalqty,0) + (@num* @qty)  where itemid=@storeitemid and ISNULL(Barstockqty,0)>0
		---Update Stock_itemmmas Set Barstockqty=ISNULL(Barstockqty,0) -(@ml* @qty ),barsalqty=ISNULL(barsalqty,0) + (@ml* @qty)  where itemid=@storeitemid and ISNULL(Barstockqty,0)>0
    end

    Fetch next from barfirstkotins into @Refbarid,@storeitemid,@qty
end

Close barfirstkotins
Deallocate barfirstkotins


USE [elanza]
GO
/****** Object:  StoredProcedure [dbo].[kot__save__one]    Script Date: 26/02/2024 14:01:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[kot__save__one]
@tableid bigint,@counter bigint, @sessionid bigint, @tokenno bigint,@noofpax bigint,@Employee varchar(100)
As

declare @maskotcoout bigint=0
declare @qty bigint ,@part varchar(100),@itemid bigint ,@tqty bigint,@trat numeric(12,2),
@tamt numeric(12,2), @bool bigint=0,
@iscoktail varchar(2),@storeitemid bigint,@kotid bigint,@splinstruction varchar(1000),@kitmsg varchar(1000),
@nccoversion varchar(1000),
@Tamt1 numeric(12,2), @sum11 numeric(12,2)=0,@ncreson varchar(1000),@Employeeid bigint,@billid bigint,@mlqty bigint


set @maskotcoout= (select count(*) from trans_barkot_mas)


declare kotitemsfetch170719 cursor for 

SELECT DISTINCT bid.qty ,tk2.part,tk2.Itemid,Tqty,tk2.TRat,Tamt,iscocktail,
tk2.storeitemid,Kot_Id,Splinstruction,KITMSG,tk2.NCconversionreson,bm.Mlqty
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Stock_Itemmmas s on s.Itemid=tk2.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					inner join Barmltype bm on bm.Mlid=bid.mlid
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid
					--and isnull(tk2.Approved,0) =0
					 and  iscocktail <>'D'

open kotitemsfetch170719
set @maskotcoout= (select count(*) from trans_barkot_mas) 
set @billid= (select ident_current('Trans_BARKot_mas'))
		if(@billid > 1 and @maskotcoout >0)
		BEGIN
			set @billid = @billid+1						
		END       

    FETCH NEXT FROM kotitemsfetch170719 INTO  @qty,@part,@itemid,@tqty,@trat,@tamt,@iscoktail,@storeitemid,@kotid,@splinstruction,@kitmsg,@nccoversion,@mlqty
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool = 1
				INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,storeitemid,qty1,added,tkotid,Splinstruction,KITCHENMSG)values(@part,@billid,@itemid,@tqty,@trat,@tamt,@tableid,@iscoktail,@storeitemid,@tqty,0,@kotid,@splinstruction,@kitmsg)
				INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,(@tqty*@mlqty),ident_current('Trans_BARKot_det '))
				set	@Tamt1=@tamt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
                    
                FETCH NEXT FROM kotitemsfetch170719 INTO @qty,@part,@itemid,@tqty,@trat,@tamt,@iscoktail,@storeitemid,
				@kotid,@splinstruction,@kitmsg,@nccoversion,@mlqty
                END
                CLOSE kotitemsfetch170719
                DEALLOCATE kotitemsfetch170719




declare @baritemname varchar(500),@pax bigint, @sbarstockqty bigint,@icecreamorfood bigint,@otheritems bigint,@bool1 bigint
set @bool = 0

declare kotitemsfetch170720 cursor for 

SELECT DISTINCT btm.BarItemname,tk2.NCconversionreson,Splinstruction,KITMSG,tk2.Noofpax,iscocktail,tk2.TRat,
Kot_Id,Tqty,tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt,bm.Mlqty
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					inner join Barmltype bm on bm.Mlid=bid.mlid
					INNER JOIN Stock_Itemmmas s on s.Itemid=bid.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 				
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid
					and tk2.Approved ='1' 
					and iscocktail ='D'
					--and iscocktail ='Y'
					group by tk2.Itemid,btm.BarItemname,tk2.Noofpax,iscocktail,tk2.NCconversionreson,tk2.TRat,Kot_Id,Tqty,
					TableId,tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt,Tqty,Splinstruction,
					KITMSG,bm.Mlqty

open kotitemsfetch170720        

set @maskotcoout= (select count(*) from trans_barkot_mas)
set @billid= (select ident_current('Trans_BARKot_mas'))
		if(@billid >1 and @maskotcoout >0)
		BEGIN
			set @billid = @billid+1						
		END
    FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg,@pax,
	@iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt,@mlqty
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool = 1
				
					INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,qty1,added,
					tkotid,Splinstruction,KITCHENMSG,storeitemid)values
					(@part,@billid,@itemid,@tqty,@trat,@tamt,@tableid,@iscoktail,@tqty,0,@kotid,@splinstruction,@kitmsg,@storeitemid ) 
					INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,(@tqty*@mlqty),ident_current('Trans_BARKot_det '))

				
				set	@Tamt1=@tamt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
                    
                FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg,@pax,
	            @iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt,@mlqty
                END
                CLOSE kotitemsfetch170720
                DEALLOCATE kotitemsfetch170720

		
				
				
					
					
					
set @Employeeid = (select Employeeid from employee WHERE Employee=@Employee)
				

				
				
  INSERT INTO dbo.Trans_BARKot_mas(Refno,Raised,counterid,noofpax,part,tableid,Stwid,Kotno,Kotdate, 
  Kottime, totalamount, rOOMORTAB,Userid,sessionid,tokenno,NCconversionreson) 
  VALUES ('','0',@counter,@noofpax,@part,@tableid,@Employeeid,
  dbo.RotNo(),convert(VARCHAR,getdate(),101), convert(VARCHAR,getdate(),108), @sum11,'T',1,@sessionid,
 @tokenno,@ncreson) 



USE [elanza]
GO
/****** Object:  StoredProcedure [dbo].[kot__save__two]    Script Date: 26/02/2024 14:12:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[kot__save__two]
@tableid bigint,@counter bigint, @sessionid bigint, @tokenno bigint,@refdate datetime,@reftime datetime,@noofpax bigint,@Stwid bigint
As

declare @qty bigint ,@part varchar(100),@itemid bigint ,@tqty bigint,@trat numeric(12,2),@tamt numeric(12,2), @bool bigint=0,
@iscoktail varchar(2),@storeitemid bigint,@kotid bigint,@splinstruction varchar(1000),@kitmsg varchar(1000),
@nccoversion varchar(1000),
@Tamt1 numeric(12,2), @sum11 numeric(12,2),@ncreson varchar(1000),@Employeeid bigint,@billid bigint, @baritemname varchar(500),
@pax bigint, @sbarstockqty bigint,@icecreamorfood bigint,@otheritems bigint,@bool1 bigint,@nckotaccounttype bigint,@nctype varchar(100),
@itemname  varchar(100),@nc bigint, @nctypeid bigint, @ncaccid bigint,@amt numeric(12,2),@rate numeric(12,2),@mlqty bigint
set @sum11=0
set @sum11=0
set @amt=0

  INSERT INTO dbo.Trans_BARKot_mas(Refno,Raised,counterid,noofpax,part,tableid,Stwid,Kotno,Kotdate,  Kottime, totalamount, rOOMORTAB,Userid,sessionid,tokenno,NCconversionreson,refkotdate,refkottime) 
  VALUES ('','0',@counter,@noofpax,@part,@tableid,@Stwid,  dbo.RotNo(),@refdate,@reftime, @sum11,'T',1,@sessionid, @tokenno,@ncreson,convert(VARCHAR,getdate(),101), convert(VARCHAR,getdate(),108)) 
 set @billid=(Select SCOPE_IDENTITY())

declare kotitemsfetch170719 cursor for 
SELECT DISTINCT btm.BarItemname,tk2.NCconversionreson,isnull(tk2.nckotaccounttype,0) as nckotaccounttype ,nctype,
					Splinstruction,KITMSG,tk2.Noofpax,tk2.storeitemid,iscocktail,tk2.TRat,Kot_Id,Tqty,tk2.Itemid,
					s.Itemname,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt,bm.Mlqty
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Stock_Itemmmas s on s.Itemid=tk2.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					inner join Barmltype bm on bm.Mlid=bid.mlid
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid
					and tk2.Approved ='1'
set @bool1=0
open kotitemsfetch170719 
     

   FETCH NEXT FROM kotitemsfetch170719 INTO  @baritemname,@nccoversion,@nckotaccounttype,@nctype,@splinstruction,@kitmsg,
 @pax,@storeitemid,@iscoktail,@trat,@kotid,@tqty,@itemid,@itemname,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty
 ,@tamt,@mlqty
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool1 = 1
				IF(@nckotaccounttype=0)
					BEGIN
						set @nc=0
						set @nctypeid=0
						set @rate = @trat
						set @amt=@tamt
						set @ncaccid=0
					END
				ELSE
				    BEGIN
						set @nc=1
						set @nctypeid=@nctype
						set @rate = 0.00
						set @amt=0.00
						set @ncaccid=@nckotaccounttype
					END
		
				
				INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,storeitemid,qty1,added,tkotid,Splinstruction,KITCHENMSG,nckot,nctypeid,ncaccid)
				values(@part,@billid,@itemid,@tqty,@rate,@amt,@tableid,@iscoktail,@storeitemid,@tqty,0,@kotid,@splinstruction,@kitmsg,@nc,@nctypeid,@ncaccid)
				INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,(@tqty*@mlqty),ident_current('Trans_BARKot_det '))
				set	@Tamt1=@amt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
					
                    
               FETCH NEXT FROM kotitemsfetch170719 INTO  @baritemname,@nccoversion,@nckotaccounttype,@nctype,@splinstruction,@kitmsg,
 @pax,@storeitemid,@iscoktail,@trat,@kotid,@tqty,@itemid,@itemname,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt,@mlqty
                END
                CLOSE kotitemsfetch170719
                DEALLOCATE kotitemsfetch170719



declare kotitemsfetch170720 cursor for 


SELECT DISTINCT btm.BarItemname,tk2.NCconversionreson,Splinstruction,KITMSG,tk2.Noofpax,iscocktail,tk2.TRat,Kot_Id,Tqty,
tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt,bm.Mlqty
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					inner join Barmltype bm on bm.Mlid=bid.mlid
					INNER JOIN Stock_Itemmmas s on s.Itemid=bid.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 				
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid
					and tk2.Approved ='1' and iscocktail ='Y'
					group by tk2.Itemid,btm.BarItemname,tk2.NCconversionreson,tk2.Noofpax,iscocktail,tk2.TRat,Kot_Id,Tqty,
					TableId,tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt,Tqty,Splinstruction,
					KITMSG,bm.Mlqty
open kotitemsfetch170720        


    FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg, @pax,
@iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool1 = 1
				IF(@nckotaccounttype=0)
					BEGIN
						set @rate = @trat
						set @amt=@tamt
						
					END
				ELSE
				    BEGIN
					
						set @rate = 0.00
						set @amt=0.00
						
					END
				    INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,storeitemid,qty1,added,tkotid,Splinstruction,KITCHENMSG,nckot,nctypeid,ncaccid)
				values(@part,@billid,@itemid,@tqty,@rate,@amt,@tableid,@iscoktail,@storeitemid,@tqty,0,@kotid,@splinstruction,@kitmsg,@nc,@nctypeid,@ncaccid)
					INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,(@tqty*@mlqty),ident_current('Trans_BARKot_det '))

				
				set	@Tamt1=@amt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
                    
                FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg, @pax,
                @iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt,@mlqty
                END
                CLOSE kotitemsfetch170720
                DEALLOCATE kotitemsfetch170720

				if(@bool1=1)
				BEGIN
					select @Employeeid = Employeeid from employee WHERE istabsteward='1'
				END

					
--UPdate Mas
  UPdate dbo.Trans_BARKot_mas set part=@part, totalamount=@sum11,nckot=@nc,nctypeid=@nctypeid where Kotid=@billid

 update Tablemas set Status='K' where Tableid=@tableid
 --Delete from temp_kot2 where Tableid=@tableid
 select @billid as ID





USE [elanza]
GO
/****** Object:  StoredProcedure [dbo].[kot__save__two]    Script Date: 26/02/2024 14:12:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[kot__save__two]
@tableid bigint,@counter bigint, @sessionid bigint, @tokenno bigint,@refdate datetime,@reftime datetime,@noofpax bigint,@Stwid bigint
As

declare @qty bigint ,@part varchar(100),@itemid bigint ,@tqty bigint,@trat numeric(12,2),@tamt numeric(12,2), @bool bigint=0,
@iscoktail varchar(2),@storeitemid bigint,@kotid bigint,@splinstruction varchar(1000),@kitmsg varchar(1000),
@nccoversion varchar(1000),
@Tamt1 numeric(12,2), @sum11 numeric(12,2),@ncreson varchar(1000),@Employeeid bigint,@billid bigint, @baritemname varchar(500),
@pax bigint, @sbarstockqty bigint,@icecreamorfood bigint,@otheritems bigint,@bool1 bigint,@nckotaccounttype bigint,@nctype varchar(100),
@itemname  varchar(100),@nc bigint, @nctypeid bigint, @ncaccid bigint,@amt numeric(12,2),@rate numeric(12,2),@mlqty bigint
set @sum11=0
set @sum11=0
set @amt=0

  INSERT INTO dbo.Trans_BARKot_mas(Refno,Raised,counterid,noofpax,part,tableid,Stwid,Kotno,Kotdate,  Kottime, totalamount, rOOMORTAB,Userid,sessionid,tokenno,NCconversionreson,refkotdate,refkottime) 
  VALUES ('','0',@counter,@noofpax,@part,@tableid,@Stwid,  dbo.RotNo(),@refdate,@reftime, @sum11,'T',1,@sessionid, @tokenno,@ncreson,convert(VARCHAR,getdate(),101), convert(VARCHAR,getdate(),108)) 
 set @billid=(Select SCOPE_IDENTITY())

declare kotitemsfetch170719 cursor for 
SELECT DISTINCT btm.BarItemname,tk2.NCconversionreson,isnull(tk2.nckotaccounttype,0) as nckotaccounttype ,nctype,
					Splinstruction,KITMSG,tk2.Noofpax,tk2.storeitemid,iscocktail,tk2.TRat,Kot_Id,Tqty,tk2.Itemid,
					s.Itemname,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt,bm.Mlqty
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Stock_Itemmmas s on s.Itemid=tk2.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					inner join Barmltype bm on bm.Mlid=bid.mlid
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid
					and tk2.Approved ='1'
set @bool1=0
open kotitemsfetch170719 
     

   FETCH NEXT FROM kotitemsfetch170719 INTO  @baritemname,@nccoversion,@nckotaccounttype,@nctype,@splinstruction,@kitmsg,
 @pax,@storeitemid,@iscoktail,@trat,@kotid,@tqty,@itemid,@itemname,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty
 ,@tamt,@mlqty
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool1 = 1
				IF(@nckotaccounttype=0)
					BEGIN
						set @nc=0
						set @nctypeid=0
						set @rate = @trat
						set @amt=@tamt
						set @ncaccid=0
					END
				ELSE
				    BEGIN
						set @nc=1
						set @nctypeid=@nctype
						set @rate = 0.00
						set @amt=0.00
						set @ncaccid=@nckotaccounttype
					END
		
				
				INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,storeitemid,qty1,added,tkotid,Splinstruction,KITCHENMSG,nckot,nctypeid,ncaccid)
				values(@part,@billid,@itemid,@tqty,@rate,@amt,@tableid,@iscoktail,@storeitemid,@tqty,0,@kotid,@splinstruction,@kitmsg,@nc,@nctypeid,@ncaccid)
				INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,(@tqty*@mlqty),ident_current('Trans_BARKot_det '))
				set	@Tamt1=@amt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
					
                    
               FETCH NEXT FROM kotitemsfetch170719 INTO  @baritemname,@nccoversion,@nckotaccounttype,@nctype,@splinstruction,@kitmsg,
 @pax,@storeitemid,@iscoktail,@trat,@kotid,@tqty,@itemid,@itemname,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt,@mlqty
                END
                CLOSE kotitemsfetch170719
                DEALLOCATE kotitemsfetch170719



declare kotitemsfetch170720 cursor for 


SELECT DISTINCT btm.BarItemname,tk2.NCconversionreson,Splinstruction,KITMSG,tk2.Noofpax,iscocktail,tk2.TRat,Kot_Id,Tqty,
tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt,bm.Mlqty
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					inner join Barmltype bm on bm.Mlid=bid.mlid
					INNER JOIN Stock_Itemmmas s on s.Itemid=bid.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 				
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid
					and tk2.Approved ='1' and iscocktail ='Y'
					group by tk2.Itemid,btm.BarItemname,tk2.NCconversionreson,tk2.Noofpax,iscocktail,tk2.TRat,Kot_Id,Tqty,
					TableId,tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt,Tqty,Splinstruction,
					KITMSG,bm.Mlqty
open kotitemsfetch170720        


    FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg, @pax,
@iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool1 = 1
				IF(@nckotaccounttype=0)
					BEGIN
						set @rate = @trat
						set @amt=@tamt
						
					END
				ELSE
				    BEGIN
					
						set @rate = 0.00
						set @amt=0.00
						
					END
				    INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,storeitemid,qty1,added,tkotid,Splinstruction,KITCHENMSG,nckot,nctypeid,ncaccid)
				values(@part,@billid,@itemid,@tqty,@rate,@amt,@tableid,@iscoktail,@storeitemid,@tqty,0,@kotid,@splinstruction,@kitmsg,@nc,@nctypeid,@ncaccid)
					INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,(@tqty*@mlqty),ident_current('Trans_BARKot_det '))

				
				set	@Tamt1=@amt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
                    
                FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg, @pax,
                @iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt,@mlqty
                END
                CLOSE kotitemsfetch170720
                DEALLOCATE kotitemsfetch170720

				if(@bool1=1)
				BEGIN
					select @Employeeid = Employeeid from employee WHERE istabsteward='1'
				END

					
--UPdate Mas
  UPdate dbo.Trans_BARKot_mas set part=@part, totalamount=@sum11,nckot=@nc,nctypeid=@nctypeid where Kotid=@billid

 update Tablemas set Status='K' where Tableid=@tableid
 --Delete from temp_kot2 where Tableid=@tableid
 select @billid as ID





USE [elanza]
GO
/****** Object:  StoredProcedure [dbo].[kot__save__two]    Script Date: 26/02/2024 14:12:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[kot__save__two]
@tableid bigint,@counter bigint, @sessionid bigint, @tokenno bigint,@refdate datetime,@reftime datetime,@noofpax bigint,@Stwid bigint
As

declare @qty bigint ,@part varchar(100),@itemid bigint ,@tqty bigint,@trat numeric(12,2),@tamt numeric(12,2), @bool bigint=0,
@iscoktail varchar(2),@storeitemid bigint,@kotid bigint,@splinstruction varchar(1000),@kitmsg varchar(1000),
@nccoversion varchar(1000),
@Tamt1 numeric(12,2), @sum11 numeric(12,2),@ncreson varchar(1000),@Employeeid bigint,@billid bigint, @baritemname varchar(500),
@pax bigint, @sbarstockqty bigint,@icecreamorfood bigint,@otheritems bigint,@bool1 bigint,@nckotaccounttype bigint,@nctype varchar(100),
@itemname  varchar(100),@nc bigint, @nctypeid bigint, @ncaccid bigint,@amt numeric(12,2),@rate numeric(12,2),@mlqty bigint
set @sum11=0
set @sum11=0
set @amt=0

  INSERT INTO dbo.Trans_BARKot_mas(Refno,Raised,counterid,noofpax,part,tableid,Stwid,Kotno,Kotdate,  Kottime, totalamount, rOOMORTAB,Userid,sessionid,tokenno,NCconversionreson,refkotdate,refkottime) 
  VALUES ('','0',@counter,@noofpax,@part,@tableid,@Stwid,  dbo.RotNo(),@refdate,@reftime, @sum11,'T',1,@sessionid, @tokenno,@ncreson,convert(VARCHAR,getdate(),101), convert(VARCHAR,getdate(),108)) 
 set @billid=(Select SCOPE_IDENTITY())

declare kotitemsfetch170719 cursor for 
SELECT DISTINCT btm.BarItemname,tk2.NCconversionreson,isnull(tk2.nckotaccounttype,0) as nckotaccounttype ,nctype,
					Splinstruction,KITMSG,tk2.Noofpax,tk2.storeitemid,iscocktail,tk2.TRat,Kot_Id,Tqty,tk2.Itemid,
					s.Itemname,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt,bm.Mlqty
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Stock_Itemmmas s on s.Itemid=tk2.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					inner join Barmltype bm on bm.Mlid=bid.mlid
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid
					and tk2.Approved ='1'
set @bool1=0
open kotitemsfetch170719 
     

   FETCH NEXT FROM kotitemsfetch170719 INTO  @baritemname,@nccoversion,@nckotaccounttype,@nctype,@splinstruction,@kitmsg,
 @pax,@storeitemid,@iscoktail,@trat,@kotid,@tqty,@itemid,@itemname,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty
 ,@tamt,@mlqty
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool1 = 1
				IF(@nckotaccounttype=0)
					BEGIN
						set @nc=0
						set @nctypeid=0
						set @rate = @trat
						set @amt=@tamt
						set @ncaccid=0
					END
				ELSE
				    BEGIN
						set @nc=1
						set @nctypeid=@nctype
						set @rate = 0.00
						set @amt=0.00
						set @ncaccid=@nckotaccounttype
					END
		
				
				INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,storeitemid,qty1,added,tkotid,Splinstruction,KITCHENMSG,nckot,nctypeid,ncaccid)
				values(@part,@billid,@itemid,@tqty,@rate,@amt,@tableid,@iscoktail,@storeitemid,@tqty,0,@kotid,@splinstruction,@kitmsg,@nc,@nctypeid,@ncaccid)
				INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,(@tqty*@mlqty),ident_current('Trans_BARKot_det '))
				set	@Tamt1=@amt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
					
                    
               FETCH NEXT FROM kotitemsfetch170719 INTO  @baritemname,@nccoversion,@nckotaccounttype,@nctype,@splinstruction,@kitmsg,
 @pax,@storeitemid,@iscoktail,@trat,@kotid,@tqty,@itemid,@itemname,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt,@mlqty
                END
                CLOSE kotitemsfetch170719
                DEALLOCATE kotitemsfetch170719



declare kotitemsfetch170720 cursor for 


SELECT DISTINCT btm.BarItemname,tk2.NCconversionreson,Splinstruction,KITMSG,tk2.Noofpax,iscocktail,tk2.TRat,Kot_Id,Tqty,
tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt,bm.Mlqty
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					inner join Barmltype bm on bm.Mlid=bid.mlid
					INNER JOIN Stock_Itemmmas s on s.Itemid=bid.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 				
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid
					and tk2.Approved ='1' and iscocktail ='Y'
					group by tk2.Itemid,btm.BarItemname,tk2.NCconversionreson,tk2.Noofpax,iscocktail,tk2.TRat,Kot_Id,Tqty,
					TableId,tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt,Tqty,Splinstruction,
					KITMSG,bm.Mlqty
open kotitemsfetch170720        


    FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg, @pax,
@iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool1 = 1
				IF(@nckotaccounttype=0)
					BEGIN
						set @rate = @trat
						set @amt=@tamt
						
					END
				ELSE
				    BEGIN
					
						set @rate = 0.00
						set @amt=0.00
						
					END
				    INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,storeitemid,qty1,added,tkotid,Splinstruction,KITCHENMSG,nckot,nctypeid,ncaccid)
				values(@part,@billid,@itemid,@tqty,@rate,@amt,@tableid,@iscoktail,@storeitemid,@tqty,0,@kotid,@splinstruction,@kitmsg,@nc,@nctypeid,@ncaccid)
					INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,(@tqty*@mlqty),ident_current('Trans_BARKot_det '))

				
				set	@Tamt1=@amt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
                    
                FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg, @pax,
                @iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt,@mlqty
                END
                CLOSE kotitemsfetch170720
                DEALLOCATE kotitemsfetch170720

				if(@bool1=1)
				BEGIN
					select @Employeeid = Employeeid from employee WHERE istabsteward='1'
				END

					
--UPdate Mas
  UPdate dbo.Trans_BARKot_mas set part=@part, totalamount=@sum11,nckot=@nc,nctypeid=@nctypeid where Kotid=@billid

 update Tablemas set Status='K' where Tableid=@tableid
 --Delete from temp_kot2 where Tableid=@tableid
 select @billid as ID







USE [elanza]
GO
/****** Object:  Trigger [dbo].[Del_KOTBAR_barraise]    Script Date: 26/02/2024 15:13:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[Del_KOTBAR_barraise] ON [dbo].[Trans_BarKotdet_id]
FOR delete
AS
declare @Refbarid integer
declare @storeitemid integer
declare @num float
declare @qty integer,@tmpiscocktail as varchar(25),@counterid bigint,@kotid bigint,@ml numeric(12,2)

declare barfirstkotupd cursor for select Refkotdetid,storeitemid,qty from deleted ins
Open barfirstkotupd
Fetch next from barfirstkotupd into @Refbarid,@storeitemid,@qty
While @@Fetch_Status=0
begin

    set @num = (select qty from Trans_barkot_det where kotdetid=@Refbarid)
    select @kotid = (select kotid from trans_barkot_det where kotdetid = @refbarid)
    select @counterid = (Select isnull(counterid,0) as counterid from trans_barkot_mas where kotid=@kotid)   
       select @ml = (Select mlperbottle from Stock_itemmmas where Itemid=@storeitemid)
    set @tmpiscocktail = (select iscocktail from Trans_barkot_det where kotdetid=@Refbarid)
    
    if @tmpiscocktail <> 'D'
    begin
       if @counterid > 0
       begin
	    Update Stock_itemmmas_counter Set Barstockqty=Barstockqty +( @qty ),
		 barsalqty=barsalqty - ( @qty)  where storeitemid=@storeitemid and counterid = @counterid
         --Update Stock_itemmmas_counter Set Barstockqty=Barstockqty +(@num* @qty ),barsalqty=barsalqty - (@num* @qty)  where storeitemid=@storeitemid and counterid = @counterid
		-- Update Stock_itemmmas_counter Set Barstockqty=Barstockqty +(@ml* @qty ),barsalqty=barsalqty - (@ml* @qty)  where storeitemid=@storeitemid and counterid = @counterid
       end
       Update Stock_itemmmas Set Barstockqty=Barstockqty +( @qty ),barsalqty=barsalqty - ( @qty)  where itemid=@storeitemid
	    --Update Stock_itemmmas Set Barstockqty=Barstockqty +(@ml* @qty ),barsalqty=barsalqty - (@ml* @qty)  where itemid=@storeitemid
    end

    Fetch next from barfirstkotupd into @Refbarid,@storeitemid,@qty
end

Close barfirstkotupd
Deallocate barfirstkotupd


USE [elanza]
GO
/****** Object:  Trigger [dbo].[Insert_KOTBAR_barraise]    Script Date: 26/02/2024 15:09:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[Insert_KOTBAR_barraise] ON [dbo].[Trans_BarKotdet_id]
FOR INSERT
AS
declare @Refbarid integer
declare @storeitemid integer
declare @num float
declare @qty integer,@tmpiscocktail as varchar(25),@counterid bigint,@kotid bigint,@ml numeric(12,2)

declare barfirstkotins cursor for select Refkotdetid,storeitemid,qty from inserted ins
Open barfirstkotins
Fetch next from barfirstkotins into @Refbarid,@storeitemid,@qty
While @@Fetch_Status=0
begin

    set @num = (select qty from Trans_barkot_det where kotdetid=@Refbarid)
    set @tmpiscocktail = (select iscocktail from Trans_barkot_det where kotdetid=@Refbarid)
    select @kotid = (select kotid from trans_barkot_det where kotdetid = @refbarid)
    select @counterid = (Select isnull(counterid,0) as counterid from trans_barkot_mas where kotid=@kotid)
   select @ml = (Select mlperbottle from Stock_itemmmas where Itemid=@storeitemid)
    if @tmpiscocktail <> 'D'
    begin
        if @counterid > 0
        begin
		  Update Stock_itemmmas_counter Set Barstockqty=ISNULL(Barstockqty,0) -( @qty ),barsalqty=ISNULL(barsalqty,0) + ( @qty)  where storeitemid=@storeitemid and ISNULL(Barstockqty,0)>0 and counterid =@counterid
		  
          -- Update Stock_itemmmas_counter Set Barstockqty=ISNULL(Barstockqty,0) -(@num* @qty ),barsalqty=ISNULL(barsalqty,0) + (@num* @qty)  where storeitemid=@storeitemid and ISNULL(Barstockqty,0)>0 and counterid =@counterid
		  -- Update Stock_itemmmas_counter Set Barstockqty=ISNULL(Barstockqty,0) -(@ml* @qty ),barsalqty=ISNULL(barsalqty,0) + (@ml* @qty)  where storeitemid=@storeitemid and ISNULL(Barstockqty,0)>0 and counterid =@counterid
        end

		        Update Stock_itemmmas Set Barstockqty=ISNULL(Barstockqty,0) -( @qty ),barsalqty=ISNULL(barsalqty,0) + ( @qty)  where itemid=@storeitemid and ISNULL(Barstockqty,0)>0
        --Update Stock_itemmmas Set Barstockqty=ISNULL(Barstockqty,0) -(@num* @qty ),barsalqty=ISNULL(barsalqty,0) + (@num* @qty)  where itemid=@storeitemid and ISNULL(Barstockqty,0)>0
		---Update Stock_itemmmas Set Barstockqty=ISNULL(Barstockqty,0) -(@ml* @qty ),barsalqty=ISNULL(barsalqty,0) + (@ml* @qty)  where itemid=@storeitemid and ISNULL(Barstockqty,0)>0
    end

    Fetch next from barfirstkotins into @Refbarid,@storeitemid,@qty
end

Close barfirstkotins
Deallocate barfirstkotins


USE [elanza]
GO
/****** Object:  Trigger [dbo].[Insert_KOTBAR_barraise]    Script Date: 26/02/2024 15:09:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[Insert_KOTBAR_barraise] ON [dbo].[Trans_BarKotdet_id]
FOR INSERT
AS
declare @Refbarid integer
declare @storeitemid integer
declare @num float
declare @qty integer,@tmpiscocktail as varchar(25),@counterid bigint,@kotid bigint,@ml numeric(12,2)

declare barfirstkotins cursor for select Refkotdetid,storeitemid,qty from inserted ins
Open barfirstkotins
Fetch next from barfirstkotins into @Refbarid,@storeitemid,@qty
While @@Fetch_Status=0
begin

    set @num = (select qty from Trans_barkot_det where kotdetid=@Refbarid)
    set @tmpiscocktail = (select iscocktail from Trans_barkot_det where kotdetid=@Refbarid)
    select @kotid = (select kotid from trans_barkot_det where kotdetid = @refbarid)
    select @counterid = (Select isnull(counterid,0) as counterid from trans_barkot_mas where kotid=@kotid)
   select @ml = (Select mlperbottle from Stock_itemmmas where Itemid=@storeitemid)
    if @tmpiscocktail <> 'D'
    begin
        if @counterid > 0
        begin
		 -- Update Stock_itemmmas_counter Set Barstockqty=ISNULL(Barstockqty,0) -( @qty ),barsalqty=ISNULL(barsalqty,0) + ( @qty)  where storeitemid=@storeitemid and ISNULL(Barstockqty,0)>0 and counterid =@counterid
		  
         Update Stock_itemmmas_counter Set Barstockqty=ISNULL(Barstockqty,0) -(@num* @qty ),barsalqty=ISNULL(barsalqty,0) + (@num* @qty)  where storeitemid=@storeitemid and ISNULL(Barstockqty,0)>0 and counterid =@counterid
		  -- Update Stock_itemmmas_counter Set Barstockqty=ISNULL(Barstockqty,0) -(@ml* @qty ),barsalqty=ISNULL(barsalqty,0) + (@ml* @qty)  where storeitemid=@storeitemid and ISNULL(Barstockqty,0)>0 and counterid =@counterid
        end

		        --Update Stock_itemmmas Set Barstockqty=ISNULL(Barstockqty,0) -( @qty ),barsalqty=ISNULL(barsalqty,0) + ( @qty)  where itemid=@storeitemid and ISNULL(Barstockqty,0)>0
       Update Stock_itemmmas Set Barstockqty=ISNULL(Barstockqty,0) -(@num* @qty ),barsalqty=ISNULL(barsalqty,0) + (@num* @qty)  where itemid=@storeitemid and ISNULL(Barstockqty,0)>0
		---Update Stock_itemmmas Set Barstockqty=ISNULL(Barstockqty,0) -(@ml* @qty ),barsalqty=ISNULL(barsalqty,0) + (@ml* @qty)  where itemid=@storeitemid and ISNULL(Barstockqty,0)>0
    end

    Fetch next from barfirstkotins into @Refbarid,@storeitemid,@qty
end

Close barfirstkotins
Deallocate barfirstkotins


USE [elanza]
GO
/****** Object:  Trigger [dbo].[Del_KOTBAR_barraise]    Script Date: 26/02/2024 15:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[Del_KOTBAR_barraise] ON [dbo].[Trans_BarKotdet_id]
FOR delete
AS
declare @Refbarid integer
declare @storeitemid integer
declare @num float
declare @qty integer,@tmpiscocktail as varchar(25),@counterid bigint,@kotid bigint,@ml numeric(12,2)

declare barfirstkotupd cursor for select Refkotdetid,storeitemid,qty from deleted ins
Open barfirstkotupd
Fetch next from barfirstkotupd into @Refbarid,@storeitemid,@qty
While @@Fetch_Status=0
begin

    set @num = (select qty from Trans_barkot_det where kotdetid=@Refbarid)
    select @kotid = (select kotid from trans_barkot_det where kotdetid = @refbarid)
    select @counterid = (Select isnull(counterid,0) as counterid from trans_barkot_mas where kotid=@kotid)   
       select @ml = (Select mlperbottle from Stock_itemmmas where Itemid=@storeitemid)
    set @tmpiscocktail = (select iscocktail from Trans_barkot_det where kotdetid=@Refbarid)
    
    if @tmpiscocktail <> 'D'
    begin
       if @counterid > 0
       begin
	   -- Update Stock_itemmmas_counter Set Barstockqty=Barstockqty +( @qty ),
		-- barsalqty=barsalqty - ( @qty)  where storeitemid=@storeitemid and counterid = @counterid
         Update Stock_itemmmas_counter Set Barstockqty=Barstockqty +(@num* @qty ),barsalqty=barsalqty - (@num* @qty)  where storeitemid=@storeitemid and counterid = @counterid
		-- Update Stock_itemmmas_counter Set Barstockqty=Barstockqty +(@ml* @qty ),barsalqty=barsalqty - (@ml* @qty)  where storeitemid=@storeitemid and counterid = @counterid
       end
       Update Stock_itemmmas Set Barstockqty=Barstockqty +( @num*@qty ),barsalqty=barsalqty - ( @num*@qty)  where itemid=@storeitemid
	    --Update Stock_itemmmas Set Barstockqty=Barstockqty +(@ml* @qty ),barsalqty=barsalqty - (@ml* @qty)  where itemid=@storeitemid
    end

    Fetch next from barfirstkotupd into @Refbarid,@storeitemid,@qty
end

Close barfirstkotupd
Deallocate barfirstkotupd


USE [elanza]
GO
/****** Object:  StoredProcedure [dbo].[kot__save__one]    Script Date: 26/02/2024 15:21:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[kot__save__one]
@tableid bigint,@counter bigint, @sessionid bigint, @tokenno bigint,@noofpax bigint,@Employee varchar(100)
As

declare @maskotcoout bigint=0
declare @qty bigint ,@part varchar(100),@itemid bigint ,@tqty bigint,@trat numeric(12,2),
@tamt numeric(12,2), @bool bigint=0,
@iscoktail varchar(2),@storeitemid bigint,@kotid bigint,@splinstruction varchar(1000),@kitmsg varchar(1000),
@nccoversion varchar(1000),
@Tamt1 numeric(12,2), @sum11 numeric(12,2)=0,@ncreson varchar(1000),@Employeeid bigint,@billid bigint,@mlqty bigint


set @maskotcoout= (select count(*) from trans_barkot_mas)


declare kotitemsfetch170719 cursor for 

SELECT DISTINCT bid.qty ,tk2.part,tk2.Itemid,Tqty,tk2.TRat,Tamt,iscocktail,
tk2.storeitemid,Kot_Id,Splinstruction,KITMSG,tk2.NCconversionreson,bm.Mlqty
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Stock_Itemmmas s on s.Itemid=tk2.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					inner join Barmltype bm on bm.Mlid=bid.mlid
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid
					--and isnull(tk2.Approved,0) =0
					 and  iscocktail <>'D'

open kotitemsfetch170719
set @maskotcoout= (select count(*) from trans_barkot_mas) 
set @billid= (select ident_current('Trans_BARKot_mas'))
		if(@billid > 1 and @maskotcoout >0)
		BEGIN
			set @billid = @billid+1						
		END       

    FETCH NEXT FROM kotitemsfetch170719 INTO  @qty,@part,@itemid,@tqty,@trat,@tamt,@iscoktail,@storeitemid,@kotid,@splinstruction,@kitmsg,@nccoversion,@mlqty
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool = 1
				INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,storeitemid,qty1,added,tkotid,Splinstruction,KITCHENMSG)values(@part,@billid,@itemid,@tqty,@trat,@tamt,@tableid,@iscoktail,@storeitemid,@tqty,0,@kotid,@splinstruction,@kitmsg)
				INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,(@mlqty),ident_current('Trans_BARKot_det '))
				set	@Tamt1=@tamt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
                    
                FETCH NEXT FROM kotitemsfetch170719 INTO @qty,@part,@itemid,@tqty,@trat,@tamt,@iscoktail,@storeitemid,
				@kotid,@splinstruction,@kitmsg,@nccoversion,@mlqty
                END
                CLOSE kotitemsfetch170719
                DEALLOCATE kotitemsfetch170719




declare @baritemname varchar(500),@pax bigint, @sbarstockqty bigint,@icecreamorfood bigint,@otheritems bigint,@bool1 bigint
set @bool = 0

declare kotitemsfetch170720 cursor for 

SELECT DISTINCT btm.BarItemname,tk2.NCconversionreson,Splinstruction,KITMSG,tk2.Noofpax,iscocktail,tk2.TRat,
Kot_Id,Tqty,tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt,bm.Mlqty
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					inner join Barmltype bm on bm.Mlid=bid.mlid
					INNER JOIN Stock_Itemmmas s on s.Itemid=bid.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 				
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid
					and tk2.Approved ='1' 
					and iscocktail ='D'
					--and iscocktail ='Y'
					group by tk2.Itemid,btm.BarItemname,tk2.Noofpax,iscocktail,tk2.NCconversionreson,tk2.TRat,Kot_Id,Tqty,
					TableId,tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt,Tqty,Splinstruction,
					KITMSG,bm.Mlqty

open kotitemsfetch170720        

set @maskotcoout= (select count(*) from trans_barkot_mas)
set @billid= (select ident_current('Trans_BARKot_mas'))
		if(@billid >1 and @maskotcoout >0)
		BEGIN
			set @billid = @billid+1						
		END
    FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg,@pax,
	@iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt,@mlqty
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool = 1
				
					INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,qty1,added,
					tkotid,Splinstruction,KITCHENMSG,storeitemid)values
					(@part,@billid,@itemid,@tqty,@trat,@tamt,@tableid,@iscoktail,@tqty,0,@kotid,@splinstruction,@kitmsg,@storeitemid ) 
					INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,(@mlqty),ident_current('Trans_BARKot_det '))

				
				set	@Tamt1=@tamt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
                    
                FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg,@pax,
	            @iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt,@mlqty
                END
                CLOSE kotitemsfetch170720
                DEALLOCATE kotitemsfetch170720

		
				
				
					
					
					
set @Employeeid = (select Employeeid from employee WHERE Employee=@Employee)
				

				
				
  INSERT INTO dbo.Trans_BARKot_mas(Refno,Raised,counterid,noofpax,part,tableid,Stwid,Kotno,Kotdate, 
  Kottime, totalamount, rOOMORTAB,Userid,sessionid,tokenno,NCconversionreson) 
  VALUES ('','0',@counter,@noofpax,@part,@tableid,@Employeeid,
  dbo.RotNo(),convert(VARCHAR,getdate(),101), convert(VARCHAR,getdate(),108), @sum11,'T',1,@sessionid,
 @tokenno,@ncreson) 



USE [elanza]
GO
/****** Object:  StoredProcedure [dbo].[kot__save__two]    Script Date: 26/02/2024 15:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[kot__save__two]
@tableid bigint,@counter bigint, @sessionid bigint, @tokenno bigint,@refdate datetime,@reftime datetime,@noofpax bigint,@Stwid bigint
As

declare @qty bigint ,@part varchar(100),@itemid bigint ,@tqty bigint,@trat numeric(12,2),@tamt numeric(12,2), @bool bigint=0,
@iscoktail varchar(2),@storeitemid bigint,@kotid bigint,@splinstruction varchar(1000),@kitmsg varchar(1000),
@nccoversion varchar(1000),
@Tamt1 numeric(12,2), @sum11 numeric(12,2),@ncreson varchar(1000),@Employeeid bigint,@billid bigint, @baritemname varchar(500),
@pax bigint, @sbarstockqty bigint,@icecreamorfood bigint,@otheritems bigint,@bool1 bigint,@nckotaccounttype bigint,@nctype varchar(100),
@itemname  varchar(100),@nc bigint, @nctypeid bigint, @ncaccid bigint,@amt numeric(12,2),@rate numeric(12,2),@mlqty bigint
set @sum11=0
set @sum11=0
set @amt=0

  INSERT INTO dbo.Trans_BARKot_mas(Refno,Raised,counterid,noofpax,part,tableid,Stwid,Kotno,Kotdate,  Kottime, totalamount, rOOMORTAB,Userid,sessionid,tokenno,NCconversionreson,refkotdate,refkottime) 
  VALUES ('','0',@counter,@noofpax,@part,@tableid,@Stwid,  dbo.RotNo(),@refdate,@reftime, @sum11,'T',1,@sessionid, @tokenno,@ncreson,convert(VARCHAR,getdate(),101), convert(VARCHAR,getdate(),108)) 
 set @billid=(Select SCOPE_IDENTITY())

declare kotitemsfetch170719 cursor for 
SELECT DISTINCT btm.BarItemname,tk2.NCconversionreson,isnull(tk2.nckotaccounttype,0) as nckotaccounttype ,nctype,
					Splinstruction,KITMSG,tk2.Noofpax,tk2.storeitemid,iscocktail,tk2.TRat,Kot_Id,Tqty,tk2.Itemid,
					s.Itemname,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt,bm.Mlqty
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Stock_Itemmmas s on s.Itemid=tk2.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					inner join Barmltype bm on bm.Mlid=bid.mlid
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid
					and tk2.Approved ='1'
set @bool1=0
open kotitemsfetch170719 
     

   FETCH NEXT FROM kotitemsfetch170719 INTO  @baritemname,@nccoversion,@nckotaccounttype,@nctype,@splinstruction,@kitmsg,
 @pax,@storeitemid,@iscoktail,@trat,@kotid,@tqty,@itemid,@itemname,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty
 ,@tamt,@mlqty
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool1 = 1
				IF(@nckotaccounttype=0)
					BEGIN
						set @nc=0
						set @nctypeid=0
						set @rate = @trat
						set @amt=@tamt
						set @ncaccid=0
					END
				ELSE
				    BEGIN
						set @nc=1
						set @nctypeid=@nctype
						set @rate = 0.00
						set @amt=0.00
						set @ncaccid=@nckotaccounttype
					END
		
				
				INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,storeitemid,qty1,added,tkotid,Splinstruction,KITCHENMSG,nckot,nctypeid,ncaccid)
				values(@part,@billid,@itemid,@tqty,@rate,@amt,@tableid,@iscoktail,@storeitemid,@tqty,0,@kotid,@splinstruction,@kitmsg,@nc,@nctypeid,@ncaccid)
				INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,(@mlqty),ident_current('Trans_BARKot_det '))
				set	@Tamt1=@amt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
					
                    
               FETCH NEXT FROM kotitemsfetch170719 INTO  @baritemname,@nccoversion,@nckotaccounttype,@nctype,@splinstruction,@kitmsg,
 @pax,@storeitemid,@iscoktail,@trat,@kotid,@tqty,@itemid,@itemname,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt,@mlqty
                END
                CLOSE kotitemsfetch170719
                DEALLOCATE kotitemsfetch170719



declare kotitemsfetch170720 cursor for 


SELECT DISTINCT btm.BarItemname,tk2.NCconversionreson,Splinstruction,KITMSG,tk2.Noofpax,iscocktail,tk2.TRat,Kot_Id,Tqty,
tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt,bm.Mlqty
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					inner join Barmltype bm on bm.Mlid=bid.mlid
					INNER JOIN Stock_Itemmmas s on s.Itemid=bid.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 				
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid
					and tk2.Approved ='1' and iscocktail ='Y'
					group by tk2.Itemid,btm.BarItemname,tk2.NCconversionreson,tk2.Noofpax,iscocktail,tk2.TRat,Kot_Id,Tqty,
					TableId,tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt,Tqty,Splinstruction,
					KITMSG,bm.Mlqty
open kotitemsfetch170720        


    FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg, @pax,
@iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool1 = 1
				IF(@nckotaccounttype=0)
					BEGIN
						set @rate = @trat
						set @amt=@tamt
						
					END
				ELSE
				    BEGIN
					
						set @rate = 0.00
						set @amt=0.00
						
					END
				    INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,storeitemid,qty1,added,tkotid,Splinstruction,KITCHENMSG,nckot,nctypeid,ncaccid)
				values(@part,@billid,@itemid,@tqty,@rate,@amt,@tableid,@iscoktail,@storeitemid,@tqty,0,@kotid,@splinstruction,@kitmsg,@nc,@nctypeid,@ncaccid)
					INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,(@mlqty),ident_current('Trans_BARKot_det '))

				
				set	@Tamt1=@amt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
                    
                FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg, @pax,
                @iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt,@mlqty
                END
                CLOSE kotitemsfetch170720
                DEALLOCATE kotitemsfetch170720

				if(@bool1=1)
				BEGIN
					select @Employeeid = Employeeid from employee WHERE istabsteward='1'
				END

					
--UPdate Mas
  UPdate dbo.Trans_BARKot_mas set part=@part, totalamount=@sum11,nckot=@nc,nctypeid=@nctypeid where Kotid=@billid

 update Tablemas set Status='K' where Tableid=@tableid
 --Delete from temp_kot2 where Tableid=@tableid
 select @billid as ID





ALTER PROCEDURE Get_BarReport  
@Fromdate DATETIME,@Todate DATETIME,@Itemid BIGINT
AS  
BEGIN  
Select isnull(Si.Baropstock,0) as baropstock,Si.itemid, itemgroup.ORDBY ,Si.itemname,si.mlperbottle,(isnull(oldsal.salqty,0)) Oldsales ,(isnull(oldinward.qtybtl,0)) OldIssue, (isnull(oldadj.qty,0)) OldAdjustqty ,(isnull(newsal.salQty,0)) NewsalesT, (isnull(newsalR1.salQty,0)) NewsalesR,(isnull(newInward.qtybtl,0)) as Newissue, (isnull(newadj.newadjqty,0)) newAdjustqty,(isnull(newPhy.qty,0)) newPhysical,Itemgroup.Itemgroup, isnull(itemgroup.beeritems,0) beeritems, isnull(itemgroup.otheritems,0) otheritems,si.pegml from Stock_itemmmas Si 
                left outer join (Select Sum(oldsal.qty * oldkd.qty)salqty,oldkd.storeitemid from Trans_Barkot_mas oldmas, Trans_Barkot_det oldsal, Trans_Barkotdet_id oldkd where oldsal.kotid=oldmas.kotid and oldsal.kotdetid=oldkd.refkotdetid and kotdate < @Fromdate AND isnull(oldmas.Cancelornorm,'N')<>'C' group by oldkd.storeitemid) as oldsal on oldsal.storeitemid=si.itemid 
                 left outer join (Select Sum(oldinw.qty) as qtybtl,oldinw.itemid from Trans_Bar_inwardmas oldinwmas, Trans_Bar_inwarddet oldinw where oldinw.inwid=oldinwmas.inwid and convert(datetime,Entrydate,101) < @Fromdate and isnull(oldinwmas.restypeid,0)=0 group by itemid) as oldinward on oldinward.itemid=si.itemid 
                 left outer join (Select Sum(oldadjdet.qty * (convert(numeric,oldadjdet.Addorless + '1'))) as qty ,oldadjdet.itemid from Trans_Bar_StockAdjustmentmas oldadjmas,Trans_Bar_StockAdjustmentdet oldadjdet where oldadjdet.adjid=oldadjmas.adjid and oldadjmas.Baroorstore='B' and convert(date,Entrydate,101) < @Fromdate group by itemid) oldadj on  oldadj.itemid=si.itemid 
                 left outer join (Select Sum(newsal.qty * newkd.qty)salqty, newkd.storeitemid from Trans_Barkot_mas newmas, Trans_Barkot_det newsal, Trans_Barkotdet_id newkd where newsal.kotid=newmas.kotid  and newsal.kotdetid=newkd.refkotdetid and kotdate between @Fromdate and @Todate AND isnull(newmas.Cancelornorm,'N')<>'C' AND rOOMORTAB='T' group by newkd.storeitemid) as newsal on newsal.storeitemid=si.itemid 
                 left outer join (Select Sum(newsal.qty * newkd.qty)salqty, newkd.storeitemid from Trans_Barkot_mas newmas, Trans_Barkot_det newsal, Trans_Barkotdet_id newkd where newsal.kotid=newmas.kotid and newsal.kotdetid=newkd.refkotdetid and kotdate between @Fromdate and @Todate AND isnull(newmas.Cancelornorm,'N')<>'C' AND rOOMORTAB='R' group by newkd.storeitemid) as newsalR1 on newsalR1.storeitemid=si.itemid 
                 left outer join (Select Sum(newadjdet.qty * (convert(numeric,newadjdet.Addorless + '1'))) as newadjqty, newadjdet.itemid from   Trans_Bar_StockAdjustmentmas newadjmas,Trans_Bar_StockAdjustmentdet newadjdet where newadjdet.adjid=newadjmas.adjid and newadjmas.Baroorstore='B' and convert(date,Entrydate,101) between @Fromdate and @Todate group by itemid) newadj on newadj.itemid=si.itemid 
                 left outer join (Select Sum(newinw.qty) as qtybtl,newinw.itemid from Trans_Bar_inwardmas newinwmas, Trans_Bar_inwarddet newinw where newinw.inwid=newinwmas.inwid and convert(date,Entrydate,101) between @Fromdate and @Todate and isnull(newinwmas.restypeid,0)=0 group by itemid) as newinward on newinward.itemid=si.itemid 
                left outer join (Select Sum(newphydet.qty) as qty ,newphydet.itemid from Trans_Bar_physicalmas newphymas, Trans_Bar_physicaldet newphydet   where newphydet.adjid=newphymas.adjid and convert(date,Entrydate,101) between @Fromdate and @Todate and newphymas.Baroorstore='B' group by itemid) newphy  on  newphy.itemid=si.itemid 
                 inner join Itemgroup on itemgroup.itemgroupid=si.itemgroupid WHERE isnull(ITEMGROUP.barorfood,0)=1 and isnull(ITEMGROUP.otheritems,0) <> 1 AND si.Itemid=@itemid order by Itemgroup.ordby,itemgroup,si.orderby,SI.ITEMNAME 
END

USE [elanza]
GO
/****** Object:  Trigger [dbo].[Del_KOTBAR_barraise]    Script Date: 26/02/2024 16:20:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[Del_KOTBAR_barraise] ON [dbo].[Trans_BarKotdet_id]
FOR delete
AS
declare @Refbarid integer
declare @storeitemid integer
declare @num float
declare @qty integer,@tmpiscocktail as varchar(25),@counterid bigint,@kotid bigint,@ml numeric(12,2),@beer bigint=0,@other bigint=0

declare barfirstkotupd cursor for select Refkotdetid,storeitemid,qty from deleted ins
Open barfirstkotupd
Fetch next from barfirstkotupd into @Refbarid,@storeitemid,@qty
While @@Fetch_Status=0
begin

    set @num = (select qty from Trans_barkot_det where kotdetid=@Refbarid)
    select @kotid = (select kotid from trans_barkot_det where kotdetid = @refbarid)
    select @counterid = (Select isnull(counterid,0) as counterid from trans_barkot_mas where kotid=@kotid)   
       
    set @tmpiscocktail = (select iscocktail from Trans_barkot_det where kotdetid=@Refbarid)
    
	   select @ml = (Select s.mlperbottle from Stock_itemmmas s inner join itemgroup itm on itm.itemgroupid=s.Itemgroupid 
   where Itemid=@storeitemid)
   select @beer = (Select itm.beeritems from Stock_itemmmas s inner join itemgroup itm on itm.itemgroupid=s.Itemgroupid 
   where Itemid=@storeitemid)
    select @other = (Select itm.otheritems from Stock_itemmmas s inner join itemgroup itm on itm.itemgroupid=s.Itemgroupid 
   where Itemid=@storeitemid)

   if (@beer = 1 or @other = 1)
   begin
	set @num = @num * @ml
   end
    if @tmpiscocktail <> 'D'
    begin
       if @counterid > 0
       begin
	   -- Update Stock_itemmmas_counter Set Barstockqty=Barstockqty +( @qty ),
		-- barsalqty=barsalqty - ( @qty)  where storeitemid=@storeitemid and counterid = @counterid
         Update Stock_itemmmas_counter Set Barstockqty=Barstockqty +(@num* @qty ),barsalqty=barsalqty - (@num* @qty)  where storeitemid=@storeitemid and counterid = @counterid
		-- Update Stock_itemmmas_counter Set Barstockqty=Barstockqty +(@ml* @qty ),barsalqty=barsalqty - (@ml* @qty)  where storeitemid=@storeitemid and counterid = @counterid
       end
       Update Stock_itemmmas Set Barstockqty=Barstockqty +( @num*@qty ),barsalqty=barsalqty - ( @num*@qty)  where itemid=@storeitemid
	    --Update Stock_itemmmas Set Barstockqty=Barstockqty +(@ml* @qty ),barsalqty=barsalqty - (@ml* @qty)  where itemid=@storeitemid
    end

    Fetch next from barfirstkotupd into @Refbarid,@storeitemid,@qty
end

Close barfirstkotupd
Deallocate barfirstkotupd


USE [elanza]
GO
/****** Object:  Trigger [dbo].[Insert_KOTBAR_barraise]    Script Date: 26/02/2024 15:55:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[Insert_KOTBAR_barraise] ON [dbo].[Trans_BarKotdet_id]
FOR INSERT
AS
declare @Refbarid integer
declare @storeitemid integer
declare @num float
declare @qty integer,@tmpiscocktail as varchar(25),@counterid bigint,@kotid bigint,@ml numeric(12,2),@beer bigint=0,@other bigint=0

declare barfirstkotins cursor for select Refkotdetid,storeitemid,qty from inserted ins
Open barfirstkotins
Fetch next from barfirstkotins into @Refbarid,@storeitemid,@qty
While @@Fetch_Status=0
begin

    set @num = (select qty from Trans_barkot_det where kotdetid=@Refbarid)
    set @tmpiscocktail = (select iscocktail from Trans_barkot_det where kotdetid=@Refbarid)
    select @kotid = (select kotid from trans_barkot_det where kotdetid = @refbarid)
    select @counterid = (Select isnull(counterid,0) as counterid from trans_barkot_mas where kotid=@kotid)
   select @ml = (Select s.mlperbottle from Stock_itemmmas s inner join itemgroup itm on itm.itemgroupid=s.Itemgroupid 
   where Itemid=@storeitemid)
   select @beer = (Select itm.beeritems from Stock_itemmmas s inner join itemgroup itm on itm.itemgroupid=s.Itemgroupid 
   where Itemid=@storeitemid)
    select @other = (Select itm.otheritems from Stock_itemmmas s inner join itemgroup itm on itm.itemgroupid=s.Itemgroupid 
   where Itemid=@storeitemid)

   if (@beer = 1 or @other = 1)
   begin
	set @num = @num * @ml
   end
    if @tmpiscocktail <> 'D'
    begin
        if @counterid > 0
        begin
		 -- Update Stock_itemmmas_counter Set Barstockqty=ISNULL(Barstockqty,0) -( @qty ),barsalqty=ISNULL(barsalqty,0) + ( @qty)  where storeitemid=@storeitemid and ISNULL(Barstockqty,0)>0 and counterid =@counterid
		  
         Update Stock_itemmmas_counter Set Barstockqty=ISNULL(Barstockqty,0) -(@num* @qty ),barsalqty=ISNULL(barsalqty,0) + (@num* @qty)  where storeitemid=@storeitemid and ISNULL(Barstockqty,0)>0 and counterid =@counterid
		  -- Update Stock_itemmmas_counter Set Barstockqty=ISNULL(Barstockqty,0) -(@ml* @qty ),barsalqty=ISNULL(barsalqty,0) + (@ml* @qty)  where storeitemid=@storeitemid and ISNULL(Barstockqty,0)>0 and counterid =@counterid
        end

		        --Update Stock_itemmmas Set Barstockqty=ISNULL(Barstockqty,0) -( @qty ),barsalqty=ISNULL(barsalqty,0) + ( @qty)  where itemid=@storeitemid and ISNULL(Barstockqty,0)>0
       Update Stock_itemmmas Set Barstockqty=ISNULL(Barstockqty,0) -(@num* @qty ),barsalqty=ISNULL(barsalqty,0) + (@num* @qty)  where itemid=@storeitemid and ISNULL(Barstockqty,0)>0
		---Update Stock_itemmmas Set Barstockqty=ISNULL(Barstockqty,0) -(@ml* @qty ),barsalqty=ISNULL(barsalqty,0) + (@ml* @qty)  where itemid=@storeitemid and ISNULL(Barstockqty,0)>0
    end

    Fetch next from barfirstkotins into @Refbarid,@storeitemid,@qty
end

Close barfirstkotins
Deallocate barfirstkotins





---changes 27.02.2014


USE [elanza]
GO
/****** Object:  Trigger [dbo].[Insert_Adjust_barraise]    Script Date: 27/02/2024 11:15:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[Insert_Adjust_barraise] ON [dbo].[Trans_Bar_StockAdjustmentdet]
FOR INSERT
AS
declare @itemid integer
declare @adjid integer
declare @qty numeric(12,2)
declare @addorless  varchar(2)
declare @storeorbar varchar(2),@billdetid bigint
declare @retqty numeric(12,2),@kotno as varchar(25),@cnt bigint
declare @enablebarcounterbasedkotbillinward bigint,@counterid bigint,@ml numeric(12,2),@beer bigint=0,@other bigint=0

set @beer = (select g.beeritems from Stock_itemmmas s inner join itemgroup g on g.Itemgroupid=s.Itemgroupid
 where s.Itemid=@itemid)
set @other = (select g.otheritems from Stock_itemmmas s inner join itemgroup g on g.Itemgroupid=s.Itemgroupid
 where s.Itemid=@itemid)
declare barfirstins cursor for select itemid,qty,Adjid,addorless,billdetid,retqty,kotno from inserted ins
Open barfirstins
Fetch next from barfirstins into @itemid,@qty,@adjid,@addorless,@billdetid,@retqty,@kotno

While @@Fetch_Status=0
begin
      select @ml = (Select mlperbottle from Stock_itemmmas where Itemid=@itemid)
     select @enablebarcounterbasedkotbillinward = (Select isnull(enablebarcounterbasedkotbillinward,0) as
	  enablebarcounterbasedkotbillinward from application_settings)
     Select @storeorbar=baroorstore,@counterid=counterid from trans_bar_stockadjustmentmas where adjid=@adjid
     if   @Storeorbar='B' 
      begin
             if @addorless='+'
 		     begin
	                     
	               if @billdetid >0 
	               begin
	                  if substring(@kotno,1,1)='K'
						  begin
						  update trans_barkotbillraise_det set brqty = isnull(brqty,0) + @retqty where billdetid=@billdetid
						  end
	                  else if substring(@kotno,1,1)='S'
						  begin
						  update trans_barkotbillraise1_det set brqty = isnull(brqty,0) + @retqty where billdetid=@billdetid
						  end
	               end
	               else
					   begin	
						  
						   if(@beer = 0 or @other =0)
							begin
								Update Stock_itemmmas Set BarStockqty= ISNULL(BarStockqty,0) + (isnull(@qty,0)),BarAdjQty =ISNULL(BarAdjQty,0)  + (isnull(@qty,0))  where itemid=@itemid
							end
						   else
							begin
								Update Stock_itemmmas Set BarStockqty= ISNULL(BarStockqty,0) + (isnull(@qty,0)*@ml),BarAdjQty =ISNULL(BarAdjQty,0)  + (isnull(@qty,0)*@ml)  where itemid=@itemid
							end

					      
					   end
		     end
	        if @addorless='-'
 		     begin
 		     
 		     		      
						   if(@beer = 0 or @other =0)
							begin
							
								 Update Stock_itemmmas Set BarStockqty= ISNULL(BarStockqty,0) - (isnull(@qty,0)),BarAdjQty =ISNULL(BarAdjQty,0)  - (isnull(@qty,0))  where itemid=@itemid
							end
						   else
							begin
								 Update Stock_itemmmas Set BarStockqty= ISNULL(BarStockqty,0) - (isnull(@qty,0)*@ml),BarAdjQty =ISNULL(BarAdjQty,0)  - (isnull(@qty,0)*@ml)  where itemid=@itemid
							end
	                      

		     end
    end
         if   @Storeorbar='S' 
      begin
                     if @addorless='+'
 		     begin
	                     Update Stock_itemmmas Set StoreStockqty= ISNULL(StoreStockqty,0) + (isnull(@qty,0)*@ml),StoreAdjQty =ISNULL(StoreAdjQty,0)  + (isnull(@qty,0)*@ml)  where itemid=@itemid
		     end
	        if @addorless='-'
 		     begin
	                       Update Stock_itemmmas Set StoreStockqty= ISNULL(StoreStockqty,0) - (isnull(@qty,0)*@ml),StoreAdjQty =ISNULL(StoreAdjQty,0) - (isnull(@qty,0)*@ml)  where itemid=@itemid

		     end
    end
    

Fetch next from barfirstins into @itemid,@qty,@adjid,@addorless,@billdetid,@retqty,@kotno
end
Close barfirstins
Deallocate barfirstins




--- stockitemmas storestock qty ml to count changes


USE [elanza]
GO
/****** Object:  Trigger [dbo].[Insert_Stock_barraise]    Script Date: 27/02/2024 12:50:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[Insert_Stock_barraise] ON [dbo].[Trans_Bar_purchaseDet]
FOR INSERT
AS
declare @itemid integer
declare @purqty numeric(12,2)
declare @spurqty numeric(12,2)
declare @ml numeric(12,2)
declare c1 cursor for select itemid,purqty,spurqty from inserted ins
Open c1
Fetch next from c1 into @itemid,@purqty,@spurqty
While @@Fetch_Status=0
begin

set @ml = (select mlperbottle from Stock_itemmmas where itemid=@itemid)

  Update Stock_itemmmas Set Storepurqty=isnull(Storepurqty,0) + (@Purqty) ,StoreStockqty=isnull(storeStockqty,0) + (@Purqty) where itemid=@itemid
  Update stock_itemmmas Set SStorepurqty=isnull(SStorepurqty,0) + (@sPurqty),SStoreStockqty=isnull(SstoreStockqty,0) + (@sPurqty)  where itemid=@itemid --and itemgroupid<>8

 -- Update Stock_itemmmas Set Storepurqty=Storepurqty + @Purqty,StoreStockqty=storeStockqty + @Purqty,SStorepurqty=SStorepurqty + @sPurqty,SStoreStockqty=SstoreStockqty + @sPurqty  where itemid=@itemid
  Fetch next from c1 into @itemid,@purqty,@spurqty
end

Close c1
Deallocate c1


USE [elanza]
GO
/****** Object:  Trigger [dbo].[Insert_Adjust_barraise]    Script Date: 27/02/2024 12:54:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[Insert_Adjust_barraise] ON [dbo].[Trans_Bar_StockAdjustmentdet]
FOR INSERT
AS
declare @itemid integer
declare @adjid integer
declare @qty numeric(12,2)
declare @addorless  varchar(2)
declare @storeorbar varchar(2),@billdetid bigint
declare @retqty numeric(12,2),@kotno as varchar(25),@cnt bigint
declare @enablebarcounterbasedkotbillinward bigint,@counterid bigint,@ml numeric(12,2),@beer bigint=0,@other bigint=0

set @beer = (select g.beeritems from Stock_itemmmas s inner join itemgroup g on g.Itemgroupid=s.Itemgroupid
 where s.Itemid=@itemid)
set @other = (select g.otheritems from Stock_itemmmas s inner join itemgroup g on g.Itemgroupid=s.Itemgroupid
 where s.Itemid=@itemid)
declare barfirstins cursor for select itemid,qty,Adjid,addorless,billdetid,retqty,kotno from inserted ins
Open barfirstins
Fetch next from barfirstins into @itemid,@qty,@adjid,@addorless,@billdetid,@retqty,@kotno

While @@Fetch_Status=0
begin
      select @ml = (Select mlperbottle from Stock_itemmmas where Itemid=@itemid)
     select @enablebarcounterbasedkotbillinward = (Select isnull(enablebarcounterbasedkotbillinward,0) as
	  enablebarcounterbasedkotbillinward from application_settings)
     Select @storeorbar=baroorstore,@counterid=counterid from trans_bar_stockadjustmentmas where adjid=@adjid
     if   @Storeorbar='B' 
      begin
             if @addorless='+'
 		     begin
	                     
	               if @billdetid >0 
	               begin
	                  if substring(@kotno,1,1)='K'
						  begin
						  update trans_barkotbillraise_det set brqty = isnull(brqty,0) + @retqty where billdetid=@billdetid
						  end
	                  else if substring(@kotno,1,1)='S'
						  begin
						  update trans_barkotbillraise1_det set brqty = isnull(brqty,0) + @retqty where billdetid=@billdetid
						  end
	               end
	               else
					   begin	
						  
						   if(@beer = 0 or @other =0)
							begin
								Update Stock_itemmmas Set BarStockqty= ISNULL(BarStockqty,0) + (isnull(@qty,0)),BarAdjQty =ISNULL(BarAdjQty,0)  + (isnull(@qty,0))  where itemid=@itemid
							end
						   else
							begin
								Update Stock_itemmmas Set BarStockqty= ISNULL(BarStockqty,0) + (isnull(@qty,0)*@ml),BarAdjQty =ISNULL(BarAdjQty,0)  + (isnull(@qty,0)*@ml)  where itemid=@itemid
							end

					      
					   end
		     end
	        if @addorless='-'
 		     begin
 		     
 		     		      
						   if(@beer = 0 or @other =0)
							begin
							
								 Update Stock_itemmmas Set BarStockqty= ISNULL(BarStockqty,0) - (isnull(@qty,0)),BarAdjQty =ISNULL(BarAdjQty,0)  - (isnull(@qty,0))  where itemid=@itemid
							end
						   else
							begin
								 Update Stock_itemmmas Set BarStockqty= ISNULL(BarStockqty,0) - (isnull(@qty,0)*@ml),BarAdjQty =ISNULL(BarAdjQty,0)  - (isnull(@qty,0)*@ml)  where itemid=@itemid
							end
	                      

		     end
    end
         if   @Storeorbar='S' 
      begin
                     if @addorless='+'
 		     begin
	                     Update Stock_itemmmas Set StoreStockqty= ISNULL(StoreStockqty,0) + (isnull(@qty,0)),StoreAdjQty =ISNULL(StoreAdjQty,0)  + (isnull(@qty,0))  where itemid=@itemid
		     end
	        if @addorless='-'
 		     begin
	                       Update Stock_itemmmas Set StoreStockqty= ISNULL(StoreStockqty,0) - (isnull(@qty,0)),StoreAdjQty =ISNULL(StoreAdjQty,0) - (isnull(@qty,0))  where itemid=@itemid

		     end
    end
    

Fetch next from barfirstins into @itemid,@qty,@adjid,@addorless,@billdetid,@retqty,@kotno
end
Close barfirstins
Deallocate barfirstins



USE [elanza]
GO
/****** Object:  Trigger [dbo].[Insert_BarStock_Inward]    Script Date: 27/02/2024 13:10:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[Insert_BarStock_Inward] ON [dbo].[Trans_Bar_Inwarddet]
FOR INSERT
AS
declare @itemid integer
declare @Qty  NUMERIC(14,3)
declare @Qtybtl NUMERIC(14,3),@counterid bigint,@barinwid bigint,@cnt bigint
declare @enablebarcounterbasedkotbillinward bigint,@restypeid bigint
declare barinw cursor for select qty ,itemid,qtybtl,inwid from inserted ins
Open barinw
Fetch next from barinw into @Qty,@itemid,@qtybtl,@barinwid
While @@Fetch_Status=0
begin
   
   select @enablebarcounterbasedkotbillinward = (Select isnull(enablebarcounterbasedkotbillinward,0) as enablebarcounterbasedkotbillinward from application_settings)
   
   if @enablebarcounterbasedkotbillinward >0
   begin
	   select @counterid = (select counterid from trans_bar_inwardmas where inwid = @barinwid)
	   select @restypeid = (select restypeid from trans_bar_inwardmas where inwid = @barinwid)
	   select @cnt = (select count(*) ccnt from stock_itemmmas_counter where 
	   storeitemid = @itemid and counterid = @counterid)
	   if @cnt=0
	   begin
	     if @counterid >0
	     begin
		   insert into stock_itemmmas_counter(storeitemid,barstockqty,counterid)values(@itemid,@qty,@counterid)
		 end
	   end
	   else
	   begin
	     if @counterid > 0
	     begin
		    Update stock_itemmmas_counter Set BarStockqty=isnull(BarStockqty,0) +@qty where storeitemid=@itemid and counterid=@counterid
		 end
	   end
   end
   if @restypeid >0
   begin   
     Update Stock_itemmmas Set
	  StoreStockqty = isnull(StoreStockqty,0)  - @qty where itemid=@itemid
   end
   else
   begin
      Update Stock_itemmmas Set BarStockqty=isnull(BarStockqty,0) +@qty ,
	  StoreStockqty = isnull(StoreStockqty,0)  - @qtybtl,
	  -- barissueqty=isnull(StoreStockqty,0)  - @qtybtl
	  barissueqty=@qty
	   where itemid=@itemid
   end

Fetch next from barinw into @Qty,@itemid,@qtybtl,@barinwid
end

Close barinw
Deallocate barinw


---changes 28.2.2024


ALTER PROCEDURE [dbo].[EXEC_INWARD_MAS]
@ENTRYNO VARCHAR(50), @ENTRYDATE DATETIME, @REMARKS VARCHAR(100),@ID BIGINT=0

AS

IF(@ID=0)
	BEGIN
		INSERT INTO trans_bar_inwardmas(ENTRYNO,ENTRYDATE,Remarks,yearprefix) VALUES(@ENTRYNO,@ENTRYDATE,@REMARKS,concat(substring(convert(varchar,YEAR(GETDATE())),3,4),'-',substring(convert(varchar,YEAR(GETDATE())+1),3,4)))
		SELECT 'SAVED' AS MGS, ident_current('Trans_bar_inwardmas') as id 
	END 

ELSE
	BEGIN
		UPDATE trans_bar_inwardmas SET ENTRYNO=@ENTRYNO,ENTRYDATE=@ENTRYDATE,Remarks=@REMARKS WHERE Inwid=@ID
		SELECT 'UPDATED' AS MGS, @ID as id
	END


	

	
ALTER PROCEDURE [dbo].[EXEC_PIURCHASE_MAS]
@ENTRYNO VARCHAR(50), @ENTRYDATE DATETIME, @INVO VARCHAR(100),@INVDATE DATETIME,@SUPPELIERID BIGINT,
@AMOUNT NUMERIC(12,2),@ID BIGINT=0

AS

IF(@ID=0)
	BEGIN
		INSERT INTO trans_bar_purchasemas(ENTRYNO,ENTRYDATE,INVNO,INVDATE,SUPPLIERID,TOTALAMOUNT,yearprefix)
		 VALUES(@ENTRYNO,@ENTRYDATE,@INVO,@INVDATE,@SUPPELIERID,@AMOUNT,concat(substring(convert(varchar,YEAR(GETDATE())),3,4),'-',substring(convert(varchar,YEAR(GETDATE())+1),3,4)))
		SELECT 'SAVED' AS MGS, ident_current('Trans_bar_purchasemas') as id 
	END 

ELSE
	BEGIN
		UPDATE trans_bar_purchasemas SET ENTRYNO=@ENTRYNO,ENTRYDATE=@ENTRYDATE,INVNO=@INVO,INVDATE=@INVDATE,SUPPLIERID=@SUPPELIERID,TOTALAMOUNT=@AMOUNT WHERE PURID=@ID
		SELECT 'UPDATED' AS MGS, @ID as id
	END




USE [elanza]
GO
/****** Object:  StoredProcedure [dbo].[EXEC_PURCHASE_DET]    Script Date: 29/02/2024 10:05:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




ALTER PROCEDURE [dbo].[EXEC_PURCHASE_DET]
@PURID BIGINT, @ITEMID BIGINT,@CASES VARCHAR(10),@PURQTY BIGINT, 
@RATE NUMERIC(12,2),@ADDED NUMERIC(12,2)=0.00,@AMOUNT NUMERIC(12,2),@edit bigint =0,@totalqty numeric(12,2)

AS


--IF(@edit =1 )
--	BEGIN
--		DELETE FROM TRANS_BAR_PURCHASEDET WHERE PURID=@PURID
--	END

declare @ml numeric(12,2)
set @ml=(select mlperbottle from Stock_itemmmas where itemid=@ITEMID)
INSERT INTO TRANS_BAR_PURCHASEDET (PURID,ITEMID,CASES,PURQTY,RATE,ADDED,AMOUNT,totalqty,stkrate)
VALUES(@PURID,@ITEMID,@CASES,@totalqty,@RATE,@ADDED,@AMOUNT,@PURQTY,@AMOUNT/@ml)


update Stock_itemmmas set sTKRATE=@AMOUNT/@ml where Itemid=@ITEMID

SELECT 'SUCCESS' AS MGS


USE [elanza]
GO
/****** Object:  StoredProcedure [dbo].[datapurging]    Script Date: 29/02/2024 12:47:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[datapurging]
@key varchar(20)
AS

if(@key='MASTER')
	BEGin
		 truncate table Bar_itemmmas
		 truncate table bar_itemdet_id
		 truncate table Employee
		 truncate table mas_fire
		 truncate table Itemcategory
		 truncate table Itemgroup
		 truncate table Barmltype
		 truncate table Mas_nckottype
		 truncate table Mas_nckotaccount
		 truncate table Stock_itemmmas
		 truncate table Supplier
		 truncate table Table_Group
		 truncate table Tablemas
		 truncate table taxsetupmas
		 truncate table taxsetupdet
		 truncate table taxsetupacdet
		 truncate table taxtype

	END

if(@key='Transaction')
	BEGIN
		truncate table Trans_Bar_InwardMas
		truncate table Trans_Bar_Inwarddet
		truncate table trans_bar_purchasemas
		truncate table Trans_bar_purchasedet
		truncate table Trans_BarStoreopening_mas
		truncate table Trans_BarStoreopening_det
		truncate table trans_bar_stockadjustmentdet
		truncate table trans_bar_stockadjustmentmas
		truncate table Trans_BARKot_det
		truncate table Trans_BARKot1_det
		truncate table Trans_BARKot_mas
		truncate table Trans_BARKot1_mas
		truncate table Trans_BARKotdet_id
		update tablemas set status='S'
		truncate table Trans_BARKotSettlement_mas
		truncate table Trans_BARKotSettlement1_det
		truncate table Trans_BARKotSettlement_det
		truncate table temp_settlement
		truncate table Trans_BARKotBillraise_mas
		truncate table Trans_BARKotBillraise_det
		update Stock_itemmmas set BarStockqty=0,BariSsueqty=0,StoreStockqty=0,StorePurqty=0,BarSalqty=0,storeopstock=0,StoreAdjQty=0,Baropstock=0,BarAdjQty=0,sTKRATE=0
		truncate table trans_barkotcancel_mas 
		truncate table trans_barkotcancel_det
		truncate table trans_barkotcanceldet_id
		truncate table trans_barkotcancel1_mas 
		truncate table trans_barkotcancel1_det
		truncate table  trans_barkotcanceldet1_id
        truncate table trans_barkotsettlement_mas_Log
		truncate table  trans_barkotsettlement1_det_log
		truncate table  trans_barkotsettlement_Det_Log 
		truncate table trans_barkotsettlement1_mas_Log
		truncate table  trans_barkotsettlement3_det_log
		truncate table  trans_barkotsettlement2_Det_Log
		truncate table stock_itemmmas_Log
		truncate table bar_itemmmas_Log
		truncate table bar_Itemdet_id_Log
		truncate table Trans_BarKot_Edit
		truncate table Trans_BARKot_det_log


	END





USE [elanza]
GO
/****** Object:  Trigger [dbo].[Insert_Adjust_barraise]    Script Date: 29/02/2024 16:33:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[Insert_Adjust_barraise] ON [dbo].[Trans_Bar_StockAdjustmentdet]
FOR INSERT
AS
declare @itemid integer
declare @adjid integer
declare @qty numeric(12,2)
declare @addorless  varchar(2)
declare @storeorbar varchar(2),@billdetid bigint
declare @retqty numeric(12,2),@kotno as varchar(25),@cnt bigint
declare @enablebarcounterbasedkotbillinward bigint,@counterid bigint,@ml numeric(12,2),@beer bigint=0,@other bigint=0


declare barfirstins cursor for select itemid,qty,Adjid,addorless,billdetid,retqty,kotno from inserted ins
Open barfirstins
Fetch next from barfirstins into @itemid,@qty,@adjid,@addorless,@billdetid,@retqty,@kotno

While @@Fetch_Status=0
begin
      select @ml = (Select mlperbottle from Stock_itemmmas where Itemid=@itemid)
     select @enablebarcounterbasedkotbillinward = (Select isnull(enablebarcounterbasedkotbillinward,0) as
	  enablebarcounterbasedkotbillinward from application_settings)
	  select @beer=g.beeritems, @other=g.otheritems from Stock_itemmmas s inner join itemgroup g on g.Itemgroupid=s.Itemgroupid where s.Itemid=@itemid

     Select @storeorbar=baroorstore,@counterid=counterid from trans_bar_stockadjustmentmas where adjid=@adjid
     if   @Storeorbar='B' 
      begin
             if @addorless='+'
 		     begin
			  select @beer=g.beeritems, @other=g.otheritems from Stock_itemmmas s
			   inner join itemgroup g on g.Itemgroupid=s.Itemgroupid where s.Itemid=@itemid

	                    
						   if(@beer = 1 or @other = 1)
						        begin
								Update Stock_itemmmas Set BarStockqty= ISNULL(BarStockqty,0) + (isnull(@qty,0)*@ml),
								BarAdjQty =ISNULL(BarAdjQty,0)  + (isnull(@qty,0)*@ml)  where itemid=@itemid
									
								end
						
						   else
						      begin
							  Update Stock_itemmmas Set BarStockqty= ISNULL(BarStockqty,0) + (isnull(@qty,0)),
									BarAdjQty =ISNULL(BarAdjQty,0)  + (isnull(@qty,0))  where itemid=@itemid
								
							end
							

					     
		     end
	        if @addorless='-'
 		     begin
 		     
 		     		      
						   if(@beer = 1 or @other = 1)
						
							Update Stock_itemmmas Set BarStockqty= ISNULL(BarStockqty,0) - (isnull(@qty,0)*@ml),BarAdjQty =ISNULL(BarAdjQty,0)  - (isnull(@qty,0)*@ml)  where itemid=@itemid
						
							
						   else
						    Update Stock_itemmmas Set BarStockqty= ISNULL(BarStockqty,0) - (isnull(@qty,0)),BarAdjQty =ISNULL(BarAdjQty,0)  - (isnull(@qty,0))  where itemid=@itemid
						
							
							 
	                      

		     end
    end
         if   @Storeorbar='S' 
      begin
                     if @addorless='+'
 		     begin
	                     Update Stock_itemmmas Set StoreStockqty= ISNULL(StoreStockqty,0) + (isnull(@qty,0)),StoreAdjQty =ISNULL(StoreAdjQty,0)  + (isnull(@qty,0))  where itemid=@itemid
		     end
	        if @addorless='-'
 		     begin
	                       Update Stock_itemmmas Set StoreStockqty= ISNULL(StoreStockqty,0) - (isnull(@qty,0)),StoreAdjQty =ISNULL(StoreAdjQty,0) - (isnull(@qty,0))  where itemid=@itemid

		     end
    end
    

Fetch next from barfirstins into @itemid,@qty,@adjid,@addorless,@billdetid,@retqty,@kotno
end
Close barfirstins
Deallocate barfirstins

USE [elanza]
GO
/****** Object:  Trigger [dbo].[Insert_KOTBAR_barraise]    Script Date: 29/02/2024 16:34:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[Insert_KOTBAR_barraise] ON [dbo].[Trans_BarKotdet_id]
FOR INSERT
AS
declare @Refbarid integer
declare @storeitemid integer
declare @num float
declare @qty integer,@tmpiscocktail as varchar(25),@counterid bigint,@kotid bigint,@ml numeric(12,2),@beer bigint=0,@other bigint=0

declare barfirstkotins cursor for select Refkotdetid,storeitemid,qty from inserted ins
Open barfirstkotins
Fetch next from barfirstkotins into @Refbarid,@storeitemid,@qty
While @@Fetch_Status=0
begin

    set @num = (select qty from Trans_barkot_det where kotdetid=@Refbarid)
    set @tmpiscocktail = (select iscocktail from Trans_barkot_det where kotdetid=@Refbarid)
    select @kotid = (select kotid from trans_barkot_det where kotdetid = @refbarid)
    select @counterid = (Select isnull(counterid,0) as counterid from trans_barkot_mas where kotid=@kotid)
   select @ml = (Select s.mlperbottle from Stock_itemmmas s inner join itemgroup itm on itm.itemgroupid=s.Itemgroupid 
   where Itemid=@storeitemid)
   select @beer = (Select itm.beeritems from Stock_itemmmas s inner join itemgroup itm on itm.itemgroupid=s.Itemgroupid 
   where Itemid=@storeitemid)
    select @other = (Select itm.otheritems from Stock_itemmmas s inner join itemgroup itm on itm.itemgroupid=s.Itemgroupid 
   where Itemid=@storeitemid)

   if (@beer = 1 or @other = 1)
   begin
	set @num = @num * @ml
   end
    if @tmpiscocktail <> 'D'
    begin
        if @counterid > 0
        begin
		 -- Update Stock_itemmmas_counter Set Barstockqty=ISNULL(Barstockqty,0) -( @qty ),barsalqty=ISNULL(barsalqty,0) + ( @qty)  where storeitemid=@storeitemid and ISNULL(Barstockqty,0)>0 and counterid =@counterid
		  
         Update Stock_itemmmas_counter Set Barstockqty=ISNULL(Barstockqty,0) -(@num* @qty ),barsalqty=ISNULL(barsalqty,0) + (@num* @qty)  where storeitemid=@storeitemid and ISNULL(Barstockqty,0)>0 and counterid =@counterid
		  -- Update Stock_itemmmas_counter Set Barstockqty=ISNULL(Barstockqty,0) -(@ml* @qty ),barsalqty=ISNULL(barsalqty,0) + (@ml* @qty)  where storeitemid=@storeitemid and ISNULL(Barstockqty,0)>0 and counterid =@counterid
        end

		        --Update Stock_itemmmas Set Barstockqty=ISNULL(Barstockqty,0) -( @qty ),barsalqty=ISNULL(barsalqty,0) + ( @qty)  where itemid=@storeitemid and ISNULL(Barstockqty,0)>0
       Update Stock_itemmmas Set Barstockqty=ISNULL(Barstockqty,0) -(@num* @qty ),barsalqty=ISNULL(barsalqty,0) + (@num* @qty)  where itemid=@storeitemid and ISNULL(Barstockqty,0)>0
		---Update Stock_itemmmas Set Barstockqty=ISNULL(Barstockqty,0) -(@ml* @qty ),barsalqty=ISNULL(barsalqty,0) + (@ml* @qty)  where itemid=@storeitemid and ISNULL(Barstockqty,0)>0
    end

    Fetch next from barfirstkotins into @Refbarid,@storeitemid,@qty
end

Close barfirstkotins
Deallocate barfirstkotins


USE [elanza]
GO
/****** Object:  Trigger [dbo].[Del_KOTBAR_barraise]    Script Date: 29/02/2024 16:34:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[Del_KOTBAR_barraise] ON [dbo].[Trans_BarKotdet_id]
FOR delete
AS
declare @Refbarid integer
declare @storeitemid integer
declare @num float
declare @qty integer,@tmpiscocktail as varchar(25),@counterid bigint,@kotid bigint,@ml numeric(12,2),@beer bigint=0,@other bigint=0

declare barfirstkotupd cursor for select Refkotdetid,storeitemid,qty from deleted ins
Open barfirstkotupd
Fetch next from barfirstkotupd into @Refbarid,@storeitemid,@qty
While @@Fetch_Status=0
begin

    set @num = (select qty from Trans_barkot_det where kotdetid=@Refbarid)
    select @kotid = (select kotid from trans_barkot_det where kotdetid = @refbarid)
    select @counterid = (Select isnull(counterid,0) as counterid from trans_barkot_mas where kotid=@kotid)   
       
    set @tmpiscocktail = (select iscocktail from Trans_barkot_det where kotdetid=@Refbarid)
    
	   select @ml = (Select s.mlperbottle from Stock_itemmmas s inner join itemgroup itm on itm.itemgroupid=s.Itemgroupid 
   where Itemid=@storeitemid)
   select @beer = (Select itm.beeritems from Stock_itemmmas s inner join itemgroup itm on itm.itemgroupid=s.Itemgroupid 
   where Itemid=@storeitemid)
    select @other = (Select itm.otheritems from Stock_itemmmas s inner join itemgroup itm on itm.itemgroupid=s.Itemgroupid 
   where Itemid=@storeitemid)

   if (@beer = 1 or @other = 1)
   begin
	set @num = @num * @ml
   end
    if @tmpiscocktail <> 'D'
    begin
       if @counterid > 0
       begin
	   -- Update Stock_itemmmas_counter Set Barstockqty=Barstockqty +( @qty ),
		-- barsalqty=barsalqty - ( @qty)  where storeitemid=@storeitemid and counterid = @counterid
         Update Stock_itemmmas_counter Set Barstockqty=Barstockqty +(@num* @qty ),barsalqty=barsalqty - (@num* @qty)  where storeitemid=@storeitemid and counterid = @counterid
		-- Update Stock_itemmmas_counter Set Barstockqty=Barstockqty +(@ml* @qty ),barsalqty=barsalqty - (@ml* @qty)  where storeitemid=@storeitemid and counterid = @counterid
       end
       Update Stock_itemmmas Set Barstockqty=Barstockqty +( @num*@qty ),barsalqty=barsalqty - ( @num*@qty)  where itemid=@storeitemid
	    --Update Stock_itemmmas Set Barstockqty=Barstockqty +(@ml* @qty ),barsalqty=barsalqty - (@ml* @qty)  where itemid=@storeitemid
    end

    Fetch next from barfirstkotupd into @Refbarid,@storeitemid,@qty
end

Close barfirstkotupd
Deallocate barfirstkotupd


------------------ new changes elanza 29.02.2024

GO
alter table Stock_itemmmas alter column itemname varchar(2000)


ALTER PROCEDURE [dbo].[EXEC_ADJUSTMENT_DET]
@Adjid BIGINT, @Itemid BIGINT,@Qty BIGINT,@computerstock numeric(12,2),@physicalstock numeric(12,2),@mltype numeric(12,2),@remarkcol varchar(2000)

AS

declare @addorless varchar(2)

if(@Qty < 0)
	begin
		set @addorless = '-'
	end
else
	begin
		set @addorless = '+'
	end
INSERT INTO trans_bar_stockadjustmentdet(adjid,ITEMID,QTY,computerstock,physicalstock,mltype,addorless,remarks)
VALUES(@Adjid,@Itemid,abs(@Qty),@computerstock,@physicalstock,@mltype,@addorless,@remarkcol)

SELECT 'SUCCESS' AS MGS


alter table application_settings add enablerepeater bigint


alter table application_settings add enableshooter bigint




---changes on 01.03.2024

alter PROCEDURE [dbo].[EXEC_ADJUSTMENT_DET1]
@Adjid BIGINT, @Itemid BIGINT,@Qty BIGINT,@computerstock numeric(12,2),
@physicalstock numeric(12,2),@mltype numeric(12,2),@remarkcol varchar(2000),@addorless varchar(10)

AS


INSERT INTO trans_bar_stockadjustmentdet(adjid,ITEMID,QTY,computerstock,physicalstock,mltype,addorless,remarks)
VALUES(@Adjid,@Itemid,abs(@Qty),@computerstock,@physicalstock,@mltype,@addorless,@remarkcol)

SELECT 'SUCCESS' AS MGS





--changes on 02.03.2024

USE [elanza]
GO
/****** Object:  StoredProcedure [dbo].[kot__save__one]    Script Date: 02/03/2024 10:17:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[kot__save__one]
@tableid bigint,@counter bigint, @sessionid bigint, @tokenno bigint,@noofpax bigint,@Employee varchar(100)
As

declare @maskotcoout bigint=0
declare @qty bigint ,@part varchar(100),@itemid bigint ,@tqty bigint,@trat numeric(12,2),
@tamt numeric(12,2), @bool bigint=0,
@iscoktail varchar(2),@storeitemid bigint,@kotid bigint,@splinstruction varchar(1000),@kitmsg varchar(1000),
@nccoversion varchar(1000),
@Tamt1 numeric(12,2), @sum11 numeric(12,2)=0,@ncreson varchar(1000),@Employeeid bigint,@billid bigint,@mlqty bigint,
@nc bigint, @nctypeid bigint, @ncaccid bigint,@amt numeric(12,2),@rate numeric(12,2),@nckotaccounttype bigint,@nctype bigint
set @sum11=0
set @sum11=0
set @amt=0

set @maskotcoout= (select count(*) from trans_barkot_mas)


declare kotitemsfetch170719 cursor for 

SELECT DISTINCT bid.qty ,tk2.part,tk2.Itemid,Tqty,tk2.TRat,Tamt,iscocktail,
tk2.storeitemid,Kot_Id,Splinstruction,KITMSG,tk2.NCconversionreson,bm.Mlqty,tk2.nckotaccounttype,tk2.nctype
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Stock_Itemmmas s on s.Itemid=tk2.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					inner join Barmltype bm on bm.Mlid=bid.mlid
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid
					--and isnull(tk2.Approved,0) =0
					 and  iscocktail <>'D'

open kotitemsfetch170719
set @maskotcoout= (select count(*) from trans_barkot_mas) 
set @billid= (select ident_current('Trans_BARKot_mas'))
		if(@billid >= 1 and @maskotcoout >0)
		BEGIN
			set @billid = @billid+1						
		END       

    FETCH NEXT FROM kotitemsfetch170719 INTO  @qty,@part,@itemid,@tqty,@trat,@tamt,@iscoktail,
	@storeitemid,@kotid,@splinstruction,@kitmsg,@nccoversion,@mlqty,@nckotaccounttype,@nctype
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool = 1
				
				IF(@nckotaccounttype=0)
					BEGIN
						set @nc=0
						set @nctypeid=0
						set @rate = @trat
						set @amt=@tamt
						set @ncaccid=0
					END
				ELSE
				    BEGIN
						set @nc=1
						set @nctypeid=@nctype
						set @rate = 0.00
						set @amt=0.00
						set @ncaccid=@nckotaccounttype
					END
				INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,storeitemid,
				qty1,added,tkotid,Splinstruction,KITCHENMSG,ncaccid,nckot,nctypeid)values(@part,@billid,@itemid,
				@tqty,@rate,@amt,@tableid,
				@iscoktail,@storeitemid,@tqty,0,@kotid,@splinstruction,@kitmsg,@nckotaccounttype,@nc,@nctypeid)
				INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,(@mlqty),ident_current('Trans_BARKot_det '))
				set	@Tamt1=@amt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
				
                    
                FETCH NEXT FROM kotitemsfetch170719 INTO @qty,@part,@itemid,@tqty,@trat,@tamt,@iscoktail,@storeitemid,
				@kotid,@splinstruction,@kitmsg,@nccoversion,@mlqty,@nckotaccounttype,@nctype
                END
                CLOSE kotitemsfetch170719
                DEALLOCATE kotitemsfetch170719


declare @baritemname varchar(500),@pax bigint, @sbarstockqty bigint,@icecreamorfood bigint,@otheritems bigint,@bool1 bigint
set @bool = 0

declare kotitemsfetch170720 cursor for 

SELECT DISTINCT btm.BarItemname,tk2.NCconversionreson,Splinstruction,KITMSG,tk2.Noofpax,iscocktail,tk2.TRat,
Kot_Id,Tqty,tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt,bm.Mlqty,tk2.nckotaccounttype,tk2.nctype
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					inner join Barmltype bm on bm.Mlid=bid.mlid
					INNER JOIN Stock_Itemmmas s on s.Itemid=bid.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 				
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid 
					and tk2.Approved ='1' 
					and iscocktail ='D'
					--and iscocktail ='Y'
					group by tk2.Itemid,btm.BarItemname,tk2.Noofpax,iscocktail,tk2.NCconversionreson,tk2.TRat,Kot_Id,Tqty,
					TableId,tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt,Tqty,Splinstruction,
					KITMSG,bm.Mlqty,tk2.nckotaccounttype,tk2.nctype

open kotitemsfetch170720        

set @maskotcoout= (select count(*) from trans_barkot_mas)
set @billid= (select ident_current('Trans_BARKot_mas'))
		if(@billid >1 and @maskotcoout >0)
		BEGIN
			set @billid = @billid+1						
		END
    FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg,@pax,
	@iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt,@mlqty,@nckotaccounttype,@nctype
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool1 = 1
				IF(@nckotaccounttype=0)
					BEGIN
						
						set @nc=0
						set @nctypeid=0
						set @rate = @trat
						set @amt=@tamt
						set @ncaccid=0
						
					END
				ELSE
				    BEGIN
					
					set @nc=1
						set @nctypeid=@nctype
						set @rate = 0.00
						set @amt=0.00
						set @ncaccid=@nckotaccounttype
						
						
					END
				
					INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,qty1,added,
					tkotid,Splinstruction,KITCHENMSG,storeitemid,nckot,ncaccid,nctypeid)values
					(@part,@billid,@itemid,@tqty,@rate,@amt,@tableid,@iscoktail,@tqty,0,@kotid,@splinstruction,
					@kitmsg,@storeitemid,@nc,@nckotaccounttype,@nctypeid ) 
					INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,(@mlqty),ident_current('Trans_BARKot_det '))

				
				

               set	@Tamt1=@amt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
                    
                FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg,@pax,
	            @iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt,@mlqty,@nckotaccounttype,@nctype
                END
                CLOSE kotitemsfetch170720
                DEALLOCATE kotitemsfetch170720

		
				
				
					
					
					
set @Employeeid = (select Employeeid from employee WHERE Employee=@Employee)

				

				
				
  INSERT INTO dbo.Trans_BARKot_mas(Refno,Raised,counterid,noofpax,part,tableid,Stwid,Kotno,Kotdate, 
  Kottime, totalamount, rOOMORTAB,Userid,sessionid,tokenno,NCconversionreson,nckot) 
  VALUES ('','0',@counter,@noofpax,@part,@tableid,@Employeeid,
  dbo.RotNo(),convert(VARCHAR,getdate(),101), convert(VARCHAR,getdate(),108), @sum11,'T',1,@sessionid,
 @tokenno,@ncreson,@nc) 





GO

ALTER PROCEDURE [dbo].[Get_Discount] @Fromdate DATETIME,@Todate DATETIME,@Billno VARCHAR(100)  as 
BEGIN  
select * from trans_barkotbillraise_mas a
inner join  tablemas m on m.tableid=a.tableid where a.Billdate BETWEEN @Fromdate AND @Todate and  a.discamount > 0
and  a.Billno = @Billno order by a.Billdate desc END





USE [elanzambar]
GO
/****** Object:  StoredProcedure [dbo].[datapurging]    Script Date: 02/03/2024 13:19:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[datapurging]
@key varchar(20)
AS

if(@key='MASTER')
	BEGin
		 truncate table Bar_itemmmas
		 truncate table bar_itemdet_id
		 truncate table Employee
		 truncate table mas_fire
		 truncate table Itemcategory
		 truncate table Itemgroup
		 truncate table Barmltype
		 truncate table Mas_nckottype
		 truncate table Mas_nckotaccount
		 truncate table Stock_itemmmas
		 truncate table Supplier
		 truncate table Table_Group
		 truncate table Tablemas
		 truncate table taxsetupmas
		 truncate table taxsetupdet
		 truncate table taxsetupacdet
		 truncate table taxtype

	END

if(@key='Transaction')
	BEGIN
		truncate table Trans_Bar_InwardMas
		truncate table Trans_Bar_Inwarddet
		truncate table trans_bar_purchasemas
		truncate table Trans_bar_purchasedet
		truncate table Trans_BarStoreopening_mas
		truncate table Trans_BarStoreopening_det
		truncate table trans_bar_stockadjustmentdet
		truncate table trans_bar_stockadjustmentmas
		truncate table Trans_BARKot_det
		truncate table Trans_BARKot1_det
		truncate table Trans_BARKot_mas
		truncate table Trans_BARKot1_mas
		truncate table Trans_BARKotdet_id
		update tablemas set status='S'
		truncate table Trans_BARKotSettlement_mas
		truncate table Trans_BARKotSettlement1_det
		truncate table Trans_BARKotSettlement_det
		truncate table temp_settlement
		truncate table Trans_BARKotBillraise_mas
		truncate table Trans_BARKotBillraise_det
		update Stock_itemmmas set BarStockqty=0,BariSsueqty=0,StoreStockqty=0,StorePurqty=0,BarSalqty=0,storeopstock=0,StoreAdjQty=0,Baropstock=0,BarAdjQty=0,sTKRATE=0
		truncate table trans_barkotcancel_mas 
		truncate table trans_barkotcancel_det
		truncate table trans_barkotcanceldet_id
		truncate table trans_barkotcancel1_mas 
		truncate table trans_barkotcancel1_det
		truncate table  trans_barkotcanceldet1_id
        truncate table trans_barkotsettlement_mas_Log
		truncate table  trans_barkotsettlement1_det_log
		truncate table  trans_barkotsettlement_Det_Log 
		truncate table trans_barkotsettlement1_mas_Log
		truncate table  trans_barkotsettlement3_det_log
		truncate table  trans_barkotsettlement2_Det_Log
		truncate table stock_itemmmas_Log
		truncate table bar_itemmmas_Log
		truncate table bar_Itemdet_id_Log
		truncate table Trans_BarKot_Edit
		truncate table Trans_BARKot_det_log
		truncate table trans_barkotbilltax_det


	END



USE [elanzambar]
GO
/****** Object:  StoredProcedure [dbo].[kot__save__one]    Script Date: 02/03/2024 13:30:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[kot__save__one]
@tableid bigint,@counter bigint, @sessionid bigint, @tokenno bigint,@noofpax bigint,@Employee varchar(100)
As

declare @maskotcoout bigint=0
declare @qty bigint ,@part varchar(100),@itemid bigint ,@tqty bigint,@trat numeric(12,2),
@tamt numeric(12,2), @bool bigint=0,
@iscoktail varchar(2),@storeitemid bigint,@kotid bigint,@splinstruction varchar(1000),@kitmsg varchar(1000),
@nccoversion varchar(1000),
@Tamt1 numeric(12,2), @sum11 numeric(12,2)=0,@ncreson varchar(1000),@Employeeid bigint,@billid bigint,@mlqty bigint,
@nc bigint, @nctypeid bigint, @ncaccid bigint,@amt numeric(12,2),@rate numeric(12,2),@nckotaccounttype bigint,@nctype bigint
set @sum11=0
set @sum11=0
set @amt=0

set @maskotcoout= (select count(*) from trans_barkot_mas)


declare kotitemsfetch170719 cursor for 

SELECT DISTINCT bid.qty ,tk2.part,tk2.Itemid,Tqty,tk2.TRat,Tamt,iscocktail,
tk2.storeitemid,Kot_Id,Splinstruction,KITMSG,tk2.NCconversionreson,bm.Mlqty,tk2.nckotaccounttype,tk2.nctype
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Stock_Itemmmas s on s.Itemid=tk2.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					inner join Barmltype bm on bm.Mlid=bid.mlid
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid
					--and isnull(tk2.Approved,0) =0
					 and  iscocktail <>'D'

open kotitemsfetch170719
set @maskotcoout= (select count(*) from trans_barkot_mas) 
set @billid= (select ident_current('Trans_BARKot_mas'))
		if(@billid >= 1 and @maskotcoout >0)
		BEGIN
			set @billid = @billid+1						
		END       

    FETCH NEXT FROM kotitemsfetch170719 INTO  @qty,@part,@itemid,@tqty,@trat,@tamt,@iscoktail,
	@storeitemid,@kotid,@splinstruction,@kitmsg,@nccoversion,@mlqty,@nckotaccounttype,@nctype
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool = 1
				
				IF(@nckotaccounttype=0)
					BEGIN
						set @nc=0
						set @nctypeid=0
						set @rate = @trat
						set @amt=@tamt
						set @ncaccid=0
					END
				ELSE
				    BEGIN
						set @nc=1
						set @nctypeid=@nctype
						set @rate = 0.00
						set @amt=0.00
						set @ncaccid=@nckotaccounttype
					END
				INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,storeitemid,
				qty1,added,tkotid,Splinstruction,KITCHENMSG,ncaccid,nckot,nctypeid)values(@part,@billid,@itemid,
				@tqty,@rate,@amt,@tableid,
				@iscoktail,@storeitemid,@tqty,0,@kotid,@splinstruction,@kitmsg,@nckotaccounttype,@nc,@nctypeid)
				INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,(@mlqty),
				ident_current('Trans_BARKot_det '))
				set	@Tamt1=@amt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
				
                    
                FETCH NEXT FROM kotitemsfetch170719 INTO @qty,@part,@itemid,@tqty,@trat,@tamt,@iscoktail,@storeitemid,
				@kotid,@splinstruction,@kitmsg,@nccoversion,@mlqty,@nckotaccounttype,@nctype
                END
                CLOSE kotitemsfetch170719
                DEALLOCATE kotitemsfetch170719


declare @baritemname varchar(500),@pax bigint, @sbarstockqty bigint,@icecreamorfood bigint,@otheritems bigint,@bool1 bigint
set @bool = 0

declare kotitemsfetch170720 cursor for 

SELECT DISTINCT btm.BarItemname,tk2.NCconversionreson,Splinstruction,KITMSG,tk2.Noofpax,iscocktail,tk2.TRat,
Kot_Id,Tqty,tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt,bm.Mlqty,tk2.nckotaccounttype,tk2.nctype
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					inner join Barmltype bm on bm.Mlid=bid.mlid
					INNER JOIN Stock_Itemmmas s on s.Itemid=bid.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 				
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid 
					and tk2.Approved ='1' 
					and iscocktail ='D'
					--and iscocktail ='Y'
					group by tk2.Itemid,btm.BarItemname,tk2.Noofpax,iscocktail,tk2.NCconversionreson,tk2.TRat,Kot_Id,Tqty,
					TableId,tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt,Tqty,Splinstruction,
					KITMSG,bm.Mlqty,tk2.nckotaccounttype,tk2.nctype

open kotitemsfetch170720        

set @maskotcoout= (select count(*) from trans_barkot_mas)
set @billid= (select ident_current('Trans_BARKot_mas'))
		if(@billid >=1 and @maskotcoout >0)
		BEGIN
			set @billid = @billid+1						
		END
    FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg,@pax,
	@iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt,@mlqty,@nckotaccounttype,@nctype
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool1 = 1
				IF(@nckotaccounttype=0)
					BEGIN
						
						set @nc=0
						set @nctypeid=0
						set @rate = @trat
						set @amt=@tamt
						set @ncaccid=0
						
					END
				ELSE
				    BEGIN
					
					set @nc=1
						set @nctypeid=@nctype
						set @rate = 0.00
						set @amt=0.00
						set @ncaccid=@nckotaccounttype
						
						
					END
				
					INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,qty1,added,
					tkotid,Splinstruction,KITCHENMSG,storeitemid,nckot,ncaccid,nctypeid)values
					(@part,@billid,@itemid,@tqty,@rate,@amt,@tableid,@iscoktail,@tqty,0,@kotid,@splinstruction,
					@kitmsg,@storeitemid,@nc,@nckotaccounttype,@nctypeid ) 
					INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,(@mlqty),ident_current('Trans_BARKot_det '))

				
				

               set	@Tamt1=@amt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
                    
                FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg,@pax,
	            @iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt,@mlqty,@nckotaccounttype,@nctype
                END
                CLOSE kotitemsfetch170720
                DEALLOCATE kotitemsfetch170720

		
				
				
					
					
					
set @Employeeid = (select Employeeid from employee WHERE Employee=@Employee)

				

				
				
  INSERT INTO dbo.Trans_BARKot_mas(Refno,Raised,counterid,noofpax,part,tableid,Stwid,Kotno,Kotdate, 
  Kottime, totalamount, rOOMORTAB,Userid,sessionid,tokenno,NCconversionreson,nckot) 
  VALUES ('','0',@counter,@noofpax,@part,@tableid,@Employeeid,
  dbo.RotNo(),convert(VARCHAR,getdate(),101), convert(VARCHAR,getdate(),108), @sum11,'T',1,@sessionid,
 @tokenno,@ncreson,@nc) 






GO


USE [elanzambar]
GO
/****** Object:  StoredProcedure [dbo].[kot__save__one]    Script Date: 02/03/2024 16:34:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[kot__save__one]
@tableid bigint,@counter bigint, @sessionid bigint, @tokenno bigint,@noofpax bigint,@Employee varchar(100)
As

declare @maskotcoout bigint=0
declare @qty bigint ,@part varchar(100),@itemid bigint ,@tqty bigint,@trat numeric(12,2),
@tamt numeric(12,2), @bool bigint=0,
@iscoktail varchar(2),@storeitemid bigint,@kotid bigint,@splinstruction varchar(1000),@kitmsg varchar(1000),
@nccoversion varchar(1000),
@Tamt1 numeric(12,2), @sum11 numeric(12,2)=0,@ncreson varchar(1000),@Employeeid bigint,@billid bigint,@mlqty bigint,
@nc bigint, @nctypeid bigint, @ncaccid bigint,@amt numeric(12,2),@rate numeric(12,2),@nckotaccounttype bigint,@nctype bigint
set @sum11=0
set @sum11=0
set @amt=0

set @maskotcoout= (select count(*) from trans_barkot_mas)


declare kotitemsfetch170719 cursor for 

SELECT DISTINCT bid.qty ,tk2.part,tk2.Itemid,Tqty,tk2.TRat,Tamt,iscocktail,
tk2.storeitemid,Kot_Id,Splinstruction,KITMSG,tk2.NCconversionreson,bm.Mlqty,tk2.nckotaccounttype,tk2.nctype
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Stock_Itemmmas s on s.Itemid=tk2.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					inner join Barmltype bm on bm.Mlid=bid.mlid
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid
					--and isnull(tk2.Approved,0) =0
					 and  iscocktail <>'D'

open kotitemsfetch170719
set @maskotcoout= (select count(*) from trans_barkot_mas) 
set @billid= (select ident_current('Trans_BARKot_mas'))
		if(@billid >= 1 and @maskotcoout >0)
		BEGIN
			set @billid = @billid+1						
		END       

    FETCH NEXT FROM kotitemsfetch170719 INTO  @qty,@part,@itemid,@tqty,@trat,@tamt,@iscoktail,
	@storeitemid,@kotid,@splinstruction,@kitmsg,@nccoversion,@mlqty,@nckotaccounttype,@nctype
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool = 1
				
				IF(@nckotaccounttype=0)
					BEGIN
						set @nc=0
						set @nctypeid=0
						set @rate = @trat
						set @amt=@tamt
						set @ncaccid=0
					END
				ELSE
				    BEGIN
						set @nc=1
						set @nctypeid=@nctype
						set @rate = 0.00
						set @amt=0.00
						set @ncaccid=@nckotaccounttype
					END
				INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,storeitemid,
				qty1,added,tkotid,Splinstruction,KITCHENMSG,ncaccid,nckot,nctypeid)values(@part,@billid,@itemid,
				@tqty,@rate,@amt,@tableid,
				@iscoktail,@storeitemid,@tqty,0,@kotid,@splinstruction,@kitmsg,@nckotaccounttype,@nc,@nctypeid)
				INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,(@mlqty),
				ident_current('Trans_BARKot_det '))
				set	@Tamt1=@amt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
				
                    
                FETCH NEXT FROM kotitemsfetch170719 INTO @qty,@part,@itemid,@tqty,@trat,@tamt,@iscoktail,@storeitemid,
				@kotid,@splinstruction,@kitmsg,@nccoversion,@mlqty,@nckotaccounttype,@nctype
                END
                CLOSE kotitemsfetch170719
                DEALLOCATE kotitemsfetch170719


declare @baritemname varchar(500),@pax bigint, @sbarstockqty bigint,@icecreamorfood bigint,@otheritems bigint,@bool1 bigint
set @bool = 0

declare kotitemsfetch170720 cursor for 

SELECT DISTINCT btm.BarItemname,tk2.NCconversionreson,Splinstruction,KITMSG,tk2.Noofpax,iscocktail,tk2.TRat,
Kot_Id,Tqty,tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt,bm.Mlqty,tk2.nckotaccounttype,tk2.nctype
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					inner join Barmltype bm on bm.Mlid=bid.mlid
					INNER JOIN Stock_Itemmmas s on s.Itemid=bid.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 				
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid 
					and tk2.Approved ='1' 
					and iscocktail ='D'
					--and iscocktail ='Y'
					group by tk2.Itemid,btm.BarItemname,tk2.Noofpax,iscocktail,tk2.NCconversionreson,tk2.TRat,Kot_Id,Tqty,
					TableId,tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt,Tqty,Splinstruction,
					KITMSG,bm.Mlqty,tk2.nckotaccounttype,tk2.nctype

open kotitemsfetch170720        

set @maskotcoout= (select count(*) from trans_barkot_mas)
set @billid= (select ident_current('Trans_BARKot_mas'))
		if(@billid >=1 and @maskotcoout >0)
		BEGIN
			set @billid = @billid+1						
		END
    FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg,@pax,
	@iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt,@mlqty,@nckotaccounttype,@nctype
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool1 = 1
				IF(@nckotaccounttype=0)
					BEGIN
						
						set @nc=0
						set @nctypeid=0
						set @rate = @trat
						set @amt=@tamt
						set @ncaccid=0
						
					END
				ELSE
				    BEGIN
					
					set @nc=1
						set @nctypeid=@nctype
						set @rate = 0.00
						set @amt=0.00
						set @ncaccid=@nckotaccounttype
						
						
					END
				
					INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,qty1,added,
					tkotid,Splinstruction,KITCHENMSG,storeitemid,nckot,ncaccid,nctypeid)values
					(@part,@billid,@itemid,@tqty,@rate,@amt,@tableid,@iscoktail,@tqty,0,@kotid,@splinstruction,
					@kitmsg,@storeitemid,@nc,@nckotaccounttype,@nctypeid ) 
					INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,(@mlqty),ident_current('Trans_BARKot_det '))

				
				

               set	@Tamt1=@amt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
                    
                FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg,@pax,
	            @iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt,@mlqty,@nckotaccounttype,@nctype
                END
                CLOSE kotitemsfetch170720
                DEALLOCATE kotitemsfetch170720

		
				
				
					
					
					
set @Employeeid = (select Employeeid from employee WHERE Employee=@Employee)

				

				
				
  INSERT INTO dbo.Trans_BARKot_mas(Refno,Raised,counterid,noofpax,part,tableid,Stwid,Kotno,Kotdate, 
  Kottime, totalamount, rOOMORTAB,Userid,sessionid,tokenno,NCconversionreson,nckot,nctypeid,ncaccid) 
  VALUES ('','0',@counter,@noofpax,@part,@tableid,@Employeeid,
  dbo.RotNo(),convert(VARCHAR,getdate(),101), convert(VARCHAR,getdate(),108), @sum11,'T',1,@sessionid,
 @tokenno,@ncreson,@nc,@nctypeid,@ncaccid) 





USE [elanzambar]
GO
/****** Object:  StoredProcedure [dbo].[kot__save__one]    Script Date: 02/03/2024 16:34:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[kot__save__one]
@tableid bigint,@counter bigint, @sessionid bigint, @tokenno bigint,@noofpax bigint,@Employee varchar(100)
As

declare @maskotcoout bigint=0
declare @qty bigint ,@part varchar(100),@itemid bigint ,@tqty bigint,@trat numeric(12,2),
@tamt numeric(12,2), @bool bigint=0,
@iscoktail varchar(2),@storeitemid bigint,@kotid bigint,@splinstruction varchar(1000),@kitmsg varchar(1000),
@nccoversion varchar(1000),
@Tamt1 numeric(12,2), @sum11 numeric(12,2)=0,@ncreson varchar(1000),@Employeeid bigint,@billid bigint,@mlqty bigint,
@nc bigint, @nctypeid bigint, @ncaccid bigint,@amt numeric(12,2),@rate numeric(12,2),@nckotaccounttype bigint,@nctype bigint
set @sum11=0
set @sum11=0
set @amt=0

set @maskotcoout= (select count(*) from trans_barkot_mas)


declare kotitemsfetch170719 cursor for 

SELECT DISTINCT bid.qty ,tk2.part,tk2.Itemid,Tqty,tk2.TRat,Tamt,iscocktail,
tk2.storeitemid,Kot_Id,Splinstruction,KITMSG,tk2.NCconversionreson,bm.Mlqty,tk2.nckotaccounttype,tk2.nctype
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Stock_Itemmmas s on s.Itemid=tk2.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					inner join Barmltype bm on bm.Mlid=bid.mlid
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid
					--and isnull(tk2.Approved,0) =0
					 and  iscocktail <>'D'

open kotitemsfetch170719
set @maskotcoout= (select count(*) from trans_barkot_mas) 
set @billid= (select ident_current('Trans_BARKot_mas'))
		if(@billid >= 1 and @maskotcoout >0)
		BEGIN
			set @billid = @billid+1						
		END       

    FETCH NEXT FROM kotitemsfetch170719 INTO  @qty,@part,@itemid,@tqty,@trat,@tamt,@iscoktail,
	@storeitemid,@kotid,@splinstruction,@kitmsg,@nccoversion,@mlqty,@nckotaccounttype,@nctype
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool = 1
				
				IF(@nckotaccounttype=0)
					BEGIN
						set @nc=0
						set @nctypeid=0
						set @rate = @trat
						set @amt=@tamt
						set @ncaccid=0
					END
				ELSE
				    BEGIN
						set @nc=1
						set @nctypeid=@nctype
						set @rate = 0.00
						set @amt=0.00
						set @ncaccid=@nckotaccounttype
					END
				INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,storeitemid,
				qty1,added,tkotid,Splinstruction,KITCHENMSG,ncaccid,nckot,nctypeid)values(@part,@billid,@itemid,
				@tqty,@rate,@amt,@tableid,
				@iscoktail,@storeitemid,@tqty,0,@kotid,@splinstruction,@kitmsg,@nckotaccounttype,@nc,@nctypeid)
				INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,(@mlqty),
				ident_current('Trans_BARKot_det '))
				set	@Tamt1=@amt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
				
                    
                FETCH NEXT FROM kotitemsfetch170719 INTO @qty,@part,@itemid,@tqty,@trat,@tamt,@iscoktail,@storeitemid,
				@kotid,@splinstruction,@kitmsg,@nccoversion,@mlqty,@nckotaccounttype,@nctype
                END
                CLOSE kotitemsfetch170719
                DEALLOCATE kotitemsfetch170719


declare @baritemname varchar(500),@pax bigint, @sbarstockqty bigint,@icecreamorfood bigint,@otheritems bigint,@bool1 bigint
set @bool = 0

declare kotitemsfetch170720 cursor for 

SELECT DISTINCT btm.BarItemname,tk2.NCconversionreson,Splinstruction,KITMSG,tk2.Noofpax,iscocktail,tk2.TRat,
Kot_Id,Tqty,tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt,bm.Mlqty,tk2.nckotaccounttype,tk2.nctype
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					inner join Barmltype bm on bm.Mlid=bid.mlid
					INNER JOIN Stock_Itemmmas s on s.Itemid=bid.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 				
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid 
					and tk2.Approved ='1' 
					and iscocktail ='D'
					--and iscocktail ='Y'
					group by tk2.Itemid,btm.BarItemname,tk2.Noofpax,iscocktail,tk2.NCconversionreson,tk2.TRat,Kot_Id,Tqty,
					TableId,tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt,Tqty,Splinstruction,
					KITMSG,bm.Mlqty,tk2.nckotaccounttype,tk2.nctype

open kotitemsfetch170720        

set @maskotcoout= (select count(*) from trans_barkot_mas)
set @billid= (select ident_current('Trans_BARKot_mas'))
		if(@billid >=1 and @maskotcoout >0)
		BEGIN
			set @billid = @billid+1						
		END
    FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg,@pax,
	@iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt,@mlqty,@nckotaccounttype,@nctype
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool1 = 1
				IF(@nckotaccounttype=0)
					BEGIN
						
						set @nc=0
						set @nctypeid=0
						set @rate = @trat
						set @amt=@tamt
						set @ncaccid=0
						
					END
				ELSE
				    BEGIN
					
					set @nc=1
						set @nctypeid=@nctype
						set @rate = 0.00
						set @amt=0.00
						set @ncaccid=@nckotaccounttype
						
						
					END
				
					INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,qty1,added,
					tkotid,Splinstruction,KITCHENMSG,storeitemid,nckot,ncaccid,nctypeid)values
					(@part,@billid,@itemid,@tqty,@rate,@amt,@tableid,@iscoktail,@tqty,0,@kotid,@splinstruction,
					@kitmsg,@storeitemid,@nc,@nckotaccounttype,@nctypeid ) 
					INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,(@mlqty),ident_current('Trans_BARKot_det '))

				
				

               set	@Tamt1=@amt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
                    
                FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg,@pax,
	            @iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt,@mlqty,@nckotaccounttype,@nctype
                END
                CLOSE kotitemsfetch170720
                DEALLOCATE kotitemsfetch170720

		
				
				
					
					
					
set @Employeeid = (select Employeeid from employee WHERE Employee=@Employee)

				

				
				
  INSERT INTO dbo.Trans_BARKot_mas(Refno,Raised,counterid,noofpax,part,tableid,Stwid,Kotno,Kotdate, 
  Kottime, totalamount, rOOMORTAB,Userid,sessionid,tokenno,NCconversionreson,nckot,nctypeid,ncaccid) 
  VALUES ('','0',@counter,@noofpax,@part,@tableid,@Employeeid,
  dbo.RotNo(),convert(VARCHAR,getdate(),101), convert(VARCHAR,getdate(),108), @sum11,'T',1,@sessionid,
 @tokenno,@ncreson,@nc,@nctypeid,@ncaccid) 





GO


create PROCEDURE [dbo].[Get_NCKot2] @ID BIGINT=0 ,@fromdate datetime,@todate datetime,@tableid bigint
as 
BEGIN  
SELECT * FROM Trans_BARKot_mas c 
                    INNER JOIN Mas_nckottype  s ON s.typeid= c.nctypeid
					inner join tablemas t on t.Tableid=c.tableid
					where c.nctypeid =  @ID and kotdate between @fromdate and @todate 
					and t.tablegroupid=(case when @tableid=0 then t.tablegroupid else @tableid end )
					order by Kotid desc END







GO

	ALTER PROCEDURE [dbo].[Get_NCKot] @ID BIGINT=0 ,@fromdate datetime,@todate datetime
as 
BEGIN  
SELECT * FROM Trans_BARKot_mas c 
                    INNER JOIN Mas_nckottype  s ON s.typeid= c.nctypeid
					inner join tablemas t on t.Tableid=c.tableid
					where c.nctypeid =  @ID and kotdate between @fromdate and @todate
					order by Kotid desc END



---changes on 04.03.2024


create procedure get_barstoreadjustmentreport
@fromdate datetime,@todate datetime, @barorstore varchar(2)
as
select mas.Entryno,mas.Entrydate,det.Qty,det.Addorless,s.Itemname,det.remarks
  from Trans_Bar_StockAdjustmentmas mas
inner join Trans_Bar_StockAdjustmentdet det on mas.Adjid=det.Adjid
inner join Stock_itemmmas s on s.Itemid=det.itemid
where entrydate between @fromdate and @todate and Baroorstore=@barorstore





insert into submenu(submenu,mnid,act,des)values('Adjustment',3,15,'AdjustmentReport')


--changes on 05.03.2024

alter table application_settings add  itemgroupwiseprint bigint

alter table itemgroup add printerpath varchar(2000)


alter table headings add foodkotprefix varchar(2000) not null default 'KOT'
alter table headings add foodkotstarting varchar(2000) not null default '1001'
alter table headings add liquorkotprefix varchar(2000) not null default 'KOT'
alter table headings add liquorkotstarting varchar(2000) not null default '2001'
alter table headings add foodbillprefix varchar(2000) not null default 'BIL'
alter table headings add foodbillstarting varchar(2000) not null default '3001'
alter table headings add liquorbillprefix varchar(2000) not null default 'BIL'
alter table headings add liquorbillstarting varchar(2000) not null default '4001'
alter table headings add nckottprefix varchar(2000) not null default 'NCT'
alter table headings add nckottstarting varchar(2000) not null default '5001'


create  FUNCTION [dbo].[sep_foodbill] (@foodornot varchar(2))

RETURNS varchar(2000) 
AS  
BEGIN

DECLARE @STR VARCHAR(5000),@prefix varchar(1000),@start varchar(1000),@count bigint ;

if(@foodornot ='D')
	begin
		set @prefix = (select foodkotprefix from headings where restypeid='4' and resorroom='BAR')
		set @start = (select foodkotstarting from headings where restypeid='4' and resorroom='BAR')
		set @count = (select count(*) from trans_barkot_mas where isnull(nckot,0)<>1 and kotno like @prefix+'%')
		if(@count = 0)
			begin
				set @STR = @start
			end 
		else
			begin
				SET @STR=(SELECT  max(substring(Kotno,len(@prefix)+1,len(@start)))+1 
				FROM trans_barkot_mas where isnull(nckot,0)<>1)
			end

	end


if(@foodornot ='L')
	begin
		set @prefix = (select liquorkotprefix from headings where restypeid='4' and resorroom='BAR')
		set @start = (select liquorkotstarting from headings where restypeid='4' and resorroom='BAR')
		set @count = (select count(*) from trans_barkot_mas where isnull(nckot,0)<>1 and kotno like @prefix+'%')
		if(@count = 0)
			begin
				set @STR = @start
			end 
		else
			begin
				SET @STR=(SELECT  max(substring(Kotno,len(@prefix)+1,len(@start)))+1 
				FROM trans_barkot_mas where isnull(nckot,0)<>1)
			end

	end


if(@foodornot ='N')
	begin
		set @prefix = (select nckottprefix from headings where restypeid='4' and resorroom='BAR')
		set @start = (select  nckottstarting from headings where restypeid='4' and resorroom='BAR')
		set @count = (select count(*) from trans_barkot_mas where isnull(nckot,0)<>0 and kotno like @prefix+'%')
		if(@count = 0)
			begin
				set @STR = @start
			end 
		else
			begin
				SET @STR=(SELECT  max(substring(Kotno,len(@prefix)+1,len(@start)))+1 
				FROM trans_barkot_mas where isnull(nckot,0)<>1)
			end

	end


RETURN @prefix+@STR
END



--- changes on 07.03.2024



GO
/****** Object:  StoredProcedure [dbo].[kot__save__two]    Script Date: 07/03/2024 15:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[kot__save__two]
@tableid bigint,@counter bigint, @sessionid bigint, @tokenno bigint,@refdate datetime,@reftime datetime,@noofpax bigint,@Stwid bigint
As

declare @qty bigint ,@part varchar(100),@itemid bigint ,@tqty bigint,@trat numeric(12,2),@tamt numeric(12,2), @bool bigint=0,
@iscoktail varchar(2),@storeitemid bigint,@kotid bigint,@splinstruction varchar(1000),@kitmsg varchar(1000),
@nccoversion varchar(1000),
@Tamt1 numeric(12,2), @sum11 numeric(12,2),@ncreson varchar(1000),@Employeeid bigint,@billid bigint, @baritemname varchar(500),
@pax bigint, @sbarstockqty bigint,@icecreamorfood bigint,@otheritems bigint,@bool1 bigint,@nckotaccounttype bigint,@nctype varchar(100),
@itemname  varchar(100),@nc bigint, @nctypeid bigint, @ncaccid bigint,@amt numeric(12,2),@rate numeric(12,2),@mlqty bigint
set @sum11=0
set @sum11=0
set @amt=0

  INSERT INTO dbo.Trans_BARKot_mas(Refno,Raised,counterid,noofpax,part,tableid,Stwid,Kotno,Kotdate,  Kottime, totalamount, rOOMORTAB,Userid,sessionid,tokenno,NCconversionreson,refkotdate,refkottime) 
  VALUES ('','0',@counter,@noofpax,@part,@tableid,@Stwid,  dbo.RotNo(),@refdate,@reftime, @sum11,'T',1,@sessionid, @tokenno,@ncreson,convert(VARCHAR,getdate(),101), convert(VARCHAR,getdate(),108)) 
 set @billid=(Select SCOPE_IDENTITY())

declare kotitemsfetch170719 cursor for 
SELECT DISTINCT btm.BarItemname,tk2.NCconversionreson,isnull(tk2.nckotaccounttype,0) as nckotaccounttype ,nctype,
					Splinstruction,KITMSG,tk2.Noofpax,tk2.storeitemid,iscocktail,tk2.TRat,Kot_Id,Tqty,tk2.Itemid,
					s.Itemname,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt,bm.Mlqty
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Stock_Itemmmas s on s.Itemid=tk2.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					inner join Barmltype bm on bm.Mlid=bid.mlid
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid
					and tk2.Approved ='1'
set @bool1=0
open kotitemsfetch170719 
     

   FETCH NEXT FROM kotitemsfetch170719 INTO  @baritemname,@nccoversion,@nckotaccounttype,@nctype,@splinstruction,@kitmsg,
 @pax,@storeitemid,@iscoktail,@trat,@kotid,@tqty,@itemid,@itemname,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty
 ,@tamt,@mlqty
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool1 = 1
				IF(@nckotaccounttype=0)
					BEGIN
						set @nc=0
						set @nctypeid=0
						set @rate = @trat
						set @amt=@tamt
						set @ncaccid=0
					END
				ELSE
				    BEGIN
						set @nc=1
						set @nctypeid=@nctype
						set @rate = 0.00
						set @amt=0.00
						set @ncaccid=@nckotaccounttype
					END
		
				
				INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,storeitemid,qty1,added,tkotid,Splinstruction,KITCHENMSG,nckot,nctypeid,ncaccid)
				values(@part,@billid,@itemid,@tqty,@rate,@amt,@tableid,@iscoktail,@storeitemid,@tqty,0,@kotid,@splinstruction,@kitmsg,@nc,@nctypeid,@ncaccid)
				INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,(@mlqty),ident_current('Trans_BARKot_det '))
				set	@Tamt1=@amt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
					
                    
               FETCH NEXT FROM kotitemsfetch170719 INTO  @baritemname,@nccoversion,@nckotaccounttype,@nctype,@splinstruction,@kitmsg,
 @pax,@storeitemid,@iscoktail,@trat,@kotid,@tqty,@itemid,@itemname,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt,@mlqty
                END
                CLOSE kotitemsfetch170719
                DEALLOCATE kotitemsfetch170719



declare kotitemsfetch170720 cursor for 


SELECT DISTINCT btm.BarItemname,tk2.NCconversionreson,Splinstruction,KITMSG,tk2.Noofpax,iscocktail,tk2.TRat,Kot_Id,Tqty,
tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt,bm.Mlqty
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					inner join Barmltype bm on bm.Mlid=bid.mlid
					INNER JOIN Stock_Itemmmas s on s.Itemid=bid.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 				
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid
					and tk2.Approved ='1' and iscocktail ='Y'
					group by tk2.Itemid,btm.BarItemname,tk2.NCconversionreson,tk2.Noofpax,iscocktail,tk2.TRat,Kot_Id,Tqty,
					TableId,tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt,Tqty,Splinstruction,
					KITMSG,bm.Mlqty
open kotitemsfetch170720        


    FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg, @pax,
@iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt,@mlqty
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool1 = 1
				IF(@nckotaccounttype=0)
					BEGIN
						set @rate = @trat
						set @amt=@tamt
						
					END
				ELSE
				    BEGIN
					
						set @rate = 0.00
						set @amt=0.00
						
					END
				    INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,storeitemid,qty1,added,tkotid,Splinstruction,KITCHENMSG,nckot,nctypeid,ncaccid)
				values(@part,@billid,@itemid,@tqty,@rate,@amt,@tableid,@iscoktail,@storeitemid,@tqty,0,@kotid,@splinstruction,@kitmsg,@nc,@nctypeid,@ncaccid)
					INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,(@mlqty),ident_current('Trans_BARKot_det '))

				
				set	@Tamt1=@amt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
                    
                FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg, @pax,
                @iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt,@mlqty
                END
                CLOSE kotitemsfetch170720
                DEALLOCATE kotitemsfetch170720

				if(@bool1=1)
				BEGIN
					select @Employeeid = Employeeid from employee WHERE istabsteward='1'
				END

					
--UPdate Mas
  UPdate dbo.Trans_BARKot_mas set part=@part, totalamount=@sum11,nckot=@nc,nctypeid=@nctypeid where Kotid=@billid

 update Tablemas set Status='K' where Tableid=@tableid
 --Delete from temp_kot2 where Tableid=@tableid
 select @billid as ID



GO
create table temp_billid(billid bigint,bdate datetime)


---- changes on 08.03.2024

alter table headings add ncbillprefix varchar(1000) not null default 'NCB'
alter table headings add ncbillstarting varchar(1000) not null default '7001'


truncate table temp_billid

create  FUNCTION [dbo].[sep_foodbill_raise] (@foodornot varchar(2))

RETURNS varchar(2000) 
AS  
BEGIN

DECLARE @STR VARCHAR(5000),@prefix varchar(1000),@start varchar(1000),@count bigint ;

if(@foodornot ='D')
	begin
		set @prefix = (select foodbillprefix from headings where restypeid='4' and resorroom='BAR')
		set @start = (select foodbillstarting from headings where restypeid='4' and resorroom='BAR')
		set @count = (select count(*) from Trans_BARKotBillraise_mas where isnull(comp,0)<>1 and billno like @prefix+'%')
		if(@count = 0)
			begin
				set @STR = @start
			end 
		else
			begin
				SET @STR=(SELECT  max(substring(billno,len(@prefix)+1,len(@start)))+1 
				FROM Trans_BARKotBillraise_mas where isnull(comp,0)<>1)
			end

	end


if(@foodornot ='L')
	begin
		set @prefix = (select liquorbillprefix from headings where restypeid='4' and resorroom='BAR')
		set @start = (select liquorbillstarting from headings where restypeid='4' and resorroom='BAR')
		set @count = (select count(*) from Trans_BARKotBillraise_mas where isnull(comp,0)<>1 and billno like @prefix+'%')
		if(@count = 0)
			begin
				set @STR = @start
			end 
		else
			begin
				SET @STR=(SELECT  max(substring(billno,len(@prefix)+1,len(@start)))+1 
				FROM Trans_BARKotBillraise_mas where isnull(comp,0)<>1)
			end

	end


if(@foodornot ='N')
	begin
		set @prefix = (select ncbillprefix from headings where restypeid='4' and resorroom='BAR')
		set @start = (select  ncbillstarting from headings where restypeid='4' and resorroom='BAR')
		set @count = (select count(*) from Trans_BARKotBillraise_mas where isnull(comp,0)<>0 and billno like @prefix+'%')
		if(@count = 0)
			begin
				set @STR = @start
			end 
		else
			begin
				SET @STR=(SELECT  max(substring(billno,len(@prefix)+1,len(@start)))+1 
				FROM Trans_BARKotBillraise_mas where isnull(comp,0)<>1)
			end

	end


RETURN @prefix+@STR
END



USE [elanzambar]
GO
/****** Object:  StoredProcedure [dbo].[kot__save__one__separate]    Script Date: 07/03/2024 18:15:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[kot__save__one__separate]
@tableid bigint,@counter bigint, @sessionid bigint, @tokenno bigint,@noofpax bigint,
@Employee varchar(100)
As

declare @maskotcoout bigint=0
declare @qty bigint ,@part varchar(100),@itemid bigint ,@tqty bigint,@trat numeric(12,2),
@tamt numeric(12,2), @bool bigint=0,
@iscoktail varchar(2),@storeitemid bigint,@kotid bigint,@splinstruction varchar(1000),
@kitmsg varchar(1000),
@nccoversion varchar(1000),
@Tamt1 numeric(12,2), @sum11 numeric(12,2)=0,@ncreson varchar(1000),@Employeeid bigint,@billid bigint,@mlqty bigint,
@nc bigint, @nctypeid bigint, @ncaccid bigint,@amt numeric(12,2),@rate numeric(12,2),@nckotaccounttype bigint,@nctype bigint,@separatebilll varchar(1000)
set @sum11=0
set @sum11=0
set @amt=0

set @maskotcoout= (select count(*) from trans_barkot_mas)


declare kotitemsfetch170719 cursor for 

SELECT DISTINCT bid.qty ,tk2.part,tk2.Itemid,Tqty,tk2.TRat,Tamt,iscocktail,
tk2.storeitemid,Kot_Id,Splinstruction,KITMSG,tk2.NCconversionreson,bm.Mlqty,tk2.nckotaccounttype,tk2.nctype
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Stock_Itemmmas s on s.Itemid=tk2.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					inner join Barmltype bm on bm.Mlid=bid.mlid
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid
					--and isnull(tk2.Approved,0) =0
					 and  iscocktail <>'D'

open kotitemsfetch170719
set @maskotcoout= (select count(*) from trans_barkot_mas) 
set @billid= (select ident_current('Trans_BARKot_mas'))
		if(@billid >= 1 and @maskotcoout >0)
		BEGIN
			set @billid = @billid+1						
		END       

    FETCH NEXT FROM kotitemsfetch170719 INTO  @qty,@part,@itemid,@tqty,@trat,@tamt,@iscoktail,
	@storeitemid,@kotid,@splinstruction,@kitmsg,@nccoversion,@mlqty,@nckotaccounttype,@nctype
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool = 1
				
				IF(@nckotaccounttype=0)
					BEGIN
						set @nc=0
						set @nctypeid=0
						set @rate = @trat
						set @amt=@tamt
						set @ncaccid=0
					END
				ELSE
				    BEGIN
						set @nc=1
						set @nctypeid=@nctype
						set @rate = 0.00
						set @amt=0.00
						set @ncaccid=@nckotaccounttype
					END
				INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,storeitemid,
				qty1,added,tkotid,Splinstruction,KITCHENMSG,ncaccid,nckot,nctypeid)values(@part,@billid,@itemid,
				@tqty,@rate,@amt,@tableid,
				@iscoktail,@storeitemid,@tqty,0,@kotid,@splinstruction,@kitmsg,@nckotaccounttype,@nc,@nctypeid)
				INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,(@mlqty),
				ident_current('Trans_BARKot_det '))
				set	@Tamt1=@amt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
				
                    
                FETCH NEXT FROM kotitemsfetch170719 INTO @qty,@part,@itemid,@tqty,@trat,@tamt,@iscoktail,@storeitemid,
				@kotid,@splinstruction,@kitmsg,@nccoversion,@mlqty,@nckotaccounttype,@nctype
                END

									
				set @Employeeid = (select Employeeid from employee WHERE Employee=@Employee)
				set @separatebilll = (select dbo.sep_foodbill('D') )
				if(@nc =1)
					begin
						set @separatebilll = (select dbo.sep_foodbill('N') )
					end
	
				INSERT INTO dbo.Trans_BARKot_mas(Refno,Raised,counterid,noofpax,part,tableid,Stwid,Kotno,Kotdate, 
				 Kottime, totalamount, rOOMORTAB,Userid,sessionid,tokenno,NCconversionreson,nckot,nctypeid,ncaccid) 
				VALUES ('','0',@counter,@noofpax,@part,@tableid,@Employeeid,
				@separatebilll,convert(VARCHAR,getdate(),101), convert(VARCHAR,getdate(),108), @sum11,'T',1,@sessionid,
				@tokenno,@ncreson,@nc,@nctypeid,@ncaccid) 
				insert into temp_billid(billid,bdate)values(IDENT_CURRENT('trans_barkot_mas'),convert(VARCHAR,getdate(),101))
				

                CLOSE kotitemsfetch170719
                DEALLOCATE kotitemsfetch170719


declare @baritemname varchar(500),@pax bigint, @sbarstockqty bigint,@icecreamorfood bigint,@otheritems bigint,@bool1 bigint
set @bool = 0
set @sum11=0
set @sum11=0
set @amt=0

declare kotitemsfetch170720 cursor for 

SELECT DISTINCT btm.BarItemname,tk2.NCconversionreson,Splinstruction,KITMSG,
tk2.Noofpax,iscocktail,tk2.TRat,
Kot_Id,Tqty,tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,
otheritems,bid.qty,Tamt,bm.Mlqty,tk2.nckotaccounttype,tk2.nctype,tk2.storeitemid
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					inner join Barmltype bm on bm.Mlid=bid.mlid
					INNER JOIN Stock_Itemmmas s on s.Itemid=bid.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 				
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid 
					and tk2.Approved ='1' 
					and iscocktail ='D'
					--and iscocktail ='Y'
					group by tk2.Itemid,btm.BarItemname,tk2.Noofpax,iscocktail,tk2.NCconversionreson,tk2.TRat,Kot_Id,Tqty,
				    TableId,tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt,Tqty,Splinstruction,
					KITMSG,bm.Mlqty,tk2.nckotaccounttype,tk2.nctype,tk2.storeitemid

open kotitemsfetch170720        

set @maskotcoout= (select count(*) from trans_barkot_mas)
set @billid= (select ident_current('Trans_BARKot_mas'))
		if(@billid >=1 and @maskotcoout >0)
		BEGIN
			set @billid = @billid+1						
		END
    FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg,@pax,
	@iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt,@mlqty,@nckotaccounttype,@nctype,@storeitemid
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool1 = 1
				IF(@nckotaccounttype=0)
					BEGIN
						
						set @nc=0
						set @nctypeid=0
						set @rate = @trat
						set @amt=@tamt
						set @ncaccid=0
						
					END
				ELSE
				    BEGIN
					
					set @nc=1
						set @nctypeid=@nctype
						set @rate = 0.00
						set @amt=0.00
						set @ncaccid=@nckotaccounttype
						
						
					END
				
					INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,qty1,added,
					tkotid,Splinstruction,KITCHENMSG,storeitemid,nckot,ncaccid,nctypeid)values
					(@part,@billid,@itemid,@tqty,@rate,@amt,@tableid,@iscoktail,@tqty,0,@kotid,@splinstruction,
					@kitmsg,@storeitemid,@nc,@nckotaccounttype,@nctypeid ) 
					INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,(@mlqty),ident_current('Trans_BARKot_det '))

				
				

               set	@Tamt1=@amt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
                    
                FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg,@pax,
	            @iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt,@mlqty,@nckotaccounttype,@nctype,@storeitemid
                END
				set @Employeeid = (select Employeeid from employee WHERE Employee=@Employee)
				set @separatebilll = (select dbo.sep_foodbill('L') )
				if(@nc =1)
					begin
						set @separatebilll = (select dbo.sep_foodbill('N') )
					end
	
				  INSERT INTO dbo.Trans_BARKot_mas(Refno,Raised,counterid,noofpax,part,tableid,Stwid,Kotno,Kotdate, 
				  Kottime, totalamount, rOOMORTAB,Userid,sessionid,tokenno,NCconversionreson,nckot,nctypeid,ncaccid) 
				  VALUES ('','0',@counter,@noofpax,@part,@tableid,@Employeeid,
				  @separatebilll,convert(VARCHAR,getdate(),101), convert(VARCHAR,getdate(),108), @sum11,'T',1,@sessionid,
				 @tokenno,@ncreson,@nc,@nctypeid,@ncaccid)

				 insert into temp_billid(billid,bdate)values(IDENT_CURRENT('trans_barkot_mas'),convert(VARCHAR,getdate(),101))
				
                CLOSE kotitemsfetch170720
                DEALLOCATE kotitemsfetch170720

		
				
				
GO
ALTER procedure [dbo].[kot__save__one__separate]
@tableid bigint,@counter bigint, @sessionid bigint, @tokenno bigint,@noofpax bigint,
@Employee varchar(100)
As

declare @maskotcoout bigint=0
declare @qty bigint ,@part varchar(100),@itemid bigint ,@tqty bigint,@trat numeric(12,2),
@tamt numeric(12,2), @bool bigint=0,
@iscoktail varchar(2),@storeitemid bigint,@kotid bigint,@splinstruction varchar(1000),
@kitmsg varchar(1000),
@nccoversion varchar(1000),
@Tamt1 numeric(12,2), @sum11 numeric(12,2)=0,@ncreson varchar(1000),@Employeeid bigint,@billid bigint,@mlqty bigint,
@nc bigint, @nctypeid bigint, @ncaccid bigint,@amt numeric(12,2),@rate numeric(12,2),@nckotaccounttype bigint,@nctype bigint,@separatebilll varchar(1000),
@setbool1 bigint
set @sum11=0
set @sum11=0
set @amt=0
set @setbool1=0

set @maskotcoout= (select count(*) from trans_barkot_mas)


declare kotitemsfetch170719 cursor for 

SELECT DISTINCT bid.qty ,tk2.part,tk2.Itemid,Tqty,tk2.TRat,Tamt,iscocktail,
tk2.storeitemid,Kot_Id,Splinstruction,KITMSG,tk2.NCconversionreson,bm.Mlqty,tk2.nckotaccounttype,tk2.nctype
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Stock_Itemmmas s on s.Itemid=tk2.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					inner join Barmltype bm on bm.Mlid=bid.mlid
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid
					--and isnull(tk2.Approved,0) =0
					 and  iscocktail <>'D'

open kotitemsfetch170719
set @maskotcoout= (select count(*) from trans_barkot_mas) 
set @billid= (select ident_current('Trans_BARKot_mas'))
		if(@billid >= 1 and @maskotcoout >0)
		BEGIN
			set @billid = @billid+1						
		END       

    FETCH NEXT FROM kotitemsfetch170719 INTO  @qty,@part,@itemid,@tqty,@trat,@tamt,@iscoktail,
	@storeitemid,@kotid,@splinstruction,@kitmsg,@nccoversion,@mlqty,@nckotaccounttype,@nctype
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool = 1
				set @setbool1 = 1
				
				IF(@nckotaccounttype=0)
					BEGIN
						set @nc=0
						set @nctypeid=0
						set @rate = @trat
						set @amt=@tamt
						set @ncaccid=0
					END
				ELSE
				    BEGIN
						set @nc=1
						set @nctypeid=@nctype
						set @rate = 0.00
						set @amt=0.00
						set @ncaccid=@nckotaccounttype
					END
				INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,storeitemid,
				qty1,added,tkotid,Splinstruction,KITCHENMSG,ncaccid,nckot,nctypeid)values(@part,@billid,@itemid,
				@tqty,@rate,@amt,@tableid,
				@iscoktail,@storeitemid,@tqty,0,@kotid,@splinstruction,@kitmsg,@nckotaccounttype,@nc,@nctypeid)
				INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,(@mlqty),
				ident_current('Trans_BARKot_det '))
				set	@Tamt1=@amt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
				
                    
                FETCH NEXT FROM kotitemsfetch170719 INTO @qty,@part,@itemid,@tqty,@trat,@tamt,@iscoktail,@storeitemid,
				@kotid,@splinstruction,@kitmsg,@nccoversion,@mlqty,@nckotaccounttype,@nctype
                END

									
				set @Employeeid = (select Employeeid from employee WHERE Employee=@Employee)
				set @separatebilll = (select dbo.sep_foodbill('L') )
				if(@nc =1)
					begin
						set @separatebilll = (select dbo.sep_foodbill('N') )
					end
	
	            if(@setbool1 = 1)
					begin
						INSERT INTO dbo.Trans_BARKot_mas(Refno,Raised,counterid,noofpax,part,tableid,Stwid,Kotno,Kotdate, 
						 Kottime, totalamount, rOOMORTAB,Userid,sessionid,tokenno,NCconversionreson,nckot,nctypeid,ncaccid) 
						VALUES ('','0',@counter,@noofpax,@part,@tableid,@Employeeid,
						@separatebilll,convert(VARCHAR,getdate(),101), convert(VARCHAR,getdate(),108), @sum11,'T',1,@sessionid,
						@tokenno,@ncreson,@nc,@nctypeid,@ncaccid) 
						insert into temp_billid(billid,bdate)values(IDENT_CURRENT('trans_barkot_mas'),convert(VARCHAR,getdate(),101))
					end

				
				

                CLOSE kotitemsfetch170719
                DEALLOCATE kotitemsfetch170719


declare @baritemname varchar(500),@pax bigint, @sbarstockqty bigint,@icecreamorfood bigint,@otheritems bigint,@bool1 bigint,@setbool bigint
set @bool = 0
set @sum11=0
set @sum11=0
set @amt=0
set @setbool =0

declare kotitemsfetch170720 cursor for 

SELECT DISTINCT btm.BarItemname,tk2.NCconversionreson,Splinstruction,KITMSG,
tk2.Noofpax,iscocktail,tk2.TRat,
Kot_Id,Tqty,tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,
otheritems,bid.qty,Tamt,bm.Mlqty,tk2.nckotaccounttype,tk2.nctype,tk2.storeitemid
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					inner join Barmltype bm on bm.Mlid=bid.mlid
					INNER JOIN Stock_Itemmmas s on s.Itemid=bid.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 				
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid
					and tk2.Approved ='1' 
					and iscocktail ='D'
					--and iscocktail ='Y'
					group by tk2.Itemid,btm.BarItemname,tk2.Noofpax,iscocktail,tk2.NCconversionreson,tk2.TRat,Kot_Id,Tqty,
				    TableId,tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt,Tqty,Splinstruction,
					KITMSG,bm.Mlqty,tk2.nckotaccounttype,tk2.nctype,tk2.storeitemid

open kotitemsfetch170720        

set @maskotcoout= (select count(*) from trans_barkot_mas)
set @billid= (select ident_current('Trans_BARKot_mas'))
		if(@billid >=1 and @maskotcoout >0)
		BEGIN
			set @billid = @billid+1						
		END
    FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg,@pax,
	@iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt,@mlqty,@nckotaccounttype,@nctype,@storeitemid
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool1 = 1
				set @setbool=1
				IF(@nckotaccounttype=0)
					BEGIN
						
						set @nc=0
						set @nctypeid=0
						set @rate = @trat
						set @amt=@tamt
						set @ncaccid=0
						
					END
				ELSE
				    BEGIN
					
					set @nc=1
						set @nctypeid=@nctype
						set @rate = 0.00
						set @amt=0.00
						set @ncaccid=@nckotaccounttype
						
						
					END
				

					INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,qty1,added,
					tkotid,Splinstruction,KITCHENMSG,storeitemid,nckot,ncaccid,nctypeid)values
					(@part,@billid,@itemid,@tqty,@rate,@amt,@tableid,@iscoktail,@tqty,0,@kotid,@splinstruction,
					@kitmsg,@storeitemid,@nc,@nckotaccounttype,@nctypeid ) 
					INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,(@mlqty),ident_current('Trans_BARKot_det '))

				
				

               set	@Tamt1=@amt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
                    
                FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg,@pax,
	            @iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt,@mlqty,@nckotaccounttype,@nctype,@storeitemid
                END
				set @Employeeid = (select Employeeid from employee WHERE Employee=@Employee)
				set @separatebilll = (select dbo.sep_foodbill('D') )
				if(@nc =1)
					begin
						set @separatebilll = (select dbo.sep_foodbill('N') )
					end
	
	               if(@setbool = 1)
					begin
						INSERT INTO dbo.Trans_BARKot_mas(Refno,Raised,counterid,noofpax,part,tableid,Stwid,Kotno,Kotdate, 
					  Kottime, totalamount, rOOMORTAB,Userid,sessionid,tokenno,NCconversionreson,nckot,nctypeid,ncaccid) 
					  VALUES ('','0',@counter,@noofpax,@part,@tableid,@Employeeid,
					  @separatebilll,convert(VARCHAR,getdate(),101), convert(VARCHAR,getdate(),108), @sum11,'T',1,@sessionid,
					 @tokenno,@ncreson,@nc,@nctypeid,@ncaccid)

					 insert into temp_billid(billid,bdate)values(IDENT_CURRENT('trans_barkot_mas'),convert(VARCHAR,getdate(),101))
					end
				  
				
                CLOSE kotitemsfetch170720
                DEALLOCATE kotitemsfetch170720

		
				
GOALTER  FUNCTION [dbo].[sep_foodbill_raise] (@foodornot varchar(2))

RETURNS varchar(2000) 
AS  
BEGIN

DECLARE @STR VARCHAR(5000),@prefix varchar(1000),@start varchar(1000),@count bigint ;

if(@foodornot ='D')
	begin
		set @prefix = (select foodbillprefix from headings where restypeid='4' and resorroom='BAR')
		set @start = (select foodbillstarting from headings where restypeid='4' and resorroom='BAR')
		set @count = (select count(*) from Trans_BARKotBillraise_mas where isnull(comp,0)<>1 and billno like @prefix+'%')
		if(@count = 0)
			begin
				set @STR = @start
			end 
		else
			begin
				SET @STR=(SELECT  max(substring(billno,len(@prefix)+1,len(@start)))+1 
				FROM Trans_BARKotBillraise_mas where isnull(comp,0)<>1)
			end

	end


if(@foodornot ='L')
	begin
		set @prefix = (select liquorbillprefix from headings where restypeid='4' and resorroom='BAR')
		set @start = (select liquorbillstarting from headings where restypeid='4' and resorroom='BAR')
		set @count = (select count(*) from Trans_BARKotBillraise_mas where isnull(comp,0)<>1 and billno like @prefix+'%')
		if(@count = 0)
			begin
				set @STR = @start
			end 
		else
			begin
				SET @STR=(SELECT  max(substring(billno,len(@prefix)+1,len(@start)))+1 
				FROM Trans_BARKotBillraise_mas where isnull(comp,0)<>1)
			end

	end


if(@foodornot ='N')
	begin
		set @prefix = (select ncbillprefix from headings where restypeid='4' and resorroom='BAR')
		set @start = (select  ncbillstarting from headings where restypeid='4' and resorroom='BAR')
		set @count = (select count(*) from Trans_BARKotBillraise_mas where isnull(comp,0)<>0 and billno like @prefix+'%')
		if(@count = 0)
			begin
				set @STR = @start
			end 
		else
			begin
				SET @STR=(SELECT  max(substring(billno,len(@prefix)+1,len(@start)))+1 
				FROM Trans_BARKotBillraise_mas where isnull(comp,0)<>1)
			end

	end


RETURN @prefix+@STR
END

USE [elanzambar]
GO
/****** Object:  StoredProcedure [dbo].[Exec_BillSave]    Script Date: 08/03/2024 10:35:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
alter procedure [dbo].[Exec_BillSave__separatefoodbill]
@Tableid Bigint,
@Taxexemption bigint,
@Billdate Datetime,
@Billtime Datetime,
@userid bigint
As 
BEGIN
declare @loopthrough bigint,@setcount bigint,@setbillid bigint
set @setcount =0;
declare loopingicecreamorfood1 cursor for

SELECT  isnull(ig.icecreamorfood,0)icecreamorfood FROM Trans_BARKot_mas m
				INNER JOIN Trans_BARKot_det d ON d.kotid=m.Kotid
				inner join bar_itemdet_id id on id.RefBarItemid=d.itemid
				inner join Stock_itemmmas sitm on sitm.Itemid=id.storeitemid
				inner join itemgroup ig on ig.Itemgroupid=sitm.Itemgroupid
				INNER JOIN Bar_itemmmas  i ON i.barItemid=d.itemid
				WHERE isnull(m.Raised,0)=0 AND m.tableid=@tableid and 
				isnull(d.cANCELORNORM,'')<>'C' and isnull(SplitBillRaised,0)=0 
				group by ig.icecreamorfood 
				order by ig.icecreamorfood desc
open loopingicecreamorfood1 
FETCH NEXT FROM loopingicecreamorfood1 INTO  @loopthrough
WHILE @@FETCH_STATUS = 0
Begin
	set @setcount = @setcount+1;
		declare @refbilldetid bigint, @Fooddisamount numeric(12,2), @FoodAmount numeric(12,2),@FeeAmount numeric(12,2),@FeeTax numeric(12,2)
		declare @Membershipfee numeric(12,2),@MembershipfeeTax numeric(12,2),@AdditionalMembershipfee numeric(12,2),@itemtotal numeric(12,2)
		declare @masItemTotal numeric(12,2),@masTax numeric(12,2),@roundoff numeric(12,2),@totaldiscount numeric(12,2),@totalamount numeric(12,2)
		select @Membershipfee=(select Membershipfee from application_settings)
		select @MembershipfeeTax=(select MembershipfeeTax from application_settings)
		select @AdditionalMembershipfee=(select AdditionalMembershipfee from application_settings)
		declare @disper numeric(12,2),@disamount numeric(12,2),@discountreason varchar(500),@MFee numeric(12,2),@MFeeTax numeric(12,2),
		@billno varchar(100),@billnumbercount bigint,@tcnt bigint

		    set @billno = (select dbo.sep_foodbill_raise('L') )
		    if(@loopthrough =1)
				begin
					set @billno = (select dbo.sep_foodbill_raise('D') )
				end
			
			
				

			set @masItemTotal=0.00
			set @masTax=0.00
			set @roundoff=0.00
			set @totaldiscount=0.00
			set @MFee=0
			set @MFeeTax=0
			----- mas Table Insert Star
				
				       if(@setcount =2)
						begin
							set @setbillid = (select ident_current('Trans_barkotbillraise_mas'))
						end
					
						insert into Trans_barkotbillraise_mas(Billno,Billdate,Billtime,Refdate,tableid,totalamount,itemtotal,Salestax,discamount,noofpax,Settled,rOOMORTAB,userid,roundoff,restypeid,crefno,sessionid,Reftime,Membershipfee,MembershipfeeTax,serchexception,discountreason,firstbillid)
						Values(@billno,@Billdate,@Billtime,convert(VARCHAR,getdate(),101),@Tableid,ROUND((@totalamount),0),@masItemTotal,@masTax,@totaldiscount,(select Top 1 noofpax from Trans_barkot_mas where Tableid=@Tableid and isnull(Raised,0)=0 ),0,'T',@userid,@roundoff,0,dbo.BillNo(),0,convert(VARCHAR,getdate(),108),@MFee,@MFeeTax,@Taxexemption,@discountreason,@setbillid)
						DECLARE @Billid INT
						SET @Billid = SCOPE_IDENTITY()
					----Mas Table Insert end

			select @FoodAmount = (SELECT isnull(sum(d.Amount),0) FROM Trans_BARKot_mas m
						INNER JOIN Trans_BARKot_det d ON d.kotid=m.Kotid
						inner join Trans_BarKotdet_id id on id.Refkotdetid=d.kotdetid
						inner join Stock_itemmmas sitm on sitm.Itemid=id.storeitemid
						inner join itemgroup ig on ig.Itemgroupid=sitm.Itemgroupid
						INNER JOIN Bar_itemmmas  i ON i.barItemid=d.itemid
					    WHERE isnull(m.Raised,0)=0 AND m.tableid=@Tableid and 
						isnull(d.cANCELORNORM,'')<>'C' and isnull(SplitBillRaised,0)=0 
						and isnull(ig.icecreamorfood,0)=@loopthrough  and isnull(m.nckot,0)=0 
						and isnull(d.Amount,0)<>'0'  )
			print 'Food Amout'
			print @FoodAmount
			select @Fooddisamount=(select isnull(sum(tb.disamount),0) from temp_billlist tb
							inner join Stock_itemmmas st on st.Itemid=tb.stock_id
							inner join itemgroup ig on ig.Itemgroupid=st.Itemgroupid
							where tb.tableid=@Tableid and isnull(ig.icecreamorfood,0)=@loopthrough)
			print '@Fooddisamount'
			print @Fooddisamount
			declare @icecreamorfood bigint,@itemid bigint,@Kotid bigint,@noofpax bigint,@kotdetid bigint,@Kotno Varchar(50),@Itemname varchar(500),@qty numeric(12,2),@Rate Numeric(12,2),@Amount Numeric(12,2),@taxsetupid bigint,@Itemgroupid bigint
			declare @feeper numeric(12,4)			
			set @MFee=0.00
			set @MFeeTax=0.00
			declare kotitemsfetch001 cursor for 
			SELECT ig.icecreamorfood,d.itemid,m.Kotid,m.noofpax,d.kotdetid,m.Kotno,i.barItemname AS Itemname,d.qty,d.Rate,d.Amount,s.Itemgroupid,ig.taxsetupid FROM Trans_BARKot_mas m
			INNER JOIN Trans_BARKot_det d ON d.kotid=m.Kotid
			INNER JOIN Bar_itemmmas  i ON i.barItemid=d.itemid
			INNER JOIN Bar_Itemdet_id bdet ON i.BarItemid = bdet.RefBarItemid 
			INNER JOIN Stock_Itemmmas s ON s.itemid = bdet.storeitemid 
			Inner join Itemgroup ig on ig.Itemgroupid=s.Itemgroupid
			WHERE isnull(m.Raised,0)=0 AND m.tableid=@tableid and isnull(d.cANCELORNORM,'')<>'C'
			 and isnull(SplitBillRaised,0)=0 and isnull(ig.icecreamorfood,0)=@loopthrough and isnull(m.nckot,0)=0
			  order by Kotdetid
			open kotitemsfetch001     
			FETCH NEXT FROM kotitemsfetch001 INTO @icecreamorfood, @itemid,@Kotid,@noofpax,@kotdetid,@Kotno,@Itemname,@qty,@Rate,@Amount,@Itemgroupid,@taxsetupid
			WHILE @@FETCH_STATUS = 0
			BEGIN
			 ----first loop start
			  print 'Loop Start'
			  set @itemtotal=0
	
			  ---Dicount Verification Start
			  select @disper=(select isnull(disper,0) from temp_billlist where tableid=@Tableid and itemid=@itemid 
			  and kotid=@Kotid )
			  select @disamount=(select isnull(disamount,0) from temp_billlist where tableid=@Tableid and itemid=@itemid and kotid=@Kotid )
			  select @discountreason=(select discountreason from temp_billlist where tableid=@Tableid and itemid=@itemid and kotid=@Kotid) 	 
	
			  if isnull(@disper,0) ='0.00'
			  BEGIN
			   set @disper ='0.00'
			  END
			  print '@disper'
			  print @disper
				if isnull(@disamount,0) ='0.00'
			  BEGIN
			   set @disamount =0.00
			  END
			  if @disamount !=0.00
			  BEGIN
			   set @Amount =@Amount-@disamount
			  END
	  
			  -----Dicount Verification END

			  ---Memebr fee calculation Start
			  if @noofpax =0
			  BEGIN
			   set @noofpax=1
			  END
			 declare @AditionaalCount bigint,@ItemTax numeric(12,2),@AdditionalMembershipfeeItem bigint


			  if (@FoodAmount-@Fooddisamount) ='0.00' 
			  BEGIN
				set @FeeAmount ='0'
				set @FeeTax='0'
			  END
			  else
			  BEGIN	    
				if @noofpax=1
				BEGIN
				  print 'Pax 1'
				  set @FeeAmount = (@Membershipfee/118)*100;
				  set @FeeTax = (@FeeAmount * @MembershipfeeTax) / 100;
				  set @MFee =@FeeAmount
				  set @MFeeTax=@FeeTax
				  print @MFee
				  print @MFeeTax
				END
				ELSE
				BEGIN
				  print 'Else'
				  set @AditionaalCount =@noofpax-1		  
				  print '@AditionaalCount'
				  print @AditionaalCount
				  set @AdditionalMembershipfeeItem = @AdditionalMembershipfee * @AditionaalCount	
				  print '@AdditionalMembershipfee'
				  print @AdditionalMembershipfeeItem
				  set @FeeAmount = ((@Membershipfee + @AdditionalMembershipfeeItem)/118)*100;
				  set @FeeTax = (@FeeAmount * @MembershipfeeTax) / 100;	
				  set @MFee =@FeeAmount
				  set @MFeeTax=@FeeTax
				  print '@MFeeTax'
				  print @MFeeTax
				END
		
			  END	  
			  ---Member fee calculation END
			  set @feeper=0
			  Insert into Trans_barkotbillraise_det(kotid,billid,itemid,qty,Rate,Amount,qty1,discper,discamount,taxamount,Membershipfeediscount)
			  Values(@Kotid,@Billid,@itemid,@qty,@Rate,@itemtotal,@qty,@disper,@disamount,@ItemTax,@feeper)
			  SET @refbilldetid = SCOPE_IDENTITY()
			  Insert into trans_barkotbilltax_det (refbilldetid,Amount,Percentage,taxtypeid,billid,taxid)
			  Values(@refbilldetid,@Amount,'0.00',@taxsetupid,@Billid,(select taxid from taxtype where taxtype='ITEM TOTAL'))

			print @Itemname
					---Second Loop Start
					set @ItemTax=0.00
					declare @taxid bigint,@headcode varchar(10),@percentage numeric(12,2),@Accid bigint,@totalfee numeric(12,2),@taxableamt numeric(12,2)
	  				declare @taxtotal numeric(12,2)		
					declare kotitemsfetch002 cursor for 
					select id.Accid,tx.taxid,headcode,percentage from taxsetupmas tsm
					INNER JOIN taxsetupdet tsd on tsd.taxsetupid=tsm.Taxsetupid
					inner join  taxtype tx on tx.taxid=tsd.Accid
					inner join taxsetupACdet id on id.taxsetupdetid=tsd.taxsetupdetid
					where tsm.Taxsetupid=@taxsetupid and  id.selected=1

					open kotitemsfetch002     
					FETCH NEXT FROM kotitemsfetch002 INTO  @Accid,@taxid,@headcode,@percentage
					WHILE @@FETCH_STATUS = 0
					BEGIN		
					set @taxtotal=0
					if @Accid = (select taxid from taxtype where taxtype='ITEM TOTAL')
					BEGIN
						  print 'Second Loop'				
						  if (@headcode ='CGST2' and @icecreamorfood='1')
						  Begin 
							set @totalfee =@FeeAmount+@FeeTax
							print @headcode
							if (@FoodAmount-@Fooddisamount) >0 
							BEGIN
							set @feeper=@totalfee/(@FoodAmount-@Fooddisamount);
							END
							ELSE
							BEGIN
							set @feeper=0
							END
							print @feeper
							set @feeper=@feeper*100;
							print @feeper
							set @feeper=(@Amount*@feeper)/100;
							print @feeper
							set @taxableamt=@Amount-@feeper							
						  End
						  ELSE if (@headcode ='SGST2' and @icecreamorfood='1')
						  Begin 
							set @totalfee =@FeeAmount+@FeeTax
							print @headcode
							if (@FoodAmount-@Fooddisamount) >0 
							BEGIN
							  set @feeper=@totalfee/(@FoodAmount-@Fooddisamount);
							END
							ELSE
							BEGIN
							  set @feeper=0
							END
							print @feeper
							set @feeper=@feeper*100;
							print @feeper
							set @feeper=(@Amount*@feeper)/100;
							print @feeper
							set @taxableamt=@Amount-@feeper							
						  End
						  Else if (@headcode ='SC' and @Taxexemption='1')
						  BEGIN				   	
							set @taxableamt=0								
						  END
						  else
						  BEGIN						  
						   set @taxableamt=@Amount				  
						  END				 
						  set @taxtotal=(@taxableamt*@percentage)/100; 
							Insert into trans_barkotbilltax_det (refbilldetid,Amount,Percentage,taxtypeid,billid,taxid)
							Values(@refbilldetid,@taxtotal,@percentage,@taxsetupid,@Billid,@taxid)		
								
					END
					ELSE
					BEGIN
					 print 'without item total Start'
					   print 'without item total end'
					END
					print 'tax'
					print @ItemTax
					print @taxtotal
					 set @ItemTax=(@ItemTax+@taxtotal)
					FETCH NEXT FROM kotitemsfetch002 INTO  @Accid,@taxid,@headcode,@percentage
					END
					CLOSE kotitemsfetch002
					DEALLOCATE kotitemsfetch002
					---secondloop End
					print '@feeper'
					if @icecreamorfood=0
					BEGIN
					 set @feeper=0.00
					END			
					set @itemtotal = ((@Rate*@qty)+(@ItemTax)-@disamount)
					set @masItemTotal=@masItemTotal+(@Rate*@qty)
					set @masTax=@masTax+@ItemTax
					print '@masTax'
					print @masTax
					set @totaldiscount=@totaldiscount+@disamount
				     
		
				  Update Trans_barkotbillraise_det set Amount=@itemtotal,discper=@disper,discamount=@disamount,taxamount=@ItemTax,Membershipfeediscount=@feeper where billdetid=@refbilldetid
		
				  print 'Loop End'
			----first loop End
			FETCH NEXT FROM kotitemsfetch001 INTO @icecreamorfood, @itemid,@Kotid,@noofpax,@kotdetid,@Kotno,@Itemname,@qty,@Rate,@Amount,@Itemgroupid,@taxsetupid
			END
			CLOSE kotitemsfetch001
			DEALLOCATE kotitemsfetch001
			print '@masItemTotal'
			print @masItemTotal
			print @masTax
			print '@totaldiscount'
			print @totaldiscount
			set @totalamount=(@masItemTotal+@masTax )- @totaldiscount
			set @roundoff= ROUND( @totalamount,0)-(@totalamount)

			Update Trans_barkotbillraise_mas set totalamount=ROUND((@totalamount),0),itemtotal=@masItemTotal,Salestax=@masTax,discamount=@totaldiscount,roundoff=@roundoff,Membershipfee=@MFee,MembershipfeeTax=@MFeeTax,discountreason=@discountreason where Billid=@Billid
			
						
	




			if (@masItemTotal+@masTax = 0) 
			BEGIN
				--Update tablemas set Status='S' where Tableid=@Tableid
				update Trans_BARkotBillraise_mas set Settled=1 where Billid=@Billid
			END
			--ELSE
			--BEGIN

				--Update tablemas set Status='B' where Tableid=@Tableid
			--END
			
	 
		

			  FETCH NEXT FROM loopingicecreamorfood1 INTO @loopthrough 
                END

				 Update Trans_barkot_mas set Raised=1 where Tableid=@Tableid and isnull(Raised,0)=0
			     select @Billid as id
				if (@masItemTotal+@masTax = 0) 
					BEGIN
						Update tablemas set Status='S' where Tableid=@Tableid
					END
				else
					begin
						Update tablemas set Status='B' where Tableid=@Tableid
					end
				 CLOSE loopingicecreamorfood1
                DEALLOCATE loopingicecreamorfood1
	

END


GO
alter table application_settings add kotscreenitemgroupwise bigint default 1


--changes on 09.03.2024

alter table bar_itemmmas  add itemcolor varchar(20)


alter table application_settings add enableitemcolor bigint
				
alter table application_settings add enabledefaultloginsteward bigint		

alter table application_settings add paxselectoption bigint	
					
 
GO
ALTER procedure [dbo].[kot__save__one__separate]
@tableid bigint,@counter bigint, @sessionid bigint, @tokenno bigint,@noofpax bigint,
@Employee varchar(100)
As

declare @maskotcoout bigint=0
declare @qty bigint ,@part varchar(100),@itemid bigint ,@tqty bigint,@trat numeric(12,2),
@tamt numeric(12,2), @bool bigint=0,
@iscoktail varchar(2),@storeitemid bigint,@kotid bigint,@splinstruction varchar(1000),
@kitmsg varchar(1000),
@nccoversion varchar(1000),
@Tamt1 numeric(12,2), @sum11 numeric(12,2)=0,@ncreson varchar(1000),@Employeeid bigint,@billid bigint,@mlqty bigint,
@nc bigint, @nctypeid bigint, @ncaccid bigint,@amt numeric(12,2),@rate numeric(12,2),@nckotaccounttype bigint,@nctype bigint,@separatebilll varchar(1000),
@setbool1 bigint
set @sum11=0
set @sum11=0
set @amt=0
set @setbool1=0

set @maskotcoout= (select count(*) from trans_barkot_mas)


declare kotitemsfetch170719 cursor for 

SELECT DISTINCT bid.qty ,tk2.part,tk2.Itemid,Tqty,tk2.TRat,Tamt,iscocktail,
tk2.storeitemid,Kot_Id,Splinstruction,KITMSG,tk2.NCconversionreson,bm.Mlqty,tk2.nckotaccounttype,tk2.nctype
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Stock_Itemmmas s on s.Itemid=tk2.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					inner join Barmltype bm on bm.Mlid=bid.mlid
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid
					--and isnull(tk2.Approved,0) =0
					 and  iscocktail <>'D'

open kotitemsfetch170719
set @maskotcoout= (select count(*) from trans_barkot_mas) 
set @billid= (select ident_current('Trans_BARKot_mas'))
		if(@billid >= 1 and @maskotcoout >0)
		BEGIN
			set @billid = @billid+1						
		END       

    FETCH NEXT FROM kotitemsfetch170719 INTO  @qty,@part,@itemid,@tqty,@trat,@tamt,@iscoktail,
	@storeitemid,@kotid,@splinstruction,@kitmsg,@nccoversion,@mlqty,@nckotaccounttype,@nctype
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool = 1
				set @setbool1 = 1
				
				IF(@nckotaccounttype=0)
					BEGIN
						set @nc=0
						set @nctypeid=0
						set @rate = @trat
						set @amt=@tamt
						set @ncaccid=0
					END
				ELSE
				    BEGIN
						set @nc=1
						set @nctypeid=@nctype
						set @rate = 0.00
						set @amt=0.00
						set @ncaccid=@nckotaccounttype
					END
				INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,storeitemid,
				qty1,added,tkotid,Splinstruction,KITCHENMSG,ncaccid,nckot,nctypeid)values(@part,@billid,@itemid,
				@tqty,@rate,@amt,@tableid,
				@iscoktail,@storeitemid,@tqty,0,@kotid,@splinstruction,@kitmsg,@nckotaccounttype,@nc,@nctypeid)
				INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,(@mlqty),
				ident_current('Trans_BARKot_det '))
				set	@Tamt1=@amt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
				
                    
                FETCH NEXT FROM kotitemsfetch170719 INTO @qty,@part,@itemid,@tqty,@trat,@tamt,@iscoktail,@storeitemid,
				@kotid,@splinstruction,@kitmsg,@nccoversion,@mlqty,@nckotaccounttype,@nctype
                END

									
				set @Employeeid = (select Employeeid from employee WHERE Employee=@Employee)
				set @separatebilll = (select dbo.sep_foodbill('L') )
				if(@nc =1)
					begin
						set @separatebilll = (select dbo.sep_foodbill('N') )
					end
	
	            if(@setbool1 = 1)
					begin
						INSERT INTO dbo.Trans_BARKot_mas(Refno,Raised,counterid,noofpax,part,tableid,Stwid,Kotno,Kotdate, 
						 Kottime, totalamount, rOOMORTAB,Userid,sessionid,tokenno,NCconversionreson,nckot,nctypeid,ncaccid) 
						VALUES ('','0',@counter,@noofpax,@part,@tableid,@Employeeid,
						@separatebilll,convert(VARCHAR,getdate(),101), convert(VARCHAR,getdate(),108), @sum11,'T',1,@sessionid,
						@tokenno,@ncreson,@nc,@nctypeid,@ncaccid) 
						insert into temp_billid(billid,bdate)values(IDENT_CURRENT('trans_barkot_mas'),convert(VARCHAR,getdate(),101))
					end

				
				

                CLOSE kotitemsfetch170719
                DEALLOCATE kotitemsfetch170719


declare @baritemname varchar(500),@pax bigint, @sbarstockqty bigint,@icecreamorfood bigint,@otheritems bigint,@bool1 bigint,@setbool bigint
set @bool = 0
set @sum11=0
set @sum11=0
set @amt=0
set @setbool =0

declare kotitemsfetch170720 cursor for 

SELECT DISTINCT btm.BarItemname,tk2.NCconversionreson,Splinstruction,KITMSG,
tk2.Noofpax,iscocktail,tk2.TRat,
Kot_Id,Tqty,tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,
otheritems,bid.qty,Tamt,bm.Mlqty,tk2.nckotaccounttype,tk2.nctype,tk2.storeitemid
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					inner join Barmltype bm on bm.Mlid=bid.mlid
					INNER JOIN Stock_Itemmmas s on s.Itemid=bid.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 				
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid
					and tk2.Approved ='1' 
					and iscocktail ='D'
					--and iscocktail ='Y'
					group by tk2.Itemid,btm.BarItemname,tk2.Noofpax,iscocktail,tk2.NCconversionreson,tk2.TRat,Kot_Id,Tqty,
				    TableId,tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt,Tqty,Splinstruction,
					KITMSG,bm.Mlqty,tk2.nckotaccounttype,tk2.nctype,tk2.storeitemid

open kotitemsfetch170720        

set @maskotcoout= (select count(*) from trans_barkot_mas)
set @billid= (select ident_current('Trans_BARKot_mas'))
		if(@billid >=1 and @maskotcoout >0)
		BEGIN
			set @billid = @billid+1						
		END
    FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg,@pax,
	@iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt,@mlqty,@nckotaccounttype,@nctype,@storeitemid
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool1 = 1
				set @setbool=1
				IF(@nckotaccounttype=0)
					BEGIN
						
						set @nc=0
						set @nctypeid=0
						set @rate = @trat
						set @amt=@tamt
						set @ncaccid=0
						
					END
				ELSE
				    BEGIN
					
					set @nc=1
						set @nctypeid=@nctype
						set @rate = 0.00
						set @amt=0.00
						set @ncaccid=@nckotaccounttype
						
						
					END
				

					INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,qty1,added,
					tkotid,Splinstruction,KITCHENMSG,storeitemid,nckot,ncaccid,nctypeid)values
					(@part,@billid,@itemid,@tqty,@rate,@amt,@tableid,@iscoktail,@tqty,0,@kotid,@splinstruction,
					@kitmsg,@storeitemid,@nc,@nckotaccounttype,@nctypeid ) 
					INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,(@mlqty),ident_current('Trans_BARKot_det '))

				
				

               set	@Tamt1=@amt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
                    
                FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg,@pax,
	            @iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt,@mlqty,@nckotaccounttype,@nctype,@storeitemid
                END
				set @Employeeid = (select Employeeid from employee WHERE Employee=@Employee)
				set @separatebilll = (select dbo.sep_foodbill('D') )
				if(@nc =1)
					begin
						set @separatebilll = (select dbo.sep_foodbill('N') )
					end
	
	               if(@setbool = 1)
					begin
						INSERT INTO dbo.Trans_BARKot_mas(Refno,Raised,counterid,noofpax,part,tableid,Stwid,Kotno,Kotdate, 
					  Kottime, totalamount, rOOMORTAB,Userid,sessionid,tokenno,NCconversionreson,nckot,nctypeid,ncaccid) 
					  VALUES ('','0',@counter,@noofpax,@part,@tableid,@Employeeid,
					  @separatebilll,convert(VARCHAR,getdate(),101), convert(VARCHAR,getdate(),108), @sum11,'T',1,@sessionid,
					 @tokenno,@ncreson,@nc,@nctypeid,@ncaccid)

					 insert into temp_billid(billid,bdate)values(IDENT_CURRENT('trans_barkot_mas'),convert(VARCHAR,getdate(),101))
					end
				  
				
                CLOSE kotitemsfetch170720
                DEALLOCATE kotitemsfetch170720


GO

ALTER procedure [dbo].[Exec_BillSave__separatefoodbill]
@Tableid Bigint,
@Taxexemption bigint,
@Billdate Datetime,
@Billtime Datetime,
@userid bigint
As 
BEGIN
declare @loopthrough bigint,@setcount bigint,@setbillid bigint
set @setcount =0;
declare loopingicecreamorfood1 cursor for

SELECT  isnull(ig.icecreamorfood,0)icecreamorfood FROM Trans_BARKot_mas m
				INNER JOIN Trans_BARKot_det d ON d.kotid=m.Kotid
				inner join bar_itemdet_id id on id.RefBarItemid=d.itemid
				inner join Stock_itemmmas sitm on sitm.Itemid=id.storeitemid
				inner join itemgroup ig on ig.Itemgroupid=sitm.Itemgroupid
				INNER JOIN Bar_itemmmas  i ON i.barItemid=d.itemid
				WHERE isnull(m.Raised,0)=0 AND m.tableid=@tableid and 
				isnull(d.cANCELORNORM,'')<>'C' and isnull(SplitBillRaised,0)=0 
				group by ig.icecreamorfood 
				order by ig.icecreamorfood desc
open loopingicecreamorfood1 
FETCH NEXT FROM loopingicecreamorfood1 INTO  @loopthrough
WHILE @@FETCH_STATUS = 0
Begin
	set @setcount = @setcount+1;
		declare @refbilldetid bigint, @Fooddisamount numeric(12,2), @FoodAmount numeric(12,2),@FeeAmount numeric(12,2),@FeeTax numeric(12,2)
		declare @Membershipfee numeric(12,2),@MembershipfeeTax numeric(12,2),@AdditionalMembershipfee numeric(12,2),@itemtotal numeric(12,2)
		declare @masItemTotal numeric(12,2),@masTax numeric(12,2),@roundoff numeric(12,2),@totaldiscount numeric(12,2),@totalamount numeric(12,2)
		select @Membershipfee=(select Membershipfee from application_settings)
		select @MembershipfeeTax=(select MembershipfeeTax from application_settings)
		select @AdditionalMembershipfee=(select AdditionalMembershipfee from application_settings)
		declare @disper numeric(12,2),@disamount numeric(12,2),@discountreason varchar(500),@MFee numeric(12,2),@MFeeTax numeric(12,2),
		@billno varchar(100),@billnumbercount bigint,@tcnt bigint

		    set @billno = (select dbo.sep_foodbill_raise('L') )
		    if(@loopthrough =1)
				begin
					set @billno = (select dbo.sep_foodbill_raise('D') )
				end
			
			
				

			set @masItemTotal=0.00
			set @masTax=0.00
			set @roundoff=0.00
			set @totaldiscount=0.00
			set @MFee=0
			set @MFeeTax=0
			----- mas Table Insert Star
				
				       if(@setcount =2)
						begin
							set @setbillid = (select ident_current('Trans_barkotbillraise_mas'))
						end
					
						insert into Trans_barkotbillraise_mas(Billno,Billdate,Billtime,Refdate,tableid,totalamount,itemtotal,Salestax,discamount,noofpax,Settled,rOOMORTAB,userid,roundoff,restypeid,crefno,sessionid,Reftime,Membershipfee,MembershipfeeTax,serchexception,discountreason,firstbillid)
						Values(@billno,@Billdate,@Billtime,convert(VARCHAR,getdate(),101),@Tableid,ROUND((@totalamount),0),@masItemTotal,@masTax,@totaldiscount,(select Top 1 noofpax from Trans_barkot_mas where Tableid=@Tableid and isnull(Raised,0)=0 ),0,'T',@userid,@roundoff,0,dbo.BillNo(),0,convert(VARCHAR,getdate(),108),@MFee,@MFeeTax,@Taxexemption,@discountreason,@setbillid)
						DECLARE @Billid INT
						SET @Billid = SCOPE_IDENTITY()
					----Mas Table Insert end

			select @FoodAmount = (SELECT isnull(sum(d.Amount),0) FROM Trans_BARKot_mas m
						INNER JOIN Trans_BARKot_det d ON d.kotid=m.Kotid
						inner join Trans_BarKotdet_id id on id.Refkotdetid=d.kotdetid
						inner join Stock_itemmmas sitm on sitm.Itemid=id.storeitemid
						inner join itemgroup ig on ig.Itemgroupid=sitm.Itemgroupid
						INNER JOIN Bar_itemmmas  i ON i.barItemid=d.itemid
					    WHERE isnull(m.Raised,0)=0 AND m.tableid=@Tableid and 
						isnull(d.cANCELORNORM,'')<>'C' and isnull(SplitBillRaised,0)=0 
						and isnull(ig.icecreamorfood,0)=@loopthrough  and isnull(m.nckot,0)=0 
						and isnull(d.Amount,0)<>'0'  )
			print 'Food Amout'
			print @FoodAmount
			select @Fooddisamount=(select isnull(sum(tb.disamount),0) from temp_billlist tb
							inner join Stock_itemmmas st on st.Itemid=tb.stock_id
							inner join itemgroup ig on ig.Itemgroupid=st.Itemgroupid
							where tb.tableid=@Tableid and isnull(ig.icecreamorfood,0)=@loopthrough)
			print '@Fooddisamount'
			print @Fooddisamount
			declare @icecreamorfood bigint,@itemid bigint,@Kotid bigint,@noofpax bigint,@kotdetid bigint,@Kotno Varchar(50),@Itemname varchar(500),@qty numeric(12,2),@Rate Numeric(12,2),@Amount Numeric(12,2),@taxsetupid bigint,@Itemgroupid bigint
			declare @feeper numeric(12,4)			
			set @MFee=0.00
			set @MFeeTax=0.00
			declare kotitemsfetch001 cursor for 
			SELECT ig.icecreamorfood,d.itemid,m.Kotid,m.noofpax,d.kotdetid,m.Kotno,i.barItemname AS Itemname,d.qty,d.Rate,d.Amount,s.Itemgroupid,ig.taxsetupid FROM Trans_BARKot_mas m
			INNER JOIN Trans_BARKot_det d ON d.kotid=m.Kotid
			INNER JOIN Bar_itemmmas  i ON i.barItemid=d.itemid
			INNER JOIN Bar_Itemdet_id bdet ON i.BarItemid = bdet.RefBarItemid 
			INNER JOIN Stock_Itemmmas s ON s.itemid = bdet.storeitemid 
			Inner join Itemgroup ig on ig.Itemgroupid=s.Itemgroupid
			WHERE isnull(m.Raised,0)=0 AND m.tableid=@tableid and isnull(d.cANCELORNORM,'')<>'C'
			 and isnull(SplitBillRaised,0)=0 and isnull(ig.icecreamorfood,0)=@loopthrough and isnull(m.nckot,0)=0
			  order by Kotdetid
			open kotitemsfetch001     
			FETCH NEXT FROM kotitemsfetch001 INTO @icecreamorfood, @itemid,@Kotid,@noofpax,@kotdetid,@Kotno,@Itemname,@qty,@Rate,@Amount,@Itemgroupid,@taxsetupid
			WHILE @@FETCH_STATUS = 0
			BEGIN
			 ----first loop start
			  print 'Loop Start'
			  set @itemtotal=0
	
			  ---Dicount Verification Start
			  select @disper=(select isnull(disper,0) from temp_billlist where tableid=@Tableid and itemid=@itemid 
			  and kotid=@Kotid )
			  select @disamount=(select isnull(disamount,0) from temp_billlist where tableid=@Tableid and itemid=@itemid and kotid=@Kotid )
			  select @discountreason=(select discountreason from temp_billlist where tableid=@Tableid and itemid=@itemid and kotid=@Kotid) 	 
	
			  if isnull(@disper,0) ='0.00'
			  BEGIN
			   set @disper ='0.00'
			  END
			  print '@disper'
			  print @disper
				if isnull(@disamount,0) ='0.00'
			  BEGIN
			   set @disamount =0.00
			  END
			  if @disamount !=0.00
			  BEGIN
			   set @Amount =@Amount-@disamount
			  END
	  
			  -----Dicount Verification END

			  ---Memebr fee calculation Start
			  if @noofpax =0
			  BEGIN
			   set @noofpax=1
			  END
			 declare @AditionaalCount bigint,@ItemTax numeric(12,2),@AdditionalMembershipfeeItem bigint


			  if (@FoodAmount-@Fooddisamount) ='0.00' 
			  BEGIN
				set @FeeAmount ='0'
				set @FeeTax='0'
			  END
			  else
			  BEGIN	    
				if @noofpax=1
				BEGIN
				  print 'Pax 1'
				  set @FeeAmount = (@Membershipfee/118)*100;
				  set @FeeTax = (@FeeAmount * @MembershipfeeTax) / 100;
				  set @MFee =@FeeAmount
				  set @MFeeTax=@FeeTax
				  print @MFee
				  print @MFeeTax
				END
				ELSE
				BEGIN
				  print 'Else'
				  set @AditionaalCount =@noofpax-1		  
				  print '@AditionaalCount'
				  print @AditionaalCount
				  set @AdditionalMembershipfeeItem = @AdditionalMembershipfee * @AditionaalCount	
				  print '@AdditionalMembershipfee'
				  print @AdditionalMembershipfeeItem
				  set @FeeAmount = ((@Membershipfee + @AdditionalMembershipfeeItem)/118)*100;
				  set @FeeTax = (@FeeAmount * @MembershipfeeTax) / 100;	
				  set @MFee =@FeeAmount
				  set @MFeeTax=@FeeTax
				  print '@MFeeTax'
				  print @MFeeTax
				END
		
			  END	  
			  ---Member fee calculation END
			  set @feeper=0
			  Insert into Trans_barkotbillraise_det(kotid,billid,itemid,qty,Rate,Amount,qty1,discper,discamount,taxamount,Membershipfeediscount)
			  Values(@Kotid,@Billid,@itemid,@qty,@Rate,@itemtotal,@qty,@disper,@disamount,@ItemTax,@feeper)
			  SET @refbilldetid = SCOPE_IDENTITY()
			  Insert into trans_barkotbilltax_det (refbilldetid,Amount,Percentage,taxtypeid,billid,taxid)
			  Values(@refbilldetid,@Amount,'0.00',@taxsetupid,@Billid,(select taxid from taxtype where taxtype='ITEM TOTAL'))

			print @Itemname
					---Second Loop Start
					set @ItemTax=0.00
					declare @taxid bigint,@headcode varchar(10),@percentage numeric(12,2),@Accid bigint,@totalfee numeric(12,2),@taxableamt numeric(12,2)
	  				declare @taxtotal numeric(12,2)		
					declare kotitemsfetch002 cursor for 
					select id.Accid,tx.taxid,headcode,percentage from taxsetupmas tsm
					INNER JOIN taxsetupdet tsd on tsd.taxsetupid=tsm.Taxsetupid
					inner join  taxtype tx on tx.taxid=tsd.Accid
					inner join taxsetupACdet id on id.taxsetupdetid=tsd.taxsetupdetid
					where tsm.Taxsetupid=@taxsetupid and  id.selected=1

					open kotitemsfetch002     
					FETCH NEXT FROM kotitemsfetch002 INTO  @Accid,@taxid,@headcode,@percentage
					WHILE @@FETCH_STATUS = 0
					BEGIN		
					set @taxtotal=0
					if @Accid = (select taxid from taxtype where taxtype='ITEM TOTAL')
					BEGIN
						  print 'Second Loop'				
						  if (@headcode ='CGST2' and @icecreamorfood='1')
						  Begin 
							set @totalfee =@FeeAmount+@FeeTax
							print @headcode
							if (@FoodAmount-@Fooddisamount) >0 
							BEGIN
							set @feeper=@totalfee/(@FoodAmount-@Fooddisamount);
							END
							ELSE
							BEGIN
							set @feeper=0
							END
							print @feeper
							set @feeper=@feeper*100;
							print @feeper
							set @feeper=(@Amount*@feeper)/100;
							print @feeper
							set @taxableamt=@Amount-@feeper							
						  End
						  ELSE if (@headcode ='SGST2' and @icecreamorfood='1')
						  Begin 
							set @totalfee =@FeeAmount+@FeeTax
							print @headcode
							if (@FoodAmount-@Fooddisamount) >0 
							BEGIN
							  set @feeper=@totalfee/(@FoodAmount-@Fooddisamount);
							END
							ELSE
							BEGIN
							  set @feeper=0
							END
							print @feeper
							set @feeper=@feeper*100;
							print @feeper
							set @feeper=(@Amount*@feeper)/100;
							print @feeper
							set @taxableamt=@Amount-@feeper							
						  End
						  Else if (@headcode ='SC' and @Taxexemption='1')
						  BEGIN				   	
							set @taxableamt=0								
						  END
						  else
						  BEGIN						  
						   set @taxableamt=@Amount				  
						  END				 
						  set @taxtotal=(@taxableamt*@percentage)/100; 
							Insert into trans_barkotbilltax_det (refbilldetid,Amount,Percentage,taxtypeid,billid,taxid)
							Values(@refbilldetid,@taxtotal,@percentage,@taxsetupid,@Billid,@taxid)		
								
					END
					ELSE
					BEGIN
					 print 'without item total Start'
					   print 'without item total end'
					END
					print 'tax'
					print @ItemTax
					print @taxtotal
					 set @ItemTax=(@ItemTax+@taxtotal)
					FETCH NEXT FROM kotitemsfetch002 INTO  @Accid,@taxid,@headcode,@percentage
					END
					CLOSE kotitemsfetch002
					DEALLOCATE kotitemsfetch002
					---secondloop End
					print '@feeper'
					if @icecreamorfood=0
					BEGIN
					 set @feeper=0.00
					END			
					set @itemtotal = ((@Rate*@qty)+(@ItemTax)-@disamount)
					set @masItemTotal=@masItemTotal+(@Rate*@qty)
					set @masTax=@masTax+@ItemTax
					print '@masTax'
					print @masTax
					set @totaldiscount=@totaldiscount+@disamount
				     
		
				  Update Trans_barkotbillraise_det set Amount=@itemtotal,discper=@disper,discamount=@disamount,taxamount=@ItemTax,Membershipfeediscount=@feeper where billdetid=@refbilldetid
		
				  print 'Loop End'
			----first loop End
			FETCH NEXT FROM kotitemsfetch001 INTO @icecreamorfood, @itemid,@Kotid,@noofpax,@kotdetid,@Kotno,@Itemname,@qty,@Rate,@Amount,@Itemgroupid,@taxsetupid
			END
			CLOSE kotitemsfetch001
			DEALLOCATE kotitemsfetch001
			print '@masItemTotal'
			print @masItemTotal
			print @masTax
			print '@totaldiscount'
			print @totaldiscount
			set @totalamount=(@masItemTotal+@masTax )- @totaldiscount
			set @roundoff= ROUND( @totalamount,0)-(@totalamount)

			Update Trans_barkotbillraise_mas set totalamount=ROUND((@totalamount),0),itemtotal=@masItemTotal,Salestax=@masTax,discamount=@totaldiscount,roundoff=@roundoff,Membershipfee=@MFee,MembershipfeeTax=@MFeeTax,discountreason=@discountreason where Billid=@Billid
			
						
	




			if (@masItemTotal+@masTax = 0) 
			BEGIN
				--Update tablemas set Status='S' where Tableid=@Tableid
				update Trans_BARkotBillraise_mas set Settled=1 where Billid=@Billid
			END
			--ELSE
			--BEGIN

				--Update tablemas set Status='B' where Tableid=@Tableid
			--END
			
	 
		

			  FETCH NEXT FROM loopingicecreamorfood1 INTO @loopthrough 
                END

				 Update Trans_barkot_mas set Raised=1 where Tableid=@Tableid and isnull(Raised,0)=0
			     select @Billid as id
				if (@masItemTotal+@masTax = 0) 
					BEGIN
						Update tablemas set Status='S' where Tableid=@Tableid
					END
				else
					begin
						Update tablemas set Status='B' where Tableid=@Tableid
					end
				 CLOSE loopingicecreamorfood1
                DEALLOCATE loopingicecreamorfood1
	

END


GO

ALTER  FUNCTION [dbo].[sep_foodbill] (@foodornot varchar(2))

RETURNS varchar(2000) 
AS  
BEGIN

DECLARE @STR VARCHAR(5000),@prefix varchar(1000),@start varchar(1000),@count bigint ;

if(@foodornot ='D')
	begin
		set @prefix = (select foodkotprefix from headings where restypeid='4' and resorroom='BAR')
		set @start = (select foodkotstarting from headings where restypeid='4' and resorroom='BAR')
		set @count = (select count(*) from trans_barkot_mas where isnull(nckot,0)<>1 and kotno like @prefix+'%')
		if(@count = 0)
			begin
				set @STR = @start
			end 
		else
			begin
				SET @STR=(SELECT  max(substring(Kotno,len(@prefix)+1,len(@start)))+1 
				FROM trans_barkot_mas where isnull(nckot,0)<>1)
			end

	end


if(@foodornot ='L')
	begin
		set @prefix = (select liquorkotprefix from headings where restypeid='4' and resorroom='BAR')
		set @start = (select liquorkotstarting from headings where restypeid='4' and resorroom='BAR')
		set @count = (select count(*) from trans_barkot_mas where isnull(nckot,0)<>1 and kotno like @prefix+'%')
		if(@count = 0)
			begin
				set @STR = @start
			end 
		else
			begin
				SET @STR=(SELECT  max(substring(Kotno,len(@prefix)+1,len(@start)))+1 
				FROM trans_barkot_mas where isnull(nckot,0)<>1)
			end

	end


if(@foodornot ='N')
	begin
		set @prefix = (select nckottprefix from headings where restypeid='4' and resorroom='BAR')
		set @start = (select  nckottstarting from headings where restypeid='4' and resorroom='BAR')
		set @count = (select count(*) from trans_barkot_mas where isnull(nckot,0)<>0 and kotno like @prefix+'%')
		if(@count = 0)
			begin
				set @STR = @start
			end 
		else
			begin
				SET @STR=(SELECT  max(substring(Kotno,len(@prefix)+1,len(@start)))+1 
				FROM trans_barkot_mas where isnull(nckot,0)<>1)
			end

	end


RETURN @prefix+@STR
END

ALTER  FUNCTION [dbo].[sep_foodbill_raise] (@foodornot varchar(2))

RETURNS varchar(2000) 
AS  
BEGIN

DECLARE @STR VARCHAR(5000),@prefix varchar(1000),@start varchar(1000),@count bigint ;

if(@foodornot ='D')
	begin
		set @prefix = (select foodbillprefix from headings where restypeid='4' and resorroom='BAR')
		set @start = (select foodbillstarting from headings where restypeid='4' and resorroom='BAR')
		set @count = (select count(*) from Trans_BARKotBillraise_mas where isnull(comp,0)<>1 and billno like @prefix+'%')
		if(@count = 0)
			begin
				set @STR = @start
			end 
		else
			begin
				SET @STR=(SELECT  max(substring(billno,len(@prefix)+1,len(@start)))+1 
				FROM Trans_BARKotBillraise_mas where isnull(comp,0)<>1)
			end

	end


if(@foodornot ='L')
	begin
		set @prefix = (select liquorbillprefix from headings where restypeid='4' and resorroom='BAR')
		set @start = (select liquorbillstarting from headings where restypeid='4' and resorroom='BAR')
		set @count = (select count(*) from Trans_BARKotBillraise_mas where isnull(comp,0)<>1 and billno like @prefix+'%')
		if(@count = 0)
			begin
				set @STR = @start
			end 
		else
			begin
				SET @STR=(SELECT  max(substring(billno,len(@prefix)+1,len(@start)))+1 
				FROM Trans_BARKotBillraise_mas where isnull(comp,0)<>1)
			end

	end


if(@foodornot ='N')
	begin
		set @prefix = (select ncbillprefix from headings where restypeid='4' and resorroom='BAR')
		set @start = (select  ncbillstarting from headings where restypeid='4' and resorroom='BAR')
		set @count = (select count(*) from Trans_BARKotBillraise_mas where isnull(comp,0)<>0 and billno like @prefix+'%')
		if(@count = 0)
			begin
				set @STR = @start
			end 
		else
			begin
				SET @STR=(SELECT  max(substring(billno,len(@prefix)+1,len(@start)))+1 
				FROM Trans_BARKotBillraise_mas where isnull(comp,0)<>1)
			end

	end


RETURN @prefix+@STR
END






GO

					
					
 











					
 







---new changes on 09.03.2024

ALTER Procedure [dbo].[Get_ItemGroup] @ID BIGINT=0 as BEGIN 
Select ig.inactive,taxsetupname,itemcategory,ig.Itemgroupid,ig.Itemgroup,ig.ORDBY,
ig.percentage,ig.nccostperc,ig.Itemcategoryid,ig.taxsetupid,ig.Barorfood,ig.Itemgroup,
ig.isimport,ig.icecreamorfood,ig.hotitems,ig.beeritems,ig.otheritems,ig.printerpath from itemgroup ig
inner join  Itemcategory ic on ic.itemcategoryid=ig.Itemcategoryid
inner join taxsetupmas tsm on tsm.Taxsetupid=ig.taxsetupid
WHERE Itemgroupid  =(CASE WHEN @ID=0 THEN itemgroupid ELSE @ID END ) order by Itemgroupid desc END


--changes on 11.03.2024

USE [elanzambar]
GO
/****** Object:  UserDefinedFunction [dbo].[sep_foodbill]    Script Date: 11/03/2024 10:26:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER  FUNCTION [dbo].[sep_foodbill] (@foodornot varchar(2))

RETURNS varchar(2000) 
AS  
BEGIN

DECLARE @STR VARCHAR(5000),@prefix varchar(1000),@start varchar(1000),@count bigint ;

if(@foodornot ='D')
	begin
		set @prefix = (select foodkotprefix from headings where restypeid='4' and resorroom='BAR')
		set @start = (select foodkotstarting from headings where restypeid='4' and resorroom='BAR')
		set @count = (select count(*) from trans_barkot_mas where isnull(nckot,0)<>1 and kotno like @prefix+'%')
		if(@count = 0)
			begin
				set @STR = @start
			end 
		else
			begin
				SET @STR=(SELECT  max(substring(Kotno,len(@prefix)+1,len(@start)))+1 
				FROM trans_barkot_mas where isnull(nckot,0)<>1)
			end

	end


if(@foodornot ='L')
	begin
		set @prefix = (select liquorkotprefix from headings where restypeid='4' and resorroom='BAR')
		set @start = (select liquorkotstarting from headings where restypeid='4' and resorroom='BAR')
		set @count = (select count(*) from trans_barkot_mas where isnull(nckot,0)<>1 and kotno like @prefix+'%')
		if(@count = 0)
			begin
				set @STR = @start
			end 
		else
			begin
				SET @STR=(SELECT  max(substring(Kotno,len(@prefix)+1,len(@start)))+1 
				FROM trans_barkot_mas where isnull(nckot,0)<>1)
			end

	end


if(@foodornot ='N')
	begin
		set @prefix = (select nckottprefix from headings where restypeid='4' and resorroom='BAR')
		set @start = (select  nckottstarting from headings where restypeid='4' and resorroom='BAR')
		set @count = (select count(*) from trans_barkot_mas where isnull(nckot,0)<>0 and kotno like @prefix+'%')
		if(@count = 0)
			begin
				set @STR = @start
			end 
		else
			begin
				SET @STR=(SELECT  max(substring(Kotno,len(@prefix)+1,len(@start)))+1 
				FROM trans_barkot_mas where isnull(nckot,0)<>0)
			end

	end


RETURN @prefix+@STR
END



USE [elanzambar]
GO
/****** Object:  UserDefinedFunction [dbo].[sep_foodbill_raise]    Script Date: 11/03/2024 13:09:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER  FUNCTION [dbo].[sep_foodbill_raise] (@foodornot varchar(2))

RETURNS varchar(2000) 
AS  
BEGIN

DECLARE @STR VARCHAR(5000),@prefix varchar(1000),@start varchar(1000),@count bigint ;

if(@foodornot ='D')
	begin
		set @prefix = (select foodbillprefix from headings where restypeid='4' and resorroom='BAR')
		set @start = (select foodbillstarting from headings where restypeid='4' and resorroom='BAR')
		set @count = (select count(*) from Trans_BARKotBillraise_mas where isnull(comp,0)<>1 and billno like @prefix+'%')
		if(@count = 0)
			begin
				set @STR = @start
			end 
		else
			begin
				SET @STR=(SELECT  max(substring(billno,len(@prefix)+1,len(@start)))+1 
				FROM Trans_BARKotBillraise_mas where isnull(comp,0)<>1)
			end

	end


if(@foodornot ='L')
	begin
		set @prefix = (select liquorbillprefix from headings where restypeid='4' and resorroom='BAR')
		set @start = (select liquorbillstarting from headings where restypeid='4' and resorroom='BAR')
		set @count = (select count(*) from Trans_BARKotBillraise_mas where isnull(comp,0)<>1 and billno like @prefix+'%')
		if(@count = 0)
			begin
				set @STR = @start
			end 
		else
			begin
				SET @STR=(SELECT  max(substring(billno,len(@prefix)+1,len(@start)))+1 
				FROM Trans_BARKotBillraise_mas where isnull(comp,0)<>1)
			end

	end


if(@foodornot ='N')
	begin
		set @prefix = (select ncbillprefix from headings where restypeid='4' and resorroom='BAR')
		set @start = (select  ncbillstarting from headings where restypeid='4' and resorroom='BAR')
		set @count = (select count(*) from Trans_BARKotBillraise_mas where isnull(comp,0)<>0 and billno like @prefix+'%')
		if(@count = 0)
			begin
				set @STR = @start
			end 
		else
			begin
				SET @STR=(SELECT  max(substring(billno,len(@prefix)+1,len(@start)))+1 
				FROM Trans_BARKotBillraise_mas where isnull(comp,0)<>0)
			end

	end


RETURN @prefix+@STR
END

GO
alter table application_settings add separatefoodbill bigint

USE [elanzambar]
GO
/****** Object:  StoredProcedure [dbo].[Exec_BillSave__separatefoodbill]    Script Date: 11/03/2024 12:24:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
alter procedure [dbo].[Exec_BillSave__separatefoodbill__nc]
@Tableid Bigint,
@Taxexemption bigint,
@Billdate Datetime,
@Billtime Datetime,
@userid bigint
As 
BEGIN
declare @loopthrough bigint,@setcount bigint,@setbillid bigint
set @setcount =0;
declare loopingicecreamorfood1 cursor for

SELECT  isnull(ig.icecreamorfood,0)icecreamorfood FROM Trans_BARKot_mas m
				INNER JOIN Trans_BARKot_det d ON d.kotid=m.Kotid
				inner join bar_itemdet_id id on id.RefBarItemid=d.itemid
				inner join Stock_itemmmas sitm on sitm.Itemid=id.storeitemid
				inner join itemgroup ig on ig.Itemgroupid=sitm.Itemgroupid
				INNER JOIN Bar_itemmmas  i ON i.barItemid=d.itemid
				WHERE isnull(m.Raised,0)=0 AND m.tableid=@tableid and 
				isnull(d.cANCELORNORM,'')<>'C' and isnull(SplitBillRaised,0)=0 
				group by ig.icecreamorfood 
				order by ig.icecreamorfood desc
open loopingicecreamorfood1 
FETCH NEXT FROM loopingicecreamorfood1 INTO  @loopthrough
WHILE @@FETCH_STATUS = 0
Begin
	set @setcount = @setcount+1;
		declare @refbilldetid bigint, @Fooddisamount numeric(12,2), @FoodAmount numeric(12,2),@FeeAmount numeric(12,2),@FeeTax numeric(12,2)
		declare @Membershipfee numeric(12,2),@MembershipfeeTax numeric(12,2),@AdditionalMembershipfee numeric(12,2),@itemtotal numeric(12,2)
		declare @masItemTotal numeric(12,2),@masTax numeric(12,2),@roundoff numeric(12,2),@totaldiscount numeric(12,2),@totalamount numeric(12,2)
		select @Membershipfee=(select Membershipfee from application_settings)
		select @MembershipfeeTax=(select MembershipfeeTax from application_settings)
		select @AdditionalMembershipfee=(select AdditionalMembershipfee from application_settings)
		declare @disper numeric(12,2),@disamount numeric(12,2),@discountreason varchar(500),@MFee numeric(12,2),@MFeeTax numeric(12,2),
		@billno varchar(100),@billnumbercount bigint,@tcnt bigint

		    set @billno = (select dbo.sep_foodbill_raise('N') )
		    		

			set @masItemTotal=0.00
			set @masTax=0.00
			set @roundoff=0.00
			set @totaldiscount=0.00
			set @MFee=0
			set @MFeeTax=0
			----- mas Table Insert Star
				
				       if(@setcount =2)
						begin
							set @setbillid = (select ident_current('Trans_barkotbillraise_mas'))
						end
					
						insert into Trans_barkotbillraise_mas(Billno,Billdate,Billtime,Refdate,tableid,totalamount,itemtotal,
						Salestax,discamount,noofpax,Settled,rOOMORTAB,userid,roundoff,restypeid,crefno,sessionid,Reftime,
						Membershipfee,MembershipfeeTax,serchexception,discountreason,firstbillid)
						Values(@billno,@Billdate,@Billtime,convert(VARCHAR,getdate(),101),@Tableid,ROUND((@totalamount),0),
						@masItemTotal,@masTax,@totaldiscount,(select Top 1 noofpax from Trans_barkot_mas where Tableid=@Tableid 
						and isnull(Raised,0)=0 ),0,'T',@userid,@roundoff,0,@billno,0,convert(VARCHAR,getdate(),108),@MFee,@MFeeTax,@Taxexemption,@discountreason,@setbillid)
						DECLARE @Billid INT
						SET @Billid = SCOPE_IDENTITY()
					----Mas Table Insert end

			select @FoodAmount = (SELECT isnull(sum(d.Amount),0) FROM Trans_BARKot_mas m
						INNER JOIN Trans_BARKot_det d ON d.kotid=m.Kotid
						inner join Trans_BarKotdet_id id on id.Refkotdetid=d.kotdetid
						inner join Stock_itemmmas sitm on sitm.Itemid=id.storeitemid
						inner join itemgroup ig on ig.Itemgroupid=sitm.Itemgroupid
						INNER JOIN Bar_itemmmas  i ON i.barItemid=d.itemid
					    WHERE isnull(m.Raised,0)=0 AND m.tableid=@Tableid and 
						isnull(d.cANCELORNORM,'')<>'C' and isnull(SplitBillRaised,0)=0 
						and isnull(ig.icecreamorfood,0)=@loopthrough  and isnull(m.nckot,0)=1 
						and isnull(d.Amount,0)<>'0'  )
			print 'Food Amout'
			print @FoodAmount
			select @Fooddisamount=(select isnull(sum(tb.disamount),0) from temp_billlist tb
							inner join Stock_itemmmas st on st.Itemid=tb.stock_id
							inner join itemgroup ig on ig.Itemgroupid=st.Itemgroupid
							where tb.tableid=@Tableid and isnull(ig.icecreamorfood,0)=@loopthrough)
			print '@Fooddisamount'
			print @Fooddisamount
			declare @icecreamorfood bigint,@itemid bigint,@Kotid bigint,@noofpax bigint,@kotdetid bigint,@Kotno Varchar(50),@Itemname varchar(500),@qty numeric(12,2),@Rate Numeric(12,2),@Amount Numeric(12,2),@taxsetupid bigint,@Itemgroupid bigint
			declare @feeper numeric(12,4)			
			set @MFee=0.00
			set @MFeeTax=0.00
			declare kotitemsfetch001 cursor for 
			SELECT ig.icecreamorfood,d.itemid,m.Kotid,m.noofpax,d.kotdetid,m.Kotno,i.barItemname AS Itemname,d.qty,d.Rate,d.Amount,s.Itemgroupid,ig.taxsetupid FROM Trans_BARKot_mas m
			INNER JOIN Trans_BARKot_det d ON d.kotid=m.Kotid
			INNER JOIN Bar_itemmmas  i ON i.barItemid=d.itemid
			INNER JOIN Bar_Itemdet_id bdet ON i.BarItemid = bdet.RefBarItemid 
			INNER JOIN Stock_Itemmmas s ON s.itemid = bdet.storeitemid 
			Inner join Itemgroup ig on ig.Itemgroupid=s.Itemgroupid
			WHERE isnull(m.Raised,0)=0 AND m.tableid=@tableid and isnull(d.cANCELORNORM,'')<>'C'
			 and isnull(SplitBillRaised,0)=0 and isnull(ig.icecreamorfood,0)=@loopthrough and isnull(m.nckot,0)=1
			  order by Kotdetid
			open kotitemsfetch001     
			FETCH NEXT FROM kotitemsfetch001 INTO @icecreamorfood, @itemid,@Kotid,@noofpax,@kotdetid,@Kotno,@Itemname,@qty,@Rate,@Amount,@Itemgroupid,@taxsetupid
			WHILE @@FETCH_STATUS = 0
			BEGIN
			 ----first loop start
			  print 'Loop Start'
			  set @itemtotal=0
	
			  ---Dicount Verification Start
			  select @disper=(select isnull(disper,0) from temp_billlist where tableid=@Tableid and itemid=@itemid 
			  and kotid=@Kotid )
			  select @disamount=(select isnull(disamount,0) from temp_billlist where tableid=@Tableid and itemid=@itemid and kotid=@Kotid )
			  select @discountreason=(select discountreason from temp_billlist where tableid=@Tableid and itemid=@itemid and kotid=@Kotid) 	 
	
			  if isnull(@disper,0) ='0.00'
			  BEGIN
			   set @disper ='0.00'
			  END
			  print '@disper'
			  print @disper
				if isnull(@disamount,0) ='0.00'
			  BEGIN
			   set @disamount =0.00
			  END
			  if @disamount !=0.00
			  BEGIN
			   set @Amount =@Amount-@disamount
			  END
	  
			  -----Dicount Verification END

			  ---Memebr fee calculation Start
			  if @noofpax =0
			  BEGIN
			   set @noofpax=1
			  END
			 declare @AditionaalCount bigint,@ItemTax numeric(12,2),@AdditionalMembershipfeeItem bigint


			  if (@FoodAmount-@Fooddisamount) ='0.00' 
			  BEGIN
				set @FeeAmount ='0'
				set @FeeTax='0'
			  END
			  else
			  BEGIN	    
				if @noofpax=1
				BEGIN
				  print 'Pax 1'
				  set @FeeAmount = (@Membershipfee/118)*100;
				  set @FeeTax = (@FeeAmount * @MembershipfeeTax) / 100;
				  set @MFee =@FeeAmount
				  set @MFeeTax=@FeeTax
				  print @MFee
				  print @MFeeTax
				END
				ELSE
				BEGIN
				  print 'Else'
				  set @AditionaalCount =@noofpax-1		  
				  print '@AditionaalCount'
				  print @AditionaalCount
				  set @AdditionalMembershipfeeItem = @AdditionalMembershipfee * @AditionaalCount	
				  print '@AdditionalMembershipfee'
				  print @AdditionalMembershipfeeItem
				  set @FeeAmount = ((@Membershipfee + @AdditionalMembershipfeeItem)/118)*100;
				  set @FeeTax = (@FeeAmount * @MembershipfeeTax) / 100;	
				  set @MFee =@FeeAmount
				  set @MFeeTax=@FeeTax
				  print '@MFeeTax'
				  print @MFeeTax
				END
		
			  END	  
			  ---Member fee calculation END
			  set @feeper=0
			  Insert into Trans_barkotbillraise_det(kotid,billid,itemid,qty,Rate,Amount,qty1,discper,discamount,taxamount,Membershipfeediscount)
			  Values(@Kotid,@Billid,@itemid,@qty,@Rate,@itemtotal,@qty,@disper,@disamount,@ItemTax,@feeper)
			  SET @refbilldetid = SCOPE_IDENTITY()
			  Insert into trans_barkotbilltax_det (refbilldetid,Amount,Percentage,taxtypeid,billid,taxid)
			  Values(@refbilldetid,@Amount,'0.00',@taxsetupid,@Billid,(select taxid from taxtype where taxtype='ITEM TOTAL'))

			print @Itemname
					---Second Loop Start
					set @ItemTax=0.00
					declare @taxid bigint,@headcode varchar(10),@percentage numeric(12,2),@Accid bigint,@totalfee numeric(12,2),@taxableamt numeric(12,2)
	  				declare @taxtotal numeric(12,2)		
					declare kotitemsfetch002 cursor for 
					select id.Accid,tx.taxid,headcode,percentage from taxsetupmas tsm
					INNER JOIN taxsetupdet tsd on tsd.taxsetupid=tsm.Taxsetupid
					inner join  taxtype tx on tx.taxid=tsd.Accid
					inner join taxsetupACdet id on id.taxsetupdetid=tsd.taxsetupdetid
					where tsm.Taxsetupid=@taxsetupid and  id.selected=1

					open kotitemsfetch002     
					FETCH NEXT FROM kotitemsfetch002 INTO  @Accid,@taxid,@headcode,@percentage
					WHILE @@FETCH_STATUS = 0
					BEGIN		
					set @taxtotal=0
					if @Accid = (select taxid from taxtype where taxtype='ITEM TOTAL')
					BEGIN
						  print 'Second Loop'				
						  if (@headcode ='CGST2' and @icecreamorfood='1')
						  Begin 
							set @totalfee =@FeeAmount+@FeeTax
							print @headcode
							if (@FoodAmount-@Fooddisamount) >0 
							BEGIN
							set @feeper=@totalfee/(@FoodAmount-@Fooddisamount);
							END
							ELSE
							BEGIN
							set @feeper=0
							END
							print @feeper
							set @feeper=@feeper*100;
							print @feeper
							set @feeper=(@Amount*@feeper)/100;
							print @feeper
							set @taxableamt=@Amount-@feeper							
						  End
						  ELSE if (@headcode ='SGST2' and @icecreamorfood='1')
						  Begin 
							set @totalfee =@FeeAmount+@FeeTax
							print @headcode
							if (@FoodAmount-@Fooddisamount) >0 
							BEGIN
							  set @feeper=@totalfee/(@FoodAmount-@Fooddisamount);
							END
							ELSE
							BEGIN
							  set @feeper=0
							END
							print @feeper
							set @feeper=@feeper*100;
							print @feeper
							set @feeper=(@Amount*@feeper)/100;
							print @feeper
							set @taxableamt=@Amount-@feeper							
						  End
						  Else if (@headcode ='SC' and @Taxexemption='1')
						  BEGIN				   	
							set @taxableamt=0								
						  END
						  else
						  BEGIN						  
						   set @taxableamt=@Amount				  
						  END				 
						  set @taxtotal=(@taxableamt*@percentage)/100; 
							Insert into trans_barkotbilltax_det (refbilldetid,Amount,Percentage,taxtypeid,billid,taxid)
							Values(@refbilldetid,@taxtotal,@percentage,@taxsetupid,@Billid,@taxid)		
								
					END
					ELSE
					BEGIN
					 print 'without item total Start'
					   print 'without item total end'
					END
					print 'tax'
					print @ItemTax
					print @taxtotal
					 set @ItemTax=(@ItemTax+@taxtotal)
					FETCH NEXT FROM kotitemsfetch002 INTO  @Accid,@taxid,@headcode,@percentage
					END
					CLOSE kotitemsfetch002
					DEALLOCATE kotitemsfetch002
					---secondloop End
					print '@feeper'
					if @icecreamorfood=0
					BEGIN
					 set @feeper=0.00
					END			
					set @itemtotal = ((@Rate*@qty)+(@ItemTax)-@disamount)
					set @masItemTotal=@masItemTotal+(@Rate*@qty)
					set @masTax=@masTax+@ItemTax
					print '@masTax'
					print @masTax
					set @totaldiscount=@totaldiscount+@disamount
				     
		
				  Update Trans_barkotbillraise_det set Amount=@itemtotal,discper=@disper,discamount=@disamount,taxamount=@ItemTax,Membershipfeediscount=@feeper where billdetid=@refbilldetid
		
				  print 'Loop End'
			----first loop End
			FETCH NEXT FROM kotitemsfetch001 INTO @icecreamorfood, @itemid,@Kotid,@noofpax,@kotdetid,@Kotno,@Itemname,@qty,@Rate,@Amount,@Itemgroupid,@taxsetupid
			END
			CLOSE kotitemsfetch001
			DEALLOCATE kotitemsfetch001
			print '@masItemTotal'
			print @masItemTotal
			print @masTax
			print '@totaldiscount'
			print @totaldiscount
			set @totalamount=(@masItemTotal+@masTax )- @totaldiscount
			set @roundoff= ROUND( @totalamount,0)-(@totalamount)

			Update Trans_barkotbillraise_mas set comp=1,complimentry=1,compliment=1,totalamount=ROUND((@totalamount),0),itemtotal=@masItemTotal,Salestax=@masTax,discamount=@totaldiscount,roundoff=@roundoff,Membershipfee=@MFee,MembershipfeeTax=@MFeeTax,discountreason=@discountreason where Billid=@Billid
			
						
	




			if (@masItemTotal+@masTax = 0) 
			BEGIN
				--Update tablemas set Status='S' where Tableid=@Tableid
				update Trans_BARkotBillraise_mas set Settled=1 where Billid=@Billid
			END
			--ELSE
			--BEGIN

				--Update tablemas set Status='B' where Tableid=@Tableid
			--END
			
	 
		

			  FETCH NEXT FROM loopingicecreamorfood1 INTO @loopthrough 
                END

				 Update Trans_barkot_mas set Raised=1 where Tableid=@Tableid and isnull(Raised,0)=0
			     select @Billid as id
				if (@masItemTotal+@masTax = 0) 
					BEGIN
						Update tablemas set Status='S' where Tableid=@Tableid
					END
				else
					begin
						Update tablemas set Status='B' where Tableid=@Tableid
					end
				 CLOSE loopingicecreamorfood1
                DEALLOCATE loopingicecreamorfood1
	
---	select ident_current('Trans_barkotbillraise_mas') as ncbillid
END

---- changes on 13.03.2024


ALTER  FUNCTION [dbo].[sep_foodbill] (@foodornot varchar(2))

RETURNS varchar(2000) 
AS  
BEGIN

DECLARE @STR VARCHAR(5000),@prefix varchar(1000),@start varchar(1000),@count bigint ;


if(@foodornot ='D')
	begin
		set @prefix = (select foodkotprefix from headings where restypeid='4' and resorroom='BAR')
		set @start = (select foodkotstarting from headings where restypeid='4' and resorroom='BAR')

		set @STR =(SELECT case when isnull(RIGHT('00000'+convert(VARCHAR(10),
max(substring(kotno,4,5))+1),5),'') <> '' 
then isnull(RIGHT('00000'+convert(VARCHAR(10),max(substring(kotno,4,5))+1),5),'')
 else concat('0000',@start) end from trans_barkot_mas where isnull(nckot,0)<>1 and kotno like @prefix+'%')
		--set @count = (select count(*) from trans_barkot_mas where isnull(nckot,0)<>1 and kotno like @prefix+'%')
		--if(@count = 0)
			--begin
				--set @STR = @start
			--end 
		--else
			---begin
				--SET @STR=(SELECT  max(substring(Kotno,len(@prefix)+1,len(@start)))+1 
				--FROM trans_barkot_mas where isnull(nckot,0)<>1)
			--end

	end


if(@foodornot ='L')
	begin
		set @prefix = (select liquorkotprefix from headings where restypeid='4' and resorroom='BAR')
		set @start = (select liquorkotstarting from headings where restypeid='4' and resorroom='BAR')
		
		
		set @STR =(SELECT case when isnull(RIGHT('00000'+convert(VARCHAR(10),
		max(substring(kotno,4,5))+1),5),'') <> '' 
		then isnull(RIGHT('00000'+convert(VARCHAR(10),max(substring(kotno,4,5))+1),5),'')
		else concat('0000',@start) end from trans_barkot_mas where isnull(nckot,0)<>1
		 and kotno like @prefix+'%')
		--set @count = (select count(*) from trans_barkot_mas where isnull(nckot,0)<>1 and kotno like @prefix+'%')
		--if(@count = 0)
			--begin
				--set @STR = @start
			--end 
		--else
			--begin
				--SET @STR=(SELECT  max(substring(Kotno,len(@prefix)+1,len(@start)))+1 
				--FROM trans_barkot_mas where isnull(nckot,0)<>1)
			--end

	end


if(@foodornot ='N')
	begin
		set @prefix = (select nckottprefix from headings where restypeid='4' and resorroom='BAR')
		set @start = (select  nckottstarting from headings where restypeid='4' and resorroom='BAR')
		set @STR =(SELECT case when isnull(RIGHT('00000'+convert(VARCHAR(10),
		max(substring(kotno,4,5))+1),5),'') <> '' 
		then isnull(RIGHT('00000'+convert(VARCHAR(10),max(substring(kotno,4,5))+1),5),'')
		else concat('0000',@start) end from trans_barkot_mas where isnull(nckot,0)<>0
		 and kotno like @prefix+'%')
		--set @count = (select count(*) from trans_barkot_mas where isnull(nckot,0)<>0 and kotno like @prefix+'%')
		--if(@count = 0)
			--begin
				--set @STR = @start
			--end 
		--else
			--begin
				--SET @STR=(SELECT  max(substring(Kotno,len(@prefix)+1,len(@start)))+1 
				--FROM trans_barkot_mas where isnull(nckot,0)<>0)
			--end

	end
	 
RETURN @prefix+@STR
END





USE [elanzabar]
GO
/****** Object:  UserDefinedFunction [dbo].[sep_foodbill_raise]    Script Date: 13/03/2024 16:24:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER  FUNCTION [dbo].[sep_foodbill_raise] (@foodornot varchar(2))

RETURNS varchar(2000) 
AS  
BEGIN

DECLARE @STR VARCHAR(5000),@prefix varchar(1000),@start varchar(1000),@count bigint ;

if(@foodornot ='D')
	begin
		set @prefix = (select foodbillprefix from headings where restypeid='4' and resorroom='BAR')
		set @start = (select foodbillstarting from headings where restypeid='4' and resorroom='BAR')
		
		set @STR =(SELECT case when isnull(RIGHT('00000'+convert(VARCHAR(10),
		max(substring(billno,4,5))+1),5),'') <> '' 
		then isnull(RIGHT('00000'+convert(VARCHAR(10),max(substring(billno,4,5))+1),5),'')
			else concat('0000',@start) end FROM Trans_BARKotBillraise_mas
			 where isnull(comp,0)<>1 and billno like @prefix+'%')
		--set @count = (select count(*) from Trans_BARKotBillraise_mas where isnull(comp,0)<>1 and billno like @prefix+'%')
		--if(@count = 0)
			--begin
				--set @STR = @start
			--end 
		--else
			--begin
				--SET @STR=(SELECT  max(substring(billno,len(@prefix)+1,len(@start)))+1 
				--FROM Trans_BARKotBillraise_mas where isnull(comp,0)<>1)
			--end

	end


if(@foodornot ='L')
	begin
		set @prefix = (select liquorbillprefix from headings where restypeid='4' and resorroom='BAR')
		set @start = (select liquorbillstarting from headings where restypeid='4' and resorroom='BAR')
		set @STR =(SELECT case when isnull(RIGHT('00000'+convert(VARCHAR(10),
		max(substring(billno,4,5))+1),5),'') <> '' 
		then isnull(RIGHT('00000'+convert(VARCHAR(10),max(substring(billno,4,5))+1),5),'')
			else concat('0000',@start) end FROM Trans_BARKotBillraise_mas
			 where isnull(comp,0)<>1 and billno like @prefix+'%')
		--set @count = (select count(*) from Trans_BARKotBillraise_mas where isnull(comp,0)<>1 and billno like @prefix+'%')
		--if(@count = 0)
			--begin
				--set @STR = @start
			--end 
		--else
			--begin
				--SET @STR=(SELECT  max(substring(billno,len(@prefix)+1,len(@start)))+1 
				--FROM Trans_BARKotBillraise_mas where isnull(comp,0)<>1)
			--end

	end


if(@foodornot ='N')
	begin
		set @prefix = (select ncbillprefix from headings where restypeid='4' and resorroom='BAR')
		set @start = (select  ncbillstarting from headings where restypeid='4' and resorroom='BAR')
		set @STR =(SELECT case when isnull(RIGHT('00000'+convert(VARCHAR(10),
		max(substring(billno,4,5))+1),5),'') <> '' 
		then isnull(RIGHT('00000'+convert(VARCHAR(10),max(substring(billno,4,5))+1),5),'')
			else concat('0000',@start) end FROM Trans_BARKotBillraise_mas
			 where isnull(comp,0)<>0 and billno like @prefix+'%')
		--set @count = (select count(*) from Trans_BARKotBillraise_mas where isnull(comp,0)<>0 and billno like @prefix+'%')
		--if(@count = 0)
			--begin
				--set @STR = @start
			--end 
		--else
			--begin
				--SET @STR=(SELECT  max(substring(billno,len(@prefix)+1,len(@start)))+1 
				--FROM Trans_BARKotBillraise_mas where isnull(comp,0)<>0)
			--end

	end


RETURN @prefix+@STR
END





--changes on 15.03.2024

USE [elanzabar]
GO
/****** Object:  StoredProcedure [dbo].[kot__save__one__separate]    Script Date: 16/03/2024 19:52:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[kot__save__one__separate]
@tableid bigint,@counter bigint, @sessionid bigint, @tokenno bigint,@noofpax bigint,
@Employee varchar(100),@date datetime, @time datetime
As

declare @maskotcoout bigint=0
declare @qty bigint ,@part varchar(100),@itemid bigint ,@tqty bigint,@trat numeric(12,2),
@tamt numeric(12,2), @bool bigint=0,
@iscoktail varchar(2),@storeitemid bigint,@kotid bigint,@splinstruction varchar(1000),
@kitmsg varchar(1000),
@nccoversion varchar(1000),
@Tamt1 numeric(12,2), @sum11 numeric(12,2)=0,@ncreson varchar(1000),@Employeeid bigint,@billid bigint,@mlqty bigint,
@nc bigint, @nctypeid bigint, @ncaccid bigint,@amt numeric(12,2),@rate numeric(12,2),@nckotaccounttype bigint,@nctype bigint,@separatebilll varchar(1000),
@setbool1 bigint
set @sum11=0
set @sum11=0
set @amt=0
set @setbool1=0

set @maskotcoout= (select count(*) from trans_barkot_mas)


declare kotitemsfetch170719 cursor for 

SELECT DISTINCT bid.qty ,tk2.part,tk2.Itemid,Tqty,tk2.TRat,Tamt,iscocktail,
tk2.storeitemid,Kot_Id,Splinstruction,KITMSG,tk2.NCconversionreson,bm.Mlqty,tk2.nckotaccounttype,tk2.nctype
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Stock_Itemmmas s on s.Itemid=tk2.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					inner join Barmltype bm on bm.Mlid=bid.mlid
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid
					--and isnull(tk2.Approved,0) =0
					 and  iscocktail <>'D'

open kotitemsfetch170719
set @maskotcoout= (select count(*) from trans_barkot_mas) 
set @billid= (select ident_current('Trans_BARKot_mas'))
		if(@billid >= 1 and @maskotcoout >0)
		BEGIN
			set @billid = @billid+1						
		END       

    FETCH NEXT FROM kotitemsfetch170719 INTO  @qty,@part,@itemid,@tqty,@trat,@tamt,@iscoktail,
	@storeitemid,@kotid,@splinstruction,@kitmsg,@nccoversion,@mlqty,@nckotaccounttype,@nctype
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool = 1
				set @setbool1 = 1
				
				IF(@nckotaccounttype=0)
					BEGIN
						set @nc=0
						set @nctypeid=0
						set @rate = @trat
						set @amt=@tamt
						set @ncaccid=0
					END
				ELSE
				    BEGIN
						set @nc=1
						set @nctypeid=@nctype
						set @rate = 0.00
						set @amt=0.00
						set @ncaccid=@nckotaccounttype
					END
				INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,storeitemid,
				qty1,added,tkotid,Splinstruction,KITCHENMSG,ncaccid,nckot,nctypeid)values(@part,@billid,@itemid,
				@tqty,@rate,@amt,@tableid,
				@iscoktail,@storeitemid,@tqty,0,@kotid,@splinstruction,@kitmsg,@nckotaccounttype,@nc,@nctypeid)
				INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,(@mlqty),
				ident_current('Trans_BARKot_det '))
				set	@Tamt1=@amt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
				
                    
                FETCH NEXT FROM kotitemsfetch170719 INTO @qty,@part,@itemid,@tqty,@trat,@tamt,@iscoktail,@storeitemid,
				@kotid,@splinstruction,@kitmsg,@nccoversion,@mlqty,@nckotaccounttype,@nctype
                END

									
				set @Employeeid = (select Employeeid from employee WHERE Employee=@Employee)
				set @separatebilll = (select dbo.sep_foodbill('L') )
				if(@nc =1)
					begin
						set @separatebilll = (select dbo.sep_foodbill('N') )
					end
	
	            if(@setbool1 = 1)
					begin
						INSERT INTO dbo.Trans_BARKot_mas(Refno,Raised,counterid,noofpax,part,tableid,Stwid,Kotno,Kotdate, 
						 Kottime, totalamount, rOOMORTAB,Userid,sessionid,tokenno,NCconversionreson,nckot,nctypeid,ncaccid) 
						VALUES ('','0',@counter,@noofpax,@part,@tableid,@Employeeid,
						@separatebilll,convert(VARCHAR,@date,101), convert(VARCHAR,@time,108), @sum11,'T',1,@sessionid,
						@tokenno,@ncreson,@nc,@nctypeid,@ncaccid) 
						insert into temp_billid(billid,bdate)values(IDENT_CURRENT('trans_barkot_mas'),convert(VARCHAR,@date,101))
					end

				
				

                CLOSE kotitemsfetch170719
                DEALLOCATE kotitemsfetch170719


declare @baritemname varchar(500),@pax bigint, @sbarstockqty bigint,@icecreamorfood bigint,@otheritems bigint,@bool1 bigint,@setbool bigint
set @bool = 0
set @sum11=0
set @sum11=0
set @amt=0
set @setbool =0

declare kotitemsfetch170720 cursor for 

SELECT DISTINCT btm.BarItemname,tk2.NCconversionreson,Splinstruction,KITMSG,
tk2.Noofpax,iscocktail,tk2.TRat,
Kot_Id,Tqty,tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,
otheritems,bid.qty,Tamt,bm.Mlqty,tk2.nckotaccounttype,tk2.nctype,tk2.storeitemid
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					inner join Barmltype bm on bm.Mlid=bid.mlid
					INNER JOIN Stock_Itemmmas s on s.Itemid=bid.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 				
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid
					and tk2.Approved ='1' 
					and iscocktail ='D'
					--and iscocktail ='Y'
					group by tk2.Itemid,btm.BarItemname,tk2.Noofpax,iscocktail,tk2.NCconversionreson,tk2.TRat,Kot_Id,Tqty,
				    TableId,tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt,Tqty,Splinstruction,
					KITMSG,bm.Mlqty,tk2.nckotaccounttype,tk2.nctype,tk2.storeitemid

open kotitemsfetch170720        

set @maskotcoout= (select count(*) from trans_barkot_mas)
set @billid= (select ident_current('Trans_BARKot_mas'))
		if(@billid >=1 and @maskotcoout >0)
		BEGIN
			set @billid = @billid+1						
		END
    FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg,@pax,
	@iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt,@mlqty,@nckotaccounttype,@nctype,@storeitemid
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool1 = 1
				set @setbool=1
				IF(@nckotaccounttype=0)
					BEGIN
						
						set @nc=0
						set @nctypeid=0
						set @rate = @trat
						set @amt=@tamt
						set @ncaccid=0
						
					END
				ELSE
				    BEGIN
					
					set @nc=1
						set @nctypeid=@nctype
						set @rate = 0.00
						set @amt=0.00
						set @ncaccid=@nckotaccounttype
						
						
					END
				

					INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,qty1,added,
					tkotid,Splinstruction,KITCHENMSG,storeitemid,nckot,ncaccid,nctypeid)values
					(@part,@billid,@itemid,@tqty,@rate,@amt,@tableid,@iscoktail,@tqty,0,@kotid,@splinstruction,
					@kitmsg,@storeitemid,@nc,@nckotaccounttype,@nctypeid ) 
					INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,(@mlqty),ident_current('Trans_BARKot_det '))

				
				

               set	@Tamt1=@amt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
                    
                FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg,@pax,
	            @iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt,@mlqty,@nckotaccounttype,@nctype,@storeitemid
                END
				set @Employeeid = (select Employeeid from employee WHERE Employee=@Employee)
				set @separatebilll = (select dbo.sep_foodbill('D') )
				if(@nc =1)
					begin
						set @separatebilll = (select dbo.sep_foodbill('N') )
					end
	
	               if(@setbool = 1)
					begin
						INSERT INTO dbo.Trans_BARKot_mas(Refno,Raised,counterid,noofpax,part,tableid,Stwid,Kotno,Kotdate, 
					  Kottime, totalamount, rOOMORTAB,Userid,sessionid,tokenno,NCconversionreson,nckot,nctypeid,ncaccid) 
					  VALUES ('','0',@counter,@noofpax,@part,@tableid,@Employeeid,
					  @separatebilll,convert(VARCHAR,@date,101), convert(VARCHAR,@time,108), @sum11,'T',1,@sessionid,
					 @tokenno,@ncreson,@nc,@nctypeid,@ncaccid)

					 insert into temp_billid(billid,bdate)values(IDENT_CURRENT('trans_barkot_mas'),convert(VARCHAR,@date,101))
					end
				  
				
                CLOSE kotitemsfetch170720
                DEALLOCATE kotitemsfetch170720


create table trans_nccovert(id int primary key identity(1,1), kotid bigint, 
convertkotid bigint,userid bigint, convertdate datetime)

alter table application_settings add billlastdatealertonkot bigint

alter table trans_nccovert add converttime datetime





--changes on 16.03.2024
create PROCEDURE [dbo].[KotBarBillItemt__withncvalid] @id BIGINT as
SELECT 
ic.itemcategoryid,i.Servicetax,d.kotdetid,m.noofpax,SplitBillRaised,d.storeitemid,
Kottime,Stwid,i.Surchrgs,i.discountnotapplicable,i.Saltax,d.itemid,m.Kotid,m.Kotno,
i.barItemname AS Itemname,d.qty,d.Rate,d.Amount
 FROM Trans_BARKot_mas m
INNER JOIN Trans_BARKot_det d ON d.kotid=m.Kotid
INNER JOIN Bar_itemmmas  i ON i.barItemid=d.itemid
inner join bar_itemdet_id bd on bd.RefBarItemid=i.BarItemid
 INNER JOIN Stock_itemmmas stk on stk.Itemid=bd.storeitemid
  INNER JOIN itemgroup ig on ig.Itemgroupid=stk.Itemgroupid 
  INNER JOIN Itemcategory ic on ic.itemcategoryid=ig.Itemcategoryid 
WHERE isnull(m.Raised,0)=0 AND m.tableid=@id and isnull(d.cANCELORNORM,'')<>'C'  
 and isnull(SplitBillRaised,0)=0  and isnull(m.nckot,0)<>1
order by Kottime desc




USE [elanzabar]
GO
/****** Object:  StoredProcedure [dbo].[datapurging]    Script Date: 16/03/2024 14:20:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[datapurging]
@key varchar(20)
AS

if(@key='MASTER')
	BEGin
		 truncate table Bar_itemmmas
		 truncate table bar_itemdet_id
		 truncate table Employee
		 truncate table mas_fire
		 truncate table Itemcategory
		 truncate table Itemgroup
		 truncate table Barmltype
		 truncate table Mas_nckottype
		 truncate table Mas_nckotaccount
		 truncate table Stock_itemmmas
		 truncate table Supplier
		 truncate table Table_Group
		 truncate table Tablemas
		 truncate table taxsetupmas
		 truncate table taxsetupdet
		 truncate table taxsetupacdet
		 truncate table taxtype

	END

if(@key='Transaction')
	BEGIN
		truncate table Trans_Bar_InwardMas
		truncate table Trans_Bar_Inwarddet
		truncate table trans_bar_purchasemas
		truncate table Trans_bar_purchasedet
		truncate table Trans_BarStoreopening_mas
		truncate table Trans_BarStoreopening_det
		truncate table trans_bar_stockadjustmentdet
		truncate table trans_bar_stockadjustmentmas
		truncate table Trans_BARKot_det
		truncate table Trans_BARKot1_det
		truncate table Trans_BARKot_mas
		truncate table Trans_BARKot1_mas
		truncate table Trans_BARKotdet_id
		update tablemas set status='S'
		truncate table Trans_BARKotSettlement_mas
		truncate table Trans_BARKotSettlement1_det
		truncate table Trans_BARKotSettlement_det
		truncate table temp_settlement
		truncate table Trans_BARKotBillraise_mas
		truncate table Trans_BARKotBillraise_det
		update Stock_itemmmas set BarStockqty=0,BariSsueqty=0,StoreStockqty=0,StorePurqty=0,BarSalqty=0,storeopstock=0,StoreAdjQty=0,Baropstock=0,BarAdjQty=0,sTKRATE=0
		truncate table trans_barkotcancel_mas 
		truncate table trans_barkotcancel_det
		truncate table trans_barkotcanceldet_id
		truncate table trans_barkotcancel1_mas 
		truncate table trans_barkotcancel1_det
		truncate table  trans_barkotcanceldet1_id
        truncate table trans_barkotsettlement_mas_Log
		truncate table  trans_barkotsettlement1_det_log
		truncate table  trans_barkotsettlement_Det_Log 
		truncate table trans_barkotsettlement1_mas_Log
		truncate table  trans_barkotsettlement3_det_log
		truncate table  trans_barkotsettlement2_Det_Log
		truncate table stock_itemmmas_Log
		truncate table bar_itemmmas_Log
		truncate table bar_Itemdet_id_Log
		truncate table Trans_BarKot_Edit
		truncate table Trans_BARKot_det_log
		truncate table trans_barkotbilltax_det
		truncate table Temp_ncsplitbill1_mas
		truncate table Temp_ncsplitbill1_mas
		truncate table trans_nccovert


	END
	----------------------------------------------
	DROP TABLE USERNAME
	
-----------------------------------------------------------
CREATE TABLE [dbo].[username](
	[Userid] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](25) NULL,
	[Password] [varchar](30) NULL,
	[Groupid] [smallint] NULL,
	[Employeeid] [smallint] NULL,
	[Question] [varchar](250) NULL,
	[Answer] [varchar](100) NULL,
	[ChangePass] [varchar](1) NULL CONSTRAINT [DF__UserName__Change__46E78A0C]  DEFAULT ('N'),
	[Defaults] [char](1) NULL,
	[labelcolor] [ntext] NULL,
	[recordimages] [int] NULL,
	[adminuser] [int] NULL,
	[discper] [numeric](12, 2) NULL,
	[discamount] [numeric](12, 2) NULL,
	[tposkotedit] [bigint] NULL,
	[tposkotvoid] [bigint] NULL,
	[tposbilledit] [bigint] NULL,
	[tpossettlevoid] [bigint] NULL,
	[tposresettle] [bigint] NULL,
	[tpostabletransfer] [bigint] NULL,
	[TPassword] [varchar](25) NULL,
	[stwid] [bigint] NULL,
	[outletid] [bigint] NULL,
	[cancel] [bigint] NULL,
	[tposbillvoid] [bigint] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
SET ANSI_PADDING OFF
ALTER TABLE [dbo].[username] ADD [pass] [varchar](10) NULL
ALTER TABLE [dbo].[username] ADD [Sid] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [isadmin] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [userwisegracetime] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [userimg] [image] NULL
SET ANSI_PADDING ON
ALTER TABLE [dbo].[username] ADD [photo] [varbinary](max) NULL
ALTER TABLE [dbo].[username] ADD [enablepostrent] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [posdisablesecurity] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [Tposnckot] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [bardisablesecurity] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [enabledatasecurity] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [inactive] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [directindent] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [deptid] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [allowcheckinadvance] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [enablebillpreview] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [enablebarkoteditdelete] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [enabletarriffedit] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [AU_IND] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [Enablemdcheckin] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [AllowexcelexportFO] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [Allowexcelexport] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [changetarriffafterNA] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [prevdays] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [posprevdays] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [allowexcelexportcosting] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [posadminuser] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [houseadminuser] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [enableallowanceinpostbill] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [enablechkoutcancelbill] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [enablecreditdatechangeincreditentry] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [ENABLEFObarallposting] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [barprevdays] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [barDiscper] [numeric](12, 2) NULL
ALTER TABLE [dbo].[username] ADD [bardiscamount] [numeric](12, 2) NULL
ALTER TABLE [dbo].[username] ADD [Enablemanualdiscount] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [Allowtoposttoroombills] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [tposkotreprint] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [tposbillreprint] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [Tposcompkotreprint] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [Tposcompbillreprint] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [AllowBQMWalkoutbill] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [enabletoshowpostrent] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [enabletopostdiscount] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [enabletoshowwalkoutincashierrpt] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [enabletoshowwalkoutincollectionrpt] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [Allowtocheckinwithoutcard] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [Allowtocheckoutwithoutcard] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [TposItemwisereport] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [Tposbillwisereport] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [Tpospendingkotreport] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [Tposcomppendingkotreport] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [Tposcaptainwisereport] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [Tposstewardwisereport] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [Tposstewarditemwisereport] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [Tposcaptainitemwisereport] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [TposItemgroupwisereport] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [Allowtocheckoutwithoutvalidation] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [allowreservationenquiryclose] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [Costingstockreportbasedonlprate] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [enabletoallowcancelbills] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [powersupportid] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [Allowpostroomrentotacheckin] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [Enablemaintenancepower] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [Enabletoshowwalkoutindaysettlementrpt] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [allowfoblock] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [allowmoblock] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [enable24hrscheckin] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [Allowtariffeditaftercheckinreservation] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [Allowpostdiscamountf11] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [internetpass] [varchar](500) NULL
ALTER TABLE [dbo].[username] ADD [UserShowdailycashbookincashierrpt] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [storeorderbyempid] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [Allowtobarbilledit] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [tabkotdel] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [TableGroupid] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [tabkotedit] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [tabkotadd] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [ShowBarliqourfoodbarsinsalesreport] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [Updatetrans] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [allowexcelexportbar] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [billcanceluser] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [editcancelkotuser] [bigint] NULL
ALTER TABLE [dbo].[username] ADD [TabUser] [bigint] NULL

GO
----------------------------------------------------------------------
insert into userTABLE(Emailid,password,repassword,depaRtment_id,username,usergroup_id)values('pavithra','12345678','12345678','4','pavithra','2')
---------------------------------------------------------------
ALTER procedure [dbo].[kot__save__one]
@tableid bigint,@counter bigint, @sessionid bigint, @tokenno bigint,@noofpax bigint,@Employee varchar(100)
As

declare @maskotcoout bigint=0
declare @qty bigint ,@part varchar(100),@itemid bigint ,@tqty bigint,@trat numeric(12,2),
@tamt numeric(12,2), @bool bigint=0,
@iscoktail varchar(2),@storeitemid bigint,@kotid bigint,@splinstruction varchar(1000),@kitmsg varchar(1000),
@nccoversion varchar(1000),
@Tamt1 numeric(12,2), @sum11 numeric(12,2)=0,@ncreson varchar(1000),@Employeeid bigint,@billid bigint,@mlqty bigint,
@nc bigint, @nctypeid bigint, @ncaccid bigint,@amt numeric(12,2),@rate numeric(12,2),@nckotaccounttype bigint,@nctype bigint
set @sum11=0
set @sum11=0
set @amt=0

set @maskotcoout= (select count(*) from trans_barkot_mas)


declare kotitemsfetch170719 cursor for 

SELECT DISTINCT bid.qty ,tk2.part,tk2.Itemid,Tqty,tk2.TRat,Tamt,iscocktail,
tk2.storeitemid,Kot_Id,Splinstruction,KITMSG,tk2.NCconversionreson,bm.Mlqty,tk2.nckotaccounttype,tk2.nctype
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Stock_Itemmmas s on s.Itemid=tk2.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					inner join Barmltype bm on bm.Mlid=bid.mlid
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid
					--and isnull(tk2.Approved,0) =0
					 and  iscocktail <>'D'

open kotitemsfetch170719
set @maskotcoout= (select count(*) from trans_barkot_mas) 
set @billid= (select ident_current('Trans_BARKot_mas'))
		if(@billid >= 1 and @maskotcoout >0)
		BEGIN
			set @billid = @billid+1						
		END       

    FETCH NEXT FROM kotitemsfetch170719 INTO  @qty,@part,@itemid,@tqty,@trat,@tamt,@iscoktail,
	@storeitemid,@kotid,@splinstruction,@kitmsg,@nccoversion,@mlqty,@nckotaccounttype,@nctype
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool = 1
				
				IF(@nckotaccounttype=0)
					BEGIN
						set @nc=0
						set @nctypeid=0
						set @rate = @trat
						set @amt=@tamt
						set @ncaccid=0
					END
				ELSE
				    BEGIN
						set @nc=1
						set @nctypeid=@nctype
						set @rate = 0.00
						set @amt=0.00
						set @ncaccid=@nckotaccounttype
					END
				INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,storeitemid,
				qty1,added,tkotid,Splinstruction,KITCHENMSG,ncaccid,nckot,nctypeid)values(@part,@billid,@itemid,
				@tqty,@rate,@amt,@tableid,
				@iscoktail,@storeitemid,@tqty,0,@kotid,@splinstruction,@kitmsg,@nckotaccounttype,@nc,@nctypeid)
				INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,(@mlqty),
				ident_current('Trans_BARKot_det '))
				set	@Tamt1=@amt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
				
                    
                FETCH NEXT FROM kotitemsfetch170719 INTO @qty,@part,@itemid,@tqty,@trat,@tamt,@iscoktail,@storeitemid,
				@kotid,@splinstruction,@kitmsg,@nccoversion,@mlqty,@nckotaccounttype,@nctype
                END
                CLOSE kotitemsfetch170719
                DEALLOCATE kotitemsfetch170719


declare @baritemname varchar(500),@pax bigint, @sbarstockqty bigint,@icecreamorfood bigint,@otheritems bigint,@bool1 bigint
set @bool = 0

declare kotitemsfetch170720 cursor for 

SELECT DISTINCT btm.BarItemname,tk2.NCconversionreson,Splinstruction,KITMSG,tk2.Noofpax,iscocktail,tk2.TRat,
Kot_Id,Tqty,tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt,bm.Mlqty,tk2.nckotaccounttype,tk2.nctype
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					inner join Barmltype bm on bm.Mlid=bid.mlid
					INNER JOIN Stock_Itemmmas s on s.Itemid=bid.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 				
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid 
					and tk2.Approved ='1' 
					and iscocktail ='D'
					--and iscocktail ='Y'
					group by tk2.Itemid,btm.BarItemname,tk2.Noofpax,iscocktail,tk2.NCconversionreson,tk2.TRat,Kot_Id,Tqty,
					TableId,tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt,Tqty,Splinstruction,
					KITMSG,bm.Mlqty,tk2.nckotaccounttype,tk2.nctype

open kotitemsfetch170720        

set @maskotcoout= (select count(*) from trans_barkot_mas)
set @billid= (select ident_current('Trans_BARKot_mas'))
		if(@billid >=1 and @maskotcoout >0)
		BEGIN
			set @billid = @billid+1						
		END
    FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg,@pax,
	@iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt,@mlqty,@nckotaccounttype,@nctype
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool1 = 1
				IF(@nckotaccounttype=0)
					BEGIN
						
						set @nc=0
						set @nctypeid=0
						set @rate = @trat
						set @amt=@tamt
						set @ncaccid=0
						
					END
				ELSE
				    BEGIN
					
					set @nc=1
						set @nctypeid=@nctype
						set @rate = 0.00
						set @amt=0.00
						set @ncaccid=@nckotaccounttype
						
						
					END
				
					INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,qty1,added,
					tkotid,Splinstruction,KITCHENMSG,storeitemid,nckot,ncaccid,nctypeid)values
					(@part,@billid,@itemid,@tqty,@rate,@amt,@tableid,@iscoktail,@tqty,0,@kotid,@splinstruction,
					@kitmsg,@storeitemid,@nc,@nckotaccounttype,@nctypeid ) 
					INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,(@mlqty),ident_current('Trans_BARKot_det '))

				
				

               set	@Tamt1=@amt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
                    
                FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg,@pax,
	            @iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt,@mlqty,@nckotaccounttype,@nctype
                END
                CLOSE kotitemsfetch170720
                DEALLOCATE kotitemsfetch170720

		
				
				
					
					
					
set @Employeeid = (select Employeeid from employee WHERE Employee=@Employee)

				

				
				
  INSERT INTO dbo.Trans_BARKot_mas(Refno,Raised,counterid,noofpax,part,tableid,Stwid,Kotno,Kotdate, 
  Kottime, totalamount, rOOMORTAB,Userid,sessionid,tokenno,NCconversionreson,nckot,nctypeid,ncaccid) 
  VALUES ('','0',@counter,@noofpax,@part,@tableid,@Employeeid,
  dbo.RotNo(),convert(VARCHAR,getdate(),101), convert(VARCHAR,getdate(),108), @sum11,'T',1,@sessionid,
 @tokenno,@ncreson,@nc,@nctypeid,@ncaccid) 




----------------------------------------------------------------------------------------------
ALTER procedure [dbo].[kot__save__one__separate]
@tableid bigint,@counter bigint, @sessionid bigint, @tokenno bigint,@noofpax bigint,
@Employee varchar(100),@date datetime, @time datetime
As

declare @maskotcoout bigint=0
declare @qty bigint ,@part varchar(100),@itemid bigint ,@tqty bigint,@trat numeric(12,2),
@tamt numeric(12,2), @bool bigint=0,
@iscoktail varchar(2),@storeitemid bigint,@kotid bigint,@splinstruction varchar(1000),
@kitmsg varchar(1000),
@nccoversion varchar(1000),
@Tamt1 numeric(12,2), @sum11 numeric(12,2)=0,@ncreson varchar(1000),@Employeeid bigint,@billid bigint,@mlqty bigint,
@nc bigint, @nctypeid bigint, @ncaccid bigint,@amt numeric(12,2),@rate numeric(12,2),@nckotaccounttype bigint,@nctype bigint,@separatebilll varchar(1000),
@setbool1 bigint
set @sum11=0
set @sum11=0
set @amt=0
set @setbool1=0

set @maskotcoout= (select count(*) from trans_barkot_mas)


declare kotitemsfetch170719 cursor for 

SELECT DISTINCT bid.qty ,tk2.part,tk2.Itemid,Tqty,tk2.TRat,Tamt,iscocktail,
tk2.storeitemid,Kot_Id,Splinstruction,KITMSG,tk2.NCconversionreson,bm.Mlqty,tk2.nckotaccounttype,tk2.nctype
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Stock_Itemmmas s on s.Itemid=tk2.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					inner join Barmltype bm on bm.Mlid=bid.mlid
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid
					--and isnull(tk2.Approved,0) =0
					 and  iscocktail <>'D'

open kotitemsfetch170719
set @maskotcoout= (select count(*) from trans_barkot_mas) 
set @billid= (select ident_current('Trans_BARKot_mas'))
		if(@billid >= 1 and @maskotcoout >0)
		BEGIN
			set @billid = @billid+1						
		END       

    FETCH NEXT FROM kotitemsfetch170719 INTO  @qty,@part,@itemid,@tqty,@trat,@tamt,@iscoktail,
	@storeitemid,@kotid,@splinstruction,@kitmsg,@nccoversion,@mlqty,@nckotaccounttype,@nctype
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool = 1
				set @setbool1 = 1
				
				IF(@nckotaccounttype=0)
					BEGIN
						set @nc=0
						set @nctypeid=0
						set @rate = @trat
						set @amt=@tamt
						set @ncaccid=0
					END
				ELSE
				    BEGIN
						set @nc=1
						set @nctypeid=@nctype
						set @rate = 0.00
						set @amt=0.00
						set @ncaccid=@nckotaccounttype
					END
				INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,storeitemid,
				qty1,added,tkotid,Splinstruction,KITCHENMSG,ncaccid,nckot,nctypeid)values(@part,@billid,@itemid,
				@tqty,@rate,@amt,@tableid,
				@iscoktail,@storeitemid,@tqty,0,@kotid,@splinstruction,@kitmsg,@nckotaccounttype,@nc,@nctypeid)
				INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,(@mlqty),
				ident_current('Trans_BARKot_det '))
				set	@Tamt1=@amt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
				
                    
                FETCH NEXT FROM kotitemsfetch170719 INTO @qty,@part,@itemid,@tqty,@trat,@tamt,@iscoktail,@storeitemid,
				@kotid,@splinstruction,@kitmsg,@nccoversion,@mlqty,@nckotaccounttype,@nctype
                END

									
				set @Employeeid = (select Employeeid from employee WHERE Employee=@Employee)
				set @separatebilll = (select dbo.sep_foodbill('L') )
				if(@nc =1)
					begin
						set @separatebilll = (select dbo.sep_foodbill('N') )
					end
	
	            if(@setbool1 = 1)
					begin
						INSERT INTO dbo.Trans_BARKot_mas(Refno,Raised,counterid,noofpax,part,tableid,Stwid,Kotno,Kotdate, 
						 Kottime, totalamount, rOOMORTAB,Userid,sessionid,tokenno,NCconversionreson,nckot,nctypeid,ncaccid) 
						VALUES ('','0',@counter,@noofpax,@part,@tableid,@Employeeid,
						@separatebilll,convert(VARCHAR,@date,101), convert(VARCHAR,@time,108), @sum11,'T',1,@sessionid,
						@tokenno,@ncreson,@nc,@nctypeid,@ncaccid) 
						insert into temp_billid(billid,bdate)values(IDENT_CURRENT('trans_barkot_mas'),convert(VARCHAR,@date,101))
					end

				
				

                CLOSE kotitemsfetch170719
                DEALLOCATE kotitemsfetch170719


declare @baritemname varchar(500),@pax bigint, @sbarstockqty bigint,@icecreamorfood bigint,@otheritems bigint,@bool1 bigint,@setbool bigint
set @bool = 0
set @sum11=0
set @sum11=0
set @amt=0
set @setbool =0

declare kotitemsfetch170720 cursor for 

SELECT DISTINCT btm.BarItemname,tk2.NCconversionreson,Splinstruction,KITMSG,
tk2.Noofpax,iscocktail,tk2.TRat,
Kot_Id,Tqty,tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,
otheritems,bid.qty,Tamt,bm.Mlqty,tk2.nckotaccounttype,tk2.nctype,tk2.storeitemid
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					inner join Barmltype bm on bm.Mlid=bid.mlid
					INNER JOIN Stock_Itemmmas s on s.Itemid=bid.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 				
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid
					and tk2.Approved ='1' 
					and iscocktail ='D'
					--and iscocktail ='Y'
					group by tk2.Itemid,btm.BarItemname,tk2.Noofpax,iscocktail,tk2.NCconversionreson,tk2.TRat,Kot_Id,Tqty,
				    TableId,tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt,Tqty,Splinstruction,
					KITMSG,bm.Mlqty,tk2.nckotaccounttype,tk2.nctype,tk2.storeitemid

open kotitemsfetch170720        

set @maskotcoout= (select count(*) from trans_barkot_mas)
set @billid= (select ident_current('Trans_BARKot_mas'))
		if(@billid >=1 and @maskotcoout >0)
		BEGIN
			set @billid = @billid+1						
		END
    FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg,@pax,
	@iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt,@mlqty,@nckotaccounttype,@nctype,@storeitemid
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool1 = 1
				set @setbool=1
				IF(@nckotaccounttype=0)
					BEGIN
						
						set @nc=0
						set @nctypeid=0
						set @rate = @trat
						set @amt=@tamt
						set @ncaccid=0
						
					END
				ELSE
				    BEGIN
					
					set @nc=1
						set @nctypeid=@nctype
						set @rate = 0.00
						set @amt=0.00
						set @ncaccid=@nckotaccounttype
						
						
					END
				

					INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,qty1,added,
					tkotid,Splinstruction,KITCHENMSG,storeitemid,nckot,ncaccid,nctypeid)values
					(@part,@billid,@itemid,@tqty,@rate,@amt,@tableid,@iscoktail,@tqty,0,@kotid,@splinstruction,
					@kitmsg,@storeitemid,@nc,@nckotaccounttype,@nctypeid ) 
					INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,(@mlqty),ident_current('Trans_BARKot_det '))

				
				

               set	@Tamt1=@amt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
                    
                FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg,@pax,
	            @iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt,@mlqty,@nckotaccounttype,@nctype,@storeitemid
                END
				set @Employeeid = (select Employeeid from employee WHERE Employee=@Employee)
				set @separatebilll = (select dbo.sep_foodbill('D') )
				if(@nc =1)
					begin
						set @separatebilll = (select dbo.sep_foodbill('N') )
					end
	
	               if(@setbool = 1)
					begin
						INSERT INTO dbo.Trans_BARKot_mas(Refno,Raised,counterid,noofpax,part,tableid,Stwid,Kotno,Kotdate, 
					  Kottime, totalamount, rOOMORTAB,Userid,sessionid,tokenno,NCconversionreson,nckot,nctypeid,ncaccid) 
					  VALUES ('','0',@counter,@noofpax,@part,@tableid,@Employeeid,
					  @separatebilll,convert(VARCHAR,@date,101), convert(VARCHAR,@time,108), @sum11,'T',1,@sessionid,
					 @tokenno,@ncreson,@nc,@nctypeid,@ncaccid)

					 insert into temp_billid(billid,bdate)values(IDENT_CURRENT('trans_barkot_mas'),convert(VARCHAR,@date,101))
					end
				  
				
                CLOSE kotitemsfetch170720
                DEALLOCATE kotitemsfetch170720
				------------------------------------------------------------------
				ALTER procedure [dbo].[kot__save__two]
@tableid bigint,@counter bigint, @sessionid bigint, @tokenno bigint,@refdate datetime,@reftime datetime,@noofpax bigint,@Stwid bigint
As

declare @qty bigint ,@part varchar(100),@itemid bigint ,@tqty bigint,@trat numeric(12,2),@tamt numeric(12,2), @bool bigint=0,
@iscoktail varchar(2),@storeitemid bigint,@kotid bigint,@splinstruction varchar(1000),@kitmsg varchar(1000),
@nccoversion varchar(1000),
@Tamt1 numeric(12,2), @sum11 numeric(12,2),@ncreson varchar(1000),@Employeeid bigint,@billid bigint, @baritemname varchar(500),
@pax bigint, @sbarstockqty bigint,@icecreamorfood bigint,@otheritems bigint,@bool1 bigint,@nckotaccounttype bigint,@nctype varchar(100),
@itemname  varchar(100),@nc bigint, @nctypeid bigint, @ncaccid bigint,@amt numeric(12,2),@rate numeric(12,2),@mlqty bigint
set @sum11=0
set @sum11=0
set @amt=0

  INSERT INTO dbo.Trans_BARKot_mas(Refno,Raised,counterid,noofpax,part,tableid,Stwid,Kotno,Kotdate,  Kottime, totalamount, rOOMORTAB,Userid,sessionid,tokenno,NCconversionreson,refkotdate,refkottime) 
  VALUES ('','0',@counter,@noofpax,@part,@tableid,@Stwid,  dbo.RotNo(),@refdate,@reftime, @sum11,'T',1,@sessionid, @tokenno,@ncreson,convert(VARCHAR,getdate(),101), convert(VARCHAR,getdate(),108)) 
 set @billid=(Select SCOPE_IDENTITY())

declare kotitemsfetch170719 cursor for 
SELECT DISTINCT btm.BarItemname,tk2.NCconversionreson,isnull(tk2.nckotaccounttype,0) as nckotaccounttype ,nctype,
					Splinstruction,KITMSG,tk2.Noofpax,tk2.storeitemid,iscocktail,tk2.TRat,Kot_Id,Tqty,tk2.Itemid,
					s.Itemname,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt,bm.Mlqty
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Stock_Itemmmas s on s.Itemid=tk2.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					inner join Barmltype bm on bm.Mlid=bid.mlid
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid
					and tk2.Approved ='1'
set @bool1=0
open kotitemsfetch170719 
     

   FETCH NEXT FROM kotitemsfetch170719 INTO  @baritemname,@nccoversion,@nckotaccounttype,@nctype,@splinstruction,@kitmsg,
 @pax,@storeitemid,@iscoktail,@trat,@kotid,@tqty,@itemid,@itemname,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty
 ,@tamt,@mlqty
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool1 = 1
				IF(@nckotaccounttype=0)
					BEGIN
						set @nc=0
						set @nctypeid=0
						set @rate = @trat
						set @amt=@tamt
						set @ncaccid=0
					END
				ELSE
				    BEGIN
						set @nc=1
						set @nctypeid=@nctype
						set @rate = 0.00
						set @amt=0.00
						set @ncaccid=@nckotaccounttype
					END
		
				
				INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,storeitemid,qty1,added,tkotid,Splinstruction,KITCHENMSG,nckot,nctypeid,ncaccid)
				values(@part,@billid,@itemid,@tqty,@rate,@amt,@tableid,@iscoktail,@storeitemid,@tqty,0,@kotid,@splinstruction,@kitmsg,@nc,@nctypeid,@ncaccid)
				INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,(@mlqty),ident_current('Trans_BARKot_det '))
				set	@Tamt1=@amt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
					
                    
               FETCH NEXT FROM kotitemsfetch170719 INTO  @baritemname,@nccoversion,@nckotaccounttype,@nctype,@splinstruction,@kitmsg,
 @pax,@storeitemid,@iscoktail,@trat,@kotid,@tqty,@itemid,@itemname,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt,@mlqty
                END
                CLOSE kotitemsfetch170719
                DEALLOCATE kotitemsfetch170719



declare kotitemsfetch170720 cursor for 


SELECT DISTINCT btm.BarItemname,tk2.NCconversionreson,Splinstruction,KITMSG,tk2.Noofpax,iscocktail,tk2.TRat,Kot_Id,Tqty,
tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt,bm.Mlqty
					From temp_kot2 tk2
					INNER JOIN Bar_Itemmmas btm on btm.BarItemid=tk2.Itemid
					INNER JOIN Bar_Itemdet_id bid on bid.RefBarItemid=btm.BarItemid
					inner join Barmltype bm on bm.Mlid=bid.mlid
					INNER JOIN Stock_Itemmmas s on s.Itemid=bid.storeitemid 
					INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid 				
					WHERE (isnull(ig.barorfood,0)=1 or isnull(ig.hotitems,0)=1 ) 
					and isnull(btm.inactive,0)=0 and tk2.TableId=@tableid
					and tk2.Approved ='1' and iscocktail ='Y'
					group by tk2.Itemid,btm.BarItemname,tk2.NCconversionreson,tk2.Noofpax,iscocktail,tk2.TRat,Kot_Id,Tqty,
					TableId,tk2.Itemid,s.sbarstockqty,tk2.part,icecreamorfood,otheritems,bid.qty,Tamt,Tqty,Splinstruction,
					KITMSG,bm.Mlqty
open kotitemsfetch170720        


    FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg, @pax,
@iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt,@mlqty
                WHILE @@FETCH_STATUS = 0
                BEGIN
				set @bool1 = 1
				IF(@nckotaccounttype=0)
					BEGIN
						set @rate = @trat
						set @amt=@tamt
						
					END
				ELSE
				    BEGIN
					
						set @rate = 0.00
						set @amt=0.00
						
					END
				    INSERT INTO dbo.Trans_BARKot_det (part,kotid, itemid, qty, Rate, Amount, tableid,iscocktail,storeitemid,qty1,added,tkotid,Splinstruction,KITCHENMSG,nckot,nctypeid,ncaccid)
				values(@part,@billid,@itemid,@tqty,@rate,@amt,@tableid,@iscoktail,@storeitemid,@tqty,0,@kotid,@splinstruction,@kitmsg,@nc,@nctypeid,@ncaccid)
					INSERT INTO dbo.Trans_BARKotdet_id(storeitemid,qty,Refkotdetid)VALUES  (@storeitemid,(@mlqty),ident_current('Trans_BARKot_det '))

				
				set	@Tamt1=@amt
				set	@sum11=@sum11+	@Tamt1
				set	@ncreson=@nccoversion
                    
                FETCH NEXT FROM kotitemsfetch170720 INTO  @baritemname,@nccoversion,@splinstruction,@kitmsg, @pax,
                @iscoktail,@trat,@kotid,@tqty,@itemid,@sbarstockqty,@part,@icecreamorfood,@otheritems,@qty,@tamt,@mlqty
                END
                CLOSE kotitemsfetch170720
                DEALLOCATE kotitemsfetch170720

				if(@bool1=1)
				BEGIN
					select @Employeeid = Employeeid from employee WHERE istabsteward='1'
				END

					
--UPdate Mas
  UPdate dbo.Trans_BARKot_mas set part=@part, totalamount=@sum11,nckot=@nc,nctypeid=@nctypeid where Kotid=@billid

 update Tablemas set Status='K' where Tableid=@tableid
 --Delete from temp_kot2 where Tableid=@tableid
 select @billid as ID

----------------------------------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE [dbo].[KotBarBillFoodItem] @id BIGINT as

SELECT d.itemid,m.Kotid,m.noofpax,d.kotdetid,m.Kotno,i.barItemname AS Itemname,d.qty,d.Rate,d.Amount FROM Trans_BARKot_mas m
INNER JOIN Trans_BARKot_det d ON d.kotid=m.Kotid
inner join Trans_BarKotdet_id id on id.Refkotdetid=d.kotdetid
inner join Stock_itemmmas sitm on sitm.Itemid=id.storeitemid
inner join itemgroup ig on ig.Itemgroupid=sitm.Itemgroupid
INNER JOIN Bar_itemmmas  i ON i.barItemid=d.itemid
WHERE isnull(m.Raised,0)=0 AND m.tableid=@id and isnull(d.cANCELORNORM,'')<>'C' and isnull(SplitBillRaised,0)=0 
and isnull(ig.icecreamorfood,0)=1  and isnull(m.nckot,0)=0 and isnull(d.Amount,0)<>'0'  order by Kotdetid
--------------------------------------------------------------------------------------------
ALTER PROCEDURE [dbo].[KotBarBillItem_dis] @id BIGINT as
SELECT i.Servicetax,d.kotdetid,m.noofpax,SplitBillRaised,discountnotapplicable,d.storeitemid,Kottime,Stwid,i.Surchrgs,i.Saltax,d.itemid,m.Kotid,m.Kotno,i.barItemname AS Itemname,d.qty,d.Rate,d.Amount FROM Trans_BARKot_mas m
INNER JOIN Trans_BARKot_det d ON d.kotid=m.Kotid
INNER JOIN Bar_itemmmas  i ON i.barItemid=d.itemid
WHERE isnull(m.Raised,0)=0 AND m.tableid=@id and isnull(d.cANCELORNORM,'')<>'C'  and isnull(i.discountnotapplicable,0)=0
 and isnull(SplitBillRaised,0)=0 and isnull(m.nckot,0)=0
order by Kottime desc
----------------------------------------------------------------------------
ALTER PROCEDURE [dbo].[KotBarBillItemt__summary] @id BIGINT as
SELECT i.barItemname AS Itemname,
isnull(sum(d.qty),0)qty,isnull(sum(d.Rate),0)as Rate,isnull(sum(d.Amount),0) as Amount FROM Trans_BARKot_mas m
INNER JOIN Trans_BARKot_det d ON d.kotid=m.Kotid
INNER JOIN Bar_itemmmas  i ON i.barItemid=d.itemid
inner join bar_itemdet_id bd on bd.RefBarItemid=i.BarItemid
 INNER JOIN Stock_itemmmas stk on stk.Itemid=bd.storeitemid
  INNER JOIN itemgroup ig on ig.Itemgroupid=stk.Itemgroupid 
  INNER JOIN Itemcategory ic on ic.itemcategoryid=ig.Itemcategoryid 
WHERE isnull(m.Raised,0)=0 AND m.tableid=@id and isnull(d.cANCELORNORM,'')<>'C'  
 and isnull(SplitBillRaised,0)=0 
 group by i.BarItemname 
------------------------------------------------------------------------------------
ALTER PROCEDURE [dbo].[KotBarBillItemt__withncvalid] @id BIGINT as
SELECT 
ic.itemcategoryid,i.Servicetax,d.kotdetid,m.noofpax,SplitBillRaised,d.storeitemid,
Kottime,Stwid,i.Surchrgs,i.discountnotapplicable,i.Saltax,d.itemid,m.Kotid,m.Kotno,
i.barItemname AS Itemname,d.qty,d.Rate,d.Amount
 FROM Trans_BARKot_mas m
INNER JOIN Trans_BARKot_det d ON d.kotid=m.Kotid
INNER JOIN Bar_itemmmas  i ON i.barItemid=d.itemid
inner join bar_itemdet_id bd on bd.RefBarItemid=i.BarItemid
 INNER JOIN Stock_itemmmas stk on stk.Itemid=bd.storeitemid
  INNER JOIN itemgroup ig on ig.Itemgroupid=stk.Itemgroupid 
  INNER JOIN Itemcategory ic on ic.itemcategoryid=ig.Itemcategoryid 
WHERE isnull(m.Raised,0)=0 AND m.tableid=@id and isnull(d.cANCELORNORM,'')<>'C'  
 and isnull(SplitBillRaised,0)=0  and isnull(m.nckot,0)<>1
order by Kottime desc

------------------------------------------------------------------------------------
ALTER procedure [dbo].[billsave]
@head bigint,@Taxexemption bigint,@feeamount numeric(12,2),@feetax numeric(12,2),@date datetime,@time datetime,
@refdate datetime,@reftime datetime,@TUID bigint, @RESID bigint,@sessionid bigint,@tableid bigint
AS

declare @Rate numeric(12,2),@taxsetupid bigint,@BarItemId bigint,@BarItemCode varchar(1000),@BarItemname varchar(1000),@itemtotal numeric(12,2)=0.00,
@iscombo bigint,@iscocktail varchar(2),@icecreamorfood bigint,@taxtoal1 bigint=0,@taxamt numeric(12,2),@noofpax bigint,@Settled bigint,@total numeric(12,2)=0.00,
@totalamount1 bigint=0,@feeper bigint=0,@tolamt bigint=0,@taxsetupdetid bigint, @Accid bigint,@percentage numeric(12,2),@Accid5 bigint,@salestax numeric(12,2),
@percentage5 numeric(12,2),@headcode varchar(10) ,@toltaxableamt numeric(12,2),@headcode1 varchar(10), @percentage1 numeric(12,2),@taxableamt numeric(12,2)=0,
@percent numeric(12,2),@discper numeric(12,2), @totaldiscamount numeric(12,2),@discreason varchar(1000),@amount numeric(12,2),@kotid bigint,@rate1 numeric(12,2),
@totalamount numeric(12,2),@qty bigint,@discamount numeric(12,2),@tttax numeric(12,2)


declare kotitemsfetch170719 cursor for 

SELECT DISTINCT det.Rate,taxsetupid,btm.BarItemId,ms.kotid, btm.BarItemCode, btm.BarItemname,btm.iscombo,btm.iscocktail,ms.noofpax,ig.icecreamorfood ood
						FROM  Bar_Itemmmas btm 
						INNER JOIN Bar_Itemdet_id bdet ON btm.BarItemid = bdet.RefBarItemid 
						INNER JOIN Stock_Itemmmas s ON s.itemid = bdet.storeitemid 
						INNER JOIN Itemgroup ig ON ig.itemgroupid = s.Itemgroupid
						inner join trans_barkot_det det on det.itemid = btm .BarItemid
						inner join trans_barkot_mas ms on ms.kotid = det.kotid
						WHERE   ms.tableid=@tableid and 
						 isnull(ms.Raised,0)=0 and isnull(det.cANCELORNORM,'')<>'C'
                          and isnull(SplitBillRaised,0)=0  and 
						  --isnull(ms.nckot,0)=1  and
						   (isnull(ig.barorfood,0)=1
						 or isnull(ig.hotitems,0)=1)and isnull(btm.inactive,0)=0
						 
open kotitemsfetch170719        

                FETCH NEXT FROM kotitemsfetch170719 INTO  @Rate,@taxsetupid,@BarItemId,@kotid,@BarItemCode,@BarItemname,@iscombo,@iscocktail,@noofpax,@icecreamorfood
                WHILE @@FETCH_STATUS = 0
                BEGIN
				-----------------------------------------------------------------------------------------------------------
				set @itemtotal = @itemtotal + @Rate
				declare kotitemsfetch170721 cursor for 
				select headcode,percentage,taxsetupdetid,Accid from taxsetupmas tsm
						  INNER JOIN taxsetupdet tsd on tsd.taxsetupid=tsm.Taxsetupid
						  inner join  taxtype tx on tx.taxid=tsd.Accid
						  where tsm.Taxsetupid=@taxsetupid
				open kotitemsfetch170721        

				FETCH NEXT FROM kotitemsfetch170721 INTO @headcode,@percentage,@taxsetupdetid,@Accid
                WHILE @@FETCH_STATUS = 0
                BEGIN
					-----------------------------------------------------------------------------------------
					
					declare kotitemsfetch170722 cursor for 
					select Accid from taxsetupACdet where taxsetupdetid=@taxsetupdetid and selected=1
					open kotitemsfetch170722        

					FETCH NEXT FROM kotitemsfetch170722 INTO  @Accid5
					WHILE @@FETCH_STATUS = 0
					BEGIN
						IF(@Accid5 = @head)
							BEGIN
								IF(@headcode = 'CGST2' and @icecreamorfood ='1')
								BEGIN
									set @percent = @percentage
									set @taxableamt = @Rate - @feeamount
								END
								ELSE IF(@headcode = 'SGST2' and  @icecreamorfood = '1')
								BEGIN
									set @percent = @percentage
									set @taxableamt = @Rate - @feeamount
								END
								ELSE IF(@headcode = 'SC3' and @Taxexemption = '1')
								BEGIN
									set @percent = 0
									set @taxableamt = @Rate +0
								END
							END
						ELSE
							BEGIN
							----------------------------------------------------------------------------
								declare kotitemsfetch170723 cursor for
								select headcode, percentage from taxsetupmas tsm 
								INNER JOIN taxsetupdet tsd on tsd.taxsetupid=tsm.Taxsetupid
								inner join  taxtype tx on tx.taxid=tsd.Accid
								where tsm.Taxsetupid=@taxsetupid and Accid =@Accid5
								open kotitemsfetch170723        
								
									FETCH NEXT FROM kotitemsfetch170723 INTO  @headcode1, @percentage1
												WHILE @@FETCH_STATUS = 0
												BEGIN
													IF(@headcode1 = 'SC3' and @Taxexemption='1')
													BEGIN
														set @taxableamt = @taxableamt +0
														set @percent = 0
													END
													ELSE
													BEGIN
														set @percent = @percentage
														set @taxableamt = (@Rate * @percentage1)/100
													END

												FETCH NEXT FROM kotitemsfetch170723 INTO  @headcode1, @percentage1
												END
												CLOSE kotitemsfetch170723
												DEALLOCATE kotitemsfetch170723

							----------------------------------------------------------------------------
								
							END
							
							set @toltaxableamt = @toltaxableamt + @taxableamt;
								
                    
					FETCH NEXT FROM kotitemsfetch170722 INTO    @Accid5
					END
					CLOSE kotitemsfetch170722
					DEALLOCATE kotitemsfetch170722
					-------------------------------------------------------------------------------------
					set @taxamt = (@toltaxableamt * @percent) / 100
					insert into trans_barkotbilltax_det (refbilldetid,Amount,Percentage,taxtypeid,billid,taxid)
					values(IDENT_CURRENT('Trans_BARkotBillraise_det')+1,@taxamt,@percent,@taxsetupid,IDENT_CURRENT('Trans_BARkotBillraise_mas')+1,@Accid)
                    
                FETCH NEXT FROM kotitemsfetch170721 INTO    @headcode,@percentage,@taxsetupdetid,@Accid
                END
                CLOSE kotitemsfetch170721
                DEALLOCATE kotitemsfetch170721

				set @rate1 = (select rate from temp_billlist where tableid=@tableid and kotid=@kotid and itemid=@baritemid)
			set @totalamount =  (select amount from temp_billlist where tableid=@tableid and kotid=@kotid and itemid=@baritemid)
			set @qty = (select qty from temp_billlist where tableid=@tableid and kotid=@kotid and itemid=@baritemid)
			set @tttax = (select taxamt from temp_billlist where tableid=@tableid and kotid=@kotid and itemid=@baritemid)
			SET @discamount = (select disamount from temp_billlist where tableid=@tableid and kotid=@kotid and itemid=@baritemid)
			set @discper = (select disper from temp_billlist where tableid=@tableid and kotid=@kotid and itemid=@baritemid)
			insert into Trans_BARkotBillraise_det(kotid,billid,itemid,qty,Rate,Amount,qty1,taxamount,discper,discamount)
			values(@kotid ,IDENT_CURRENT('Trans_BARkotBillraise_MAS')+1, @baritemid ,@qty,@rate1,@totalamount,
			@qty,@tttax,@discper,@discamount)
				-----------------------------------------------------------------------------------------------------------
                FETCH NEXT FROM kotitemsfetch170719 INTO  @Rate,@taxsetupid,@BarItemId,@kotid,@BarItemCode,@BarItemname,@iscombo,@iscocktail,@noofpax,@icecreamorfood
                END
                CLOSE kotitemsfetch170719
                DEALLOCATE kotitemsfetch170719



            set @amount = (select sum(amount) from temp_billlist where tableid=@tableid)
			set @discper = (select sum(disper) from temp_billlist where tableid=@tableid)
			set @totaldiscamount = (select sum(disamount) from temp_billlist where tableid=@tableid)
			set @toltaxableamt = (select sum(taxamt) from temp_billlist where tableid=@tableid)
			set @discreason = (select top 1 discountreason  from temp_billlist where tableid=@tableid and isnull(discountreason,'')<>'' ) 
			set @total = (@amount + @toltaxableamt )-@totaldiscamount
			
            	if (@total = 0) 
				BEGIN
					set @Settled = 1
				END
				ELSE
				BEGIN
					set @Settled = 0
				END

			Insert into Trans_BARkotBillraise_mas(Billno,Billdate,Billtime,Refdate,tableid,totalamount,
			itemtotal,Salestax,discamount,noofpax,roundoff,Settled,rOOMORTAB,userid,restypeid,crefno,sessionid,
			discountreason,Reftime,Membershipfee,MembershipfeeTax,serchexception )
			
			values(dbo.BillNo(),@date,@time,@refdate,@tableid,@total,@itemtotal,@toltaxableamt,
			@totaldiscamount,@noofpax,'0.00',@Settled,'T',@TUID, @RESID,dbo.BillNo(),
			@sessionid,@discreason,@reftime,@feeamount,@feetax,@Taxexemption)

			select IDENT_CURRENT('Trans_BARkotBillraise_mas') as id
			select @Settled as settle
-------------------------------------------------------------------------------------------------------------------------------------------------------

---- USERRIGHTS CHANGESS
truncate table User_Grouprights
truncate table usermodulerights



alter procedure Get__Authtenticate
@username varchar(100), @pass varchar(100)
as

select * from usertable where Emailid=@username
 and password=@pass and Emailid='SuperAdmin'

 insert into usertable(EmailId,password)values('SuperAdmin', 'Mgenn')

 update usertable set password='TWdlbm4=' where Emailid='SuperAdmin'

 

create procedure exec__department
@department varchar(1000), @inactive bigint=0,@dept_id bigint=0, @type varchar(10)
As
declare @check bigint

if(@type ='SAVE')
BEGIN
	set @check= (select count(*) from department where department=@department)
	if(@check=0)
	BEGIN
		insert into department(department,inactive)values(@department,'0')
		select 'Saved Successfully!!' as msg
	END
	Else
	BEGIN
		select 'Department Already Exists' as msg
	END
	
END

if(@type ='UPDATE')
begin
	set @check= (select count(*) from department where department=@department and Deptid<>@dept_id)
	if(@check=0)
	BEGIN
		update department set department=@department,inactive=@inactive where Deptid=@dept_id
		select 'Updated Successfully!' as msg
	END
	Else
	BEGIN
		select 'Department Already Exists' as msg
	END
	
end

if(@type ='DELETE')
begin
	Delete from  department  where Deptid=@dept_id
	select 'Deleted Successfully!' as msg
end






create procedure [dbo].[Get__Department]
@ID bigint 
As 

select * from department where deptid =(case when @ID=0 then Deptid else @ID end) 


alter  procedure Get__Departments

As
select * from department where isnull(inactive,0)<>1

CREATE TABLE [dbo].[User_GroupRights](
	[GroupRights_Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Show] [bigint] NULL,
	[Fview] [bigint] NULL,
	[FAdd] [bigint] NULL,
	[FEdit] [bigint] NULL,
	[Fdelete] [bigint] NULL,
	[FPrint] [bigint] NULL,
	[UserGroup_Id] [bigint] NULL,
	[SubMenu_Id] [bigint] NULL,
	[Mainmenu_id] [bigint] NULL
) ON [PRIMARY]


CREATE TABLE [dbo].[UserGroup](
	[UserGroup_Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserGroup] [varchar](200) NULL,
	[Hotel_Id] [bigint] NULL CONSTRAINT [DF_UserGroup_HotelId]  DEFAULT ((0)),
	[Description] [varchar](1000) NULL,
	[iscrm] [bigint] NULL,
	[inactive] [bigint] NULL
) ON [PRIMARY]





alter table usergroup add inactive bigint

create procedure exec__usergroup
@usergroup varchar(1000), @inactive bigint=0,@usergroup_id bigint,
 @type varchar(10)
As
declare @check bigint

if(@type ='SAVE')
BEGIN
	set @check= (select count(*) from usergroup where usergroup=@usergroup)
	if(@check=0)
	BEGIN
		insert into usergroup(usergroup,inactive)values(@usergroup,'0')
		select 'Saved Successfully!!' as msg
	END
	Else
	BEGIN
		select 'UserGroup Already Exists' as msg
	END
	
END

if(@type ='UPDATE')
begin
	set @check= (select count(*) from usergroup where usergroup=@usergroup 
	and usergroup_id<>@usergroup_id)
	if(@check=0)
	BEGIN
		update usergroup set usergroup=@usergroup,inactive=@inactive
		 where usergroup_id=@usergroup_id
		select 'Updated Successfully!' as msg
	END
	Else
	BEGIN
		select 'UserGroup Already Exists' as msg
	END
	
end

if(@type ='DELETE')
begin
	Delete from  usergroup  where usergroup_id=@usergroup_id
	select 'Deleted Successfully!' as msg
end



create procedure Get__UserGroup
 @ID Bigint
As
select * from usergroup where usergroup_id=(case when @ID=0 then usergroup_id else @ID end)

create procedure Get__UserGroups

As
select * from usergroup where isnull(inactive,0)<>1


create procedure Get__UserGroups

As
select * from usergroup where isnull(inactive,0)<>1

alter table usertable add inactive bigint

create procedure Get__user

as
select * from usertable where isnull(inactive,0)<>1

create procedure Get__users
@ID bigint=0
as
select * from usertable where user_id=(case  when @ID=0 then user_id else @ID end)

alter table usertable alter column password varchar(2000)
alter table usertable add repassword varchar(2000)

alter table usertable add department_id bigint
select * from usertable
alter table usertable add username varchar(100)
alter table usertable add usergroup_id bigint

alter table usertable add loginlockoutafter varchar(1000)

alter table usertable add lockoutduration varchar(1000)
alter table usertable add resetafter varchar(1000)



select * from usertable

create procedure exec__users
@loginname varchar(1000), @username varchar(100), @pass varchar(2000),@repass varchar(2000),
@usergroup bigint, @department bigint,@loginlockout varchar(10),@logoutduration varchar(100),
@reset varchar(100),@inactive bigint, @user_id bigint, @type varchar(100)
As
declare @check bigint

if(@type ='SAVE')
BEGIN
	set @check= (select count(*) from usertable where Emailid=@loginname)
	if(@check=0)
	BEGIN
		insert into usertable(emailid,username,password,repassword,usergroup_id,
		department_id,loginlockoutafter,lockoutduration,resetafter
		,inactive)values(@loginname,@username,@pass,@repass,@usergroup,@department,
		@loginlockout,@logoutduration,@reset,'0')
		select 'Saved Successfully!!' as msg
	END
	Else
	BEGIN
		select 'Login Username Already Exists' as msg
	END
	
END

if(@type ='UPDATE')
begin
	set @check= (select count(*) from usertable where emailid=@loginname and User_id<>@user_id)
	if(@check=0)
	BEGIN
		update usertable set emailid=@loginname,username=@username,password=@pass,
	    repassword=@repass,usergroup_id=@usergroup,department_id=@department,
		loginlockoutafter=@loginlockout,lockoutduration=@logoutduration,
		resetafter=@reset,inactive=@inactive where user_id=@user_id
		select 'Updated Successfully!' as msg
	END
	Else
	BEGIN
		select 'Login Username Already Exists' as msg
	END
	
end

if(@type ='DELETE')
begin
	Delete from  usertable  where user_id=@user_id
	select 'Deleted Successfully!' as msg
end




create procedure Get____modules
@ID bigint = 0
As
select * from modules  
where mdid=(case when @ID=0 then mdid else @ID end) and isnull(enabled,0)<>0




alter table menu add ismbar bigint not null default 1


CREATE TABLE [dbo].[Menu1](
	[Menu_Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Menu] [varchar](50) NULL,
	[Act] [bigint] NULL,
	[Ord] [bigint] NULL,
	[Vid] [bigint] NULL,
	[Addate] [datetime] NULL,
	[Edate] [datetime] NULL,
	[Uid] [bigint] NULL,
	[Icon] [varchar](100) NULL,
	[FType] [varchar](200) NULL,
	[Des] [varchar](100) NULL,
	[isirm] [bigint] NULL,
	[isfo] [bigint] NULL,
	[ismpos] [bigint] NULL,
	[ismbar] [bigint] NULL
) ON [PRIMARY]

GO



CREATE TABLE [dbo].[MainMenu1](
	[Mainmenu_id] [bigint] IDENTITY(1,1) NOT NULL,
	[Menu_id] [bigint] NULL,
	[SubMenu_id] [bigint] NULL,
	[Mainmenu] [varchar](1000) NULL,
	[IsActive] [bigint] NULL,
	[Orderby] [bigint] NULL,
	[Icon] [varchar](1000) NULL,
	[Des] [varchar](1000) NULL,
	[Uid] [bigint] NULL,
	[iscrm] [bigint] NULL
) ON [PRIMARY]





CREATE TABLE [dbo].[SubMenu1](
	[SubMenu_Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Menu_Id] [bigint] NULL,
	[Smenu] [varchar](50) NULL,
	[Des] [varchar](50) NULL,
	[Act] [bigint] NULL,
	[Ord] [bigint] NULL,
	[Icon] [varchar](50) NULL,
	[Mainmenu_id] [bigint] NULL,
	[NotshowingMenu] [bigint] NOT NULL DEFAULT ((0))
) ON [PRIMARY]

DROP TABLE SUBMENU1





INSERT INTO MENU1(MENU,ACT,ORD,ISMBAR)VALUES('Transaction', '1', '2','1')
INSERT INTO MENU1(MENU,ACT,ORD,ISMBAR)VALUES('Master', '1', '1','1')
INSERT INTO MENU1(MENU,ACT,ORD,ISMBAR)VALUES('Reports', '1', '3','1')
INSERT INTO MENU1(MENU,ACT,ORD,ISMBAR)VALUES('Settings', '1', '4','1')

insert into mainmenu1(menu_id,mainmenu,isactive,orderby,des)values('1','Table',1,1,'')
insert into mainmenu1(menu_id,mainmenu,isactive,orderby,des)values('1','Item',1,2,'')
insert into mainmenu1(menu_id,mainmenu,isactive,orderby,des)values('1','Employee',1,3,'Add_EmployeeMaster')
insert into mainmenu1(menu_id,mainmenu,isactive,orderby,des)values('1','ML',1,4,'Add_MLMaster')
insert into mainmenu1(menu_id,mainmenu,isactive,orderby,des)values('1','Supplier',1,5,'Add_Supplier')
insert into mainmenu1(menu_id,mainmenu,isactive,orderby,des)values('1','NC KOT',1,6,'Add_nonChangeKOT')
insert into mainmenu1(menu_id,mainmenu,isactive,orderby,des)values('1','NC Account',1,7,'Add_nonChargeAccount')
insert into mainmenu1(menu_id,mainmenu,isactive,orderby,des)values('1','Tax',1,8,'')
insert into mainmenu1(menu_id,mainmenu,isactive,orderby,des)values('1','Fire Master',1,9,'Add_fireMaster')
insert into mainmenu1(menu_id,mainmenu,isactive,orderby,des)values('1','General',1,10,'')

insert into mainmenu1(menu_id,mainmenu,isactive,orderby,des)values('2','Purchase Entry',1,1,'Purchase_Entry')
insert into mainmenu1(menu_id,mainmenu,isactive,orderby,des)values('2','Inward',1,1,'Inward')
insert into mainmenu1(menu_id,mainmenu,isactive,orderby,des)values('2','Stock Adjustment',1,1,'Adjustment')
insert into mainmenu1(menu_id,mainmenu,isactive,orderby,des)values('2','Stock Opening',1,1,'Stockopening')

insert into mainmenu1(menu_id,mainmenu,isactive,orderby,des)values('4','Data Purging',1,1,'DataPurging')
insert into mainmenu1(menu_id,mainmenu,isactive,orderby,des)values('4','BarSettings',1,2,'BarSettings')

insert into mainmenu1(menu_id,mainmenu,isactive,orderby,des)
values('3','Kot Bill Cancellation',1,1,'KotBill_cancellation')
insert into mainmenu1(menu_id,mainmenu,isactive,orderby,des)
values('3','NC-Kot Type',1,2,'NCKotType')
insert into mainmenu1(menu_id,mainmenu,isactive,orderby,des)
values('3','Discount',1,3,'Discount')
insert into mainmenu1(menu_id,mainmenu,isactive,orderby,des)
values('3','Stock Report ',1,8,'StockReport')
insert into mainmenu1(menu_id,mainmenu,isactive,orderby,des)
values('3','As On Date Sales ',1,7,'SalesReport')
insert into mainmenu1(menu_id,mainmenu,isactive,orderby,des)
values('3','Purchase',1,11,'Purchase_Entry')
insert into mainmenu1(menu_id,mainmenu,isactive,orderby,des)
values('3','Inward',1,12,'Inward_Report')
insert into mainmenu1(menu_id,mainmenu,isactive,orderby,des)
values('3','Store Stock ',1,13,'StockReport')
insert into mainmenu1(menu_id,mainmenu,isactive,orderby,des)
values('3','NC KOT Bill Wise',1,1,'NcKotBillWise')
insert into mainmenu1(menu_id,mainmenu,isactive,orderby,des)
values('3','Date Wise Hourly Sales',1,3,'DateWiseHSales')
insert into mainmenu1(menu_id,mainmenu,isactive,orderby,des)
values('3','Hourly Item Wise Sales',1,4,'Hourly_ItemWise')
insert into mainmenu1(menu_id,mainmenu,isactive,orderby,des)
values('3','Steward Wise',1,5,'steward')
insert into mainmenu1(menu_id,mainmenu,isactive,orderby,des)
values('3','KOT Wise',1,6,'KotwiseReport')
insert into mainmenu1(menu_id,mainmenu,isactive,orderby,des)
values('3','Settlement Wise',1,7,'Settlementwise')
insert into mainmenu1(menu_id,mainmenu,isactive,orderby,des)
values('3','Table Wise Bill Details',1,8,'TablewiseBilldetails')
insert into mainmenu1(menu_id,mainmenu,isactive,orderby,des)
values('3','Kot Cancellation',1,9,'KotBill_cancellation')
insert into mainmenu1(menu_id,mainmenu,isactive,orderby,des)
values('3','Bar Stock ',1,14,'BarReport')
insert into mainmenu1(menu_id,mainmenu,isactive,orderby,des)
values('3','Adjustment',1,15,'AdjustmentReport')





insert into submenu1(menu_id,smenu,des,act,ord,mainmenu_id)
values(1,'Table Group','Add_TableGroup',1,1,1)
insert into submenu1(menu_id,smenu,des,act,ord,mainmenu_id)
values(1,'Table','Add_TableMaster',1,2,1)

insert into submenu1(menu_id,smenu,des,act,ord,mainmenu_id)
values(1,'Store Item','Add_StoreItemMaster',1,3,2)
insert into submenu1(menu_id,smenu,des,act,ord,mainmenu_id)
values(1,'Item Group','Add_ItemGroup',1,2,2)
insert into submenu1(menu_id,smenu,des,act,ord,mainmenu_id)
values(1,'Bar Item','Add_BarItemMaster',1,4,2)
insert into submenu1(menu_id,smenu,des,act,ord,mainmenu_id)
values(1,'Item Category','Add_itemCategory',1,1,2)

insert into submenu1(menu_id,smenu,des,act,ord,mainmenu_id)
values(1,'Tax Setup','TaxSetup',1,2,8)
insert into submenu1(menu_id,smenu,des,act,ord,mainmenu_id)
values(1,'Tax Type','Add_taxType',1,1,8)
insert into submenu1(menu_id,smenu,des,act,ord,mainmenu_id)
values(1,'Company','Add_Company',1,1,10)



EXEC sp_rename 'mainmenu1', 'mainmenu'
EXEC sp_rename 'submenu1', 'submenu'
EXEC sp_rename 'menu1', 'menu'
-----------------------------------------------------------------------
USE [elanzalot]
GO
/****** Object:  StoredProcedure [dbo].[Exec_BillSave__separatefoodbill]    Script Date: 08/05/2024 19:14:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[Exec_BillSave__separatefoodbill]
@Tableid Bigint,
@Taxexemption bigint,
@Billdate Datetime,
@Billtime Datetime,
@userid bigint
As 
BEGIN
declare @loopthrough bigint,@setcount bigint,@setbillid bigint
set @setcount =0;
declare loopingicecreamorfood1 cursor for

SELECT  isnull(ig.icecreamorfood,0)icecreamorfood FROM Trans_BARKot_mas m
				INNER JOIN Trans_BARKot_det d ON d.kotid=m.Kotid
				inner join bar_itemdet_id id on id.RefBarItemid=d.itemid
				inner join Stock_itemmmas sitm on sitm.Itemid=id.storeitemid
				inner join itemgroup ig on ig.Itemgroupid=sitm.Itemgroupid
				INNER JOIN Bar_itemmmas  i ON i.barItemid=d.itemid
				WHERE isnull(m.Raised,0)=0 AND m.tableid=@tableid and 
				isnull(d.cANCELORNORM,'')<>'C' and isnull(SplitBillRaised,0)=0 
				group by ig.icecreamorfood 
				order by ig.icecreamorfood desc
open loopingicecreamorfood1 
FETCH NEXT FROM loopingicecreamorfood1 INTO  @loopthrough
WHILE @@FETCH_STATUS = 0
Begin
	set @setcount = @setcount+1;
		declare @refbilldetid bigint, @Fooddisamount numeric(12,2), @FoodAmount numeric(12,2),@FeeAmount numeric(12,2),@FeeTax numeric(12,2)
		declare @Membershipfee numeric(12,2),@MembershipfeeTax numeric(12,2),@AdditionalMembershipfee numeric(12,2),@itemtotal numeric(12,2)
		declare @masItemTotal numeric(12,2),@masTax numeric(12,2),@roundoff numeric(12,2),@totaldiscount numeric(12,2),@totalamount numeric(12,2)
		select @Membershipfee=(select Membershipfee from application_settings)
		select @MembershipfeeTax=(select MembershipfeeTax from application_settings)
		select @AdditionalMembershipfee=(select AdditionalMembershipfee from application_settings)
		declare @disper numeric(12,2),@disamount numeric(12,2),@discountreason varchar(500),@MFee numeric(12,2),@MFeeTax numeric(12,2),
		@billno varchar(100),@billnumbercount bigint,@tcnt bigint,@scamount numeric(12,2)

		    set @billno = (select dbo.sep_foodbill_raise('L') )
		    if(@loopthrough =1)
				begin
					set @billno = (select dbo.sep_foodbill_raise('D') )
				end
			
			
				

			set @masItemTotal=0.00
			set @masTax=0.00
			set @roundoff=0.00
			set @totaldiscount=0.00
			set @MFee=0
			set @MFeeTax=0
			----- mas Table Insert Star
				
				       if(@setcount =2)
						begin
							set @setbillid = (select ident_current('Trans_barkotbillraise_mas'))
						end
					
						insert into Trans_barkotbillraise_mas(Billno,Billdate,Billtime,Refdate,tableid,totalamount,itemtotal,Salestax,discamount,noofpax,Settled,rOOMORTAB,userid,roundoff,restypeid,crefno,sessionid,Reftime,Membershipfee,MembershipfeeTax,serchexception,discountreason,firstbillid)
						Values(@billno,@Billdate,@Billtime,convert(VARCHAR,getdate(),101),@Tableid,ROUND((@totalamount),0),@masItemTotal,@masTax,@totaldiscount,(select Top 1 noofpax from Trans_barkot_mas where Tableid=@Tableid and isnull(Raised,0)=0 ),0,'T',@userid,@roundoff,0,dbo.BillNo(),0,convert(VARCHAR,getdate(),108),@MFee,@MFeeTax,@Taxexemption,@discountreason,@setbillid)
						DECLARE @Billid INT
						SET @Billid = SCOPE_IDENTITY()
					----Mas Table Insert end

			select @FoodAmount = (SELECT isnull(sum(d.Amount),0) FROM Trans_BARKot_mas m
						INNER JOIN Trans_BARKot_det d ON d.kotid=m.Kotid
						inner join Trans_BarKotdet_id id on id.Refkotdetid=d.kotdetid
						inner join Stock_itemmmas sitm on sitm.Itemid=id.storeitemid
						inner join itemgroup ig on ig.Itemgroupid=sitm.Itemgroupid
						INNER JOIN Bar_itemmmas  i ON i.barItemid=d.itemid
					    WHERE isnull(m.Raised,0)=0 AND m.tableid=@Tableid and 
						isnull(d.cANCELORNORM,'')<>'C' and isnull(SplitBillRaised,0)=0 
						and isnull(ig.icecreamorfood,0)=@loopthrough  and isnull(m.nckot,0)=0 
						and isnull(d.Amount,0)<>'0'  )
			print 'Food Amout'
			print @FoodAmount
			select @Fooddisamount=(select isnull(sum(tb.disamount),0) from temp_billlist tb
							inner join Stock_itemmmas st on st.Itemid=tb.stock_id
							inner join itemgroup ig on ig.Itemgroupid=st.Itemgroupid
							where tb.tableid=@Tableid and isnull(ig.icecreamorfood,0)=@loopthrough)
			print '@Fooddisamount'
			print @Fooddisamount
			declare @icecreamorfood bigint,@itemid bigint,@Kotid bigint,@noofpax bigint,@kotdetid bigint,@Kotno Varchar(50),@Itemname varchar(500),@qty numeric(12,2),@Rate Numeric(12,2),@Amount Numeric(12,2),@taxsetupid bigint,@Itemgroupid bigint
			declare @feeper numeric(12,4)			
			set @MFee=0.00
			set @MFeeTax=0.00
			declare kotitemsfetch001 cursor for 
			SELECT ig.icecreamorfood,d.itemid,m.Kotid,m.noofpax,d.kotdetid,m.Kotno,i.barItemname AS Itemname,d.qty,d.Rate,d.Amount,s.Itemgroupid,ig.taxsetupid FROM Trans_BARKot_mas m
			INNER JOIN Trans_BARKot_det d ON d.kotid=m.Kotid
			INNER JOIN Bar_itemmmas  i ON i.barItemid=d.itemid
			INNER JOIN Bar_Itemdet_id bdet ON i.BarItemid = bdet.RefBarItemid 
			INNER JOIN Stock_Itemmmas s ON s.itemid = bdet.storeitemid 
			Inner join Itemgroup ig on ig.Itemgroupid=s.Itemgroupid
			WHERE isnull(m.Raised,0)=0 AND m.tableid=@tableid and isnull(d.cANCELORNORM,'')<>'C'
			 and isnull(SplitBillRaised,0)=0 and isnull(ig.icecreamorfood,0)=@loopthrough and isnull(m.nckot,0)=0
			  order by Kotdetid
			open kotitemsfetch001     
			FETCH NEXT FROM kotitemsfetch001 INTO @icecreamorfood, @itemid,@Kotid,@noofpax,@kotdetid,@Kotno,@Itemname,@qty,@Rate,@Amount,@Itemgroupid,@taxsetupid
			WHILE @@FETCH_STATUS = 0
			BEGIN
			 ----first loop start
			  print 'Loop Start'
			  set @itemtotal=0
	
			  ---Dicount Verification Start
			  select @disper=(select isnull(disper,0) from temp_billlist where tableid=@Tableid and itemid=@itemid 
			  and kotid=@Kotid )
			  select @disamount=(select isnull(disamount,0) from temp_billlist where tableid=@Tableid and itemid=@itemid and kotid=@Kotid )
			  select @discountreason=(select discountreason from temp_billlist where tableid=@Tableid and itemid=@itemid and kotid=@Kotid) 	 
	
			  if isnull(@disper,0) ='0.00'
			  BEGIN
			   set @disper ='0.00'
			  END
			  print '@disper'
			  print @disper
				if isnull(@disamount,0) ='0.00'
			  BEGIN
			   set @disamount =0.00
			  END
			  if @disamount !=0.00
			  BEGIN
			   set @Amount =@Amount-@disamount
			  END
	  
			  -----Dicount Verification END

			  ---Memebr fee calculation Start
			  if @noofpax =0
			  BEGIN
			   set @noofpax=1
			  END
			 declare @AditionaalCount bigint,@ItemTax numeric(12,2),@AdditionalMembershipfeeItem bigint


			  if (@FoodAmount-@Fooddisamount) ='0.00' 
			  BEGIN
				set @FeeAmount ='0'
				set @FeeTax='0'
			  END
			  else
			  BEGIN	    
				if @noofpax=1
				BEGIN
				  print 'Pax 1'
				  set @FeeAmount = (@Membershipfee/118)*100;
				  set @FeeTax = (@FeeAmount * @MembershipfeeTax) / 100;
				  set @MFee =@FeeAmount
				  set @MFeeTax=@FeeTax
				  print @MFee
				  print @MFeeTax
				END
				ELSE
				BEGIN
				  print 'Else'
				  set @AditionaalCount =@noofpax-1		  
				  print '@AditionaalCount'
				  print @AditionaalCount
				  set @AdditionalMembershipfeeItem = @AdditionalMembershipfee * @AditionaalCount	
				  print '@AdditionalMembershipfee'
				  print @AdditionalMembershipfeeItem
				  set @FeeAmount = ((@Membershipfee + @AdditionalMembershipfeeItem)/118)*100;
				  set @FeeTax = (@FeeAmount * @MembershipfeeTax) / 100;	
				  set @MFee =@FeeAmount
				  set @MFeeTax=@FeeTax
				  print '@MFeeTax'
				  print @MFeeTax
				END
		
			  END	  
			  ---Member fee calculation END
			  set @feeper=0
			  Insert into Trans_barkotbillraise_det(kotid,billid,itemid,qty,Rate,Amount,qty1,discper,discamount,taxamount,Membershipfeediscount)
			  Values(@Kotid,@Billid,@itemid,@qty,@Rate,@itemtotal,@qty,@disper,@disamount,@ItemTax,@feeper)
			  SET @refbilldetid = SCOPE_IDENTITY()
			  Insert into trans_barkotbilltax_det (refbilldetid,Amount,Percentage,taxtypeid,billid,taxid)
			  Values(@refbilldetid,@Amount,'0.00',@taxsetupid,@Billid,(select taxid from taxtype where taxtype='ITEM TOTAL'))

			print @Itemname
					---Second Loop Start
					set @ItemTax=0.00
					declare @taxid bigint,@headcode varchar(10),@percentage numeric(12,2),@Accid bigint,@totalfee numeric(12,2),@taxableamt numeric(12,2)
	  				declare @taxtotal numeric(12,2)		
					declare kotitemsfetch002 cursor for 
					select id.Accid,tx.taxid,headcode,percentage from taxsetupmas tsm
					INNER JOIN taxsetupdet tsd on tsd.taxsetupid=tsm.Taxsetupid
					inner join  taxtype tx on tx.taxid=tsd.Accid
					inner join taxsetupACdet id on id.taxsetupdetid=tsd.taxsetupdetid
					where tsm.Taxsetupid=@taxsetupid and  id.selected=1

					open kotitemsfetch002     
					FETCH NEXT FROM kotitemsfetch002 INTO  @Accid,@taxid,@headcode,@percentage
					WHILE @@FETCH_STATUS = 0
					BEGIN		
					set @taxtotal=0
					if @Accid = (select taxid from taxtype where taxtype='ITEM TOTAL')
					BEGIN
						  print 'Second Loop'				
						  if (@headcode ='CGST2' and @icecreamorfood='1')
						  Begin 
							set @totalfee =@FeeAmount+@FeeTax
							print @headcode
							if (@FoodAmount-@Fooddisamount) >0 
							BEGIN
							set @feeper=@totalfee/(@FoodAmount-@Fooddisamount);
							END
							ELSE
							BEGIN
							set @feeper=0
							END
							print @feeper
							set @feeper=@feeper*100;
							print @feeper
							set @feeper=(@Amount*@feeper)/100;
							print @feeper
							set @taxableamt=@Amount-@feeper							
						  End
						  ELSE if (@headcode ='SGST2' and @icecreamorfood='1')
						  Begin 
							set @totalfee =@FeeAmount+@FeeTax
							print @headcode
							if (@FoodAmount-@Fooddisamount) >0 
							BEGIN
							  set @feeper=@totalfee/(@FoodAmount-@Fooddisamount);
							END
							ELSE
							BEGIN
							  set @feeper=0
							END
							print @feeper
							set @feeper=@feeper*100;
							print @feeper
							set @feeper=(@Amount*@feeper)/100;
							print @feeper
							set @taxableamt=@Amount-@feeper							
						  End
						  Else if (@headcode ='SC' and @Taxexemption='1')
						  BEGIN				   	
							set @taxableamt=0								
						  END
						  else
						  BEGIN						  
						   set @taxableamt=@Amount				  
						  END				 
						  ---set @taxtotal=(@taxableamt*@percentage)/100; 
						  if (@headcode ='CGST2' or @headcode ='SGST2')
						  begin
						    print 'sc'
							print @scamount 
						    set @taxtotal=((isnull(@taxableamt,0)+isnull(@scamount,0))*@percentage)/100; 
							print @taxtotal
						  end
						  else
						  begin			 
						  set @taxtotal=(@taxableamt*@percentage)/100; 
						  set @scamount = @taxtotal
						  end
							Insert into trans_barkotbilltax_det (refbilldetid,Amount,Percentage,taxtypeid,billid,taxid)
							Values(@refbilldetid,@taxtotal,@percentage,@taxsetupid,@Billid,@taxid)		
								
					END
					ELSE
					BEGIN
					 print 'without item total Start'
					   print 'without item total end'
					END
					print 'tax'
					print @ItemTax
					print @taxtotal
					 set @ItemTax=(@ItemTax+@taxtotal)
					FETCH NEXT FROM kotitemsfetch002 INTO  @Accid,@taxid,@headcode,@percentage
					END
					CLOSE kotitemsfetch002
					DEALLOCATE kotitemsfetch002
					---secondloop End
					print '@feeper'
					if @icecreamorfood=0
					BEGIN
					 set @feeper=0.00
					END			
					set @itemtotal = ((@Rate*@qty)+(@ItemTax)-@disamount)
					set @masItemTotal=@masItemTotal+(@Rate*@qty)
					set @masTax=@masTax+@ItemTax
					print '@masTax'
					print @masTax
					set @totaldiscount=@totaldiscount+@disamount
				     
		
				  Update Trans_barkotbillraise_det set Amount=@itemtotal,discper=@disper,discamount=@disamount,taxamount=@ItemTax,Membershipfeediscount=@feeper where billdetid=@refbilldetid
		
				  print 'Loop End'
			----first loop End
			FETCH NEXT FROM kotitemsfetch001 INTO @icecreamorfood, @itemid,@Kotid,@noofpax,@kotdetid,@Kotno,@Itemname,@qty,@Rate,@Amount,@Itemgroupid,@taxsetupid
			END
			CLOSE kotitemsfetch001
			DEALLOCATE kotitemsfetch001
			print '@masItemTotal'
			print @masItemTotal
			print @masTax
			print '@totaldiscount'
			print @totaldiscount
			set @totalamount=(@masItemTotal+@masTax )- @totaldiscount
			set @roundoff= ROUND( @totalamount,0)-(@totalamount)

			Update Trans_barkotbillraise_mas set totalamount=ROUND((@totalamount),0),itemtotal=@masItemTotal,Salestax=@masTax,discamount=@totaldiscount,roundoff=@roundoff,Membershipfee=@MFee,MembershipfeeTax=@MFeeTax,discountreason=@discountreason where Billid=@Billid
			
						
	




			if (@masItemTotal+@masTax = 0) 
			BEGIN
				--Update tablemas set Status='S' where Tableid=@Tableid
				update Trans_BARkotBillraise_mas set Settled=1 where Billid=@Billid
			END
			--ELSE
			--BEGIN

				--Update tablemas set Status='B' where Tableid=@Tableid
			--END
			
	 
		

			  FETCH NEXT FROM loopingicecreamorfood1 INTO @loopthrough 
                END

				 Update Trans_barkot_mas set Raised=1 where Tableid=@Tableid and isnull(Raised,0)=0
			    select @Billid as id
				if (@masItemTotal+@masTax = 0) 
					BEGIN
						Update tablemas set Status='S' where Tableid=@Tableid
					END
				else
					begin
						Update tablemas set Status='B' where Tableid=@Tableid
					end
				 CLOSE loopingicecreamorfood1
                DEALLOCATE loopingicecreamorfood1
	

END

=======Settlement Script ============================================
Create procedure [dbo].[Updatesettlement_cc]
as
declare @settlid bigint,@totalamt bigint
declare updateroomcnt cursor for select settlid,totalamt from trans_barkotsettlement1_det where settlid not in 
                                 (select setllid from trans_barkotsettlement_det)  
open updateroomcnt
FETCH NEXT FROM updateroomcnt INTO @settlid,@totalamt
WHILE @@FETCH_STATUS = 0
BEGIN

insert into trans_barkotsettlement_det(setllid,amount,paymodeid)
values(@settlid,@totalamt,11)
 
FETCH NEXT FROM updateroomcnt INTO @settlid,@totalamt
END
CLOSE updateroomcnt
DEALLOCATE updateroomcnt


