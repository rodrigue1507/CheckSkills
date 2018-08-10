USE  [CheckSkills]
GO
IF  EXISTS(SELECT NULL FROM sys.procedures WHERE name='UpdateQuestionTypeDetails')
DROP PROCEDURE UpdateQuestionTypeDetails
GO
Create procedure [dbo].[UpdateQuestionTypeDetails]  
(  
	@qtId INT,
	@Name Varchar(50)
)  
as
begin  
   Update QuestionType   
   set Name=@Name 
   where Id=@qtId  
End