USE  [CheckSkills]
 GO
IF  EXISTS(SELECT NULL FROM sys.procedures WHERE name='UpdateQuestionDifficultyDetails')
DROP UpdateQuestionDifficultyDetails

GO
Create procedure [dbo].[UpdateQuestionDifficultyDetails]  
(  
	@qtId INT,
	@QuestionDifficultyLevel  INT 
 
)  
as
begin  
   Update QuestionDifficulty   
   set QuestionDifficultyLevel = @QuestionDifficultyLevel   
   where Id=@qtId  
End