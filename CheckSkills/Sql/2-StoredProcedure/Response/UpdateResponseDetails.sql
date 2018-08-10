USE  [CheckSkills]
GO
IF  EXISTS(SELECT NULL FROM sys.procedures WHERE name='UpdateResponseDetails')
DROP PROCEDURE UpdateResponseDetails
GO
Create procedure [dbo].[UpdateResponseDetails]  
(  
	@RId INT,
	@QuestionId INT,
	@Content Varchar(50)
)  
as
begin  
   Update Response   
   set QuestionId=@QuestionId,
   Content=@Content
   where Id=@Rid;  
End