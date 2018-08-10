USE  [CheckSkills]
 Go
IF  EXISTS(SELECT NULL FROM sys.procedures WHERE name='GetByIdQuestionDifficultyDetails')
DROP PROCEDURE GetByIdQuestionDifficultyDetails

GO
Create procedure [dbo].[GetByIdQuestionDifficultyDetails]  
(
	@Id INT
)
AS
BEGIN 
  SELECT Id,QuestionDifficultyLevel  FROM  QuestionDifficulty WHERE  Id = @Id; 
END
