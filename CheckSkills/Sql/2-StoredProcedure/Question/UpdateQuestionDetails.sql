USE  [CheckSkills]
GO
IF  EXISTS(SELECT NULL FROM sys.procedures WHERE name='UpdateQuestionDetails')
DROP PROCEDURE UpdateQuestionDetails
GO
Create procedure [dbo].[UpdateQuestionDetails]  
(  
	@Id INT,
	@QuestionCategoryId INT,
	@QuestionDifficultyId INT,
	@QuestionTypeId INT,
	@Content Varchar(50)
)  
as
begin  
   Update Question   
   set 
   QuestionCategoryId=@QuestionCategoryId,
   QuestionDifficultyId=@QuestionDifficultyId,
   QuestionTypeId=@QuestionTypeId
   where Id=@Id;  
End