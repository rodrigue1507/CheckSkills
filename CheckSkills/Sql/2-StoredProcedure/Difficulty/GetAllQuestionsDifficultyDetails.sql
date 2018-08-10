USE  [CheckSkills]
 Go
IF  EXISTS(SELECT NULL FROM sys.procedures WHERE name='GetAllQuestionsDifficultyDetails')
DROP PROCEDURE GetAllQuestionsDifficultyDetails

GO
Create procedure [dbo].[GetAllQuestionsDifficultyDetails]  

AS
BEGIN 
  SELECT Id,QuestionDifficultyLevel  FROM  QuestionDifficulty; 
END
