Create procedure [dbo].[UpdatecategoryDetails]  
(  
	@ctgId int,
	@Name nvarchar (50),  
	@Content nvarchar (50)  
)  
as
begin  
   Update Category   
   set Name=@Name,  
   content=@Content,    
   where Id=@ctgId  
End