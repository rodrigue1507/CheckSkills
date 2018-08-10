USE  [CheckSkills]
 Go
IF  EXISTS(SELECT NULL FROM sys.procedures WHERE name='UpdateQuestionCategoryDetails')
DROP UpdateQuestionCategoryDetails
GO
Create procedure [dbo].[UpdateQuestionCategoryDetails]  
(  
	@ctgId int,
	@Name nvarchar (50) 
 
)  
as
begin  
   Update QuestionCategory   
   set Name=@Name       
   where Id=@ctgId  
End