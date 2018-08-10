USE  [CheckSkills]
 Go
IF  EXISTS(SELECT NULL FROM sys.procedures WHERE name='AddNewQuestionDifficulty')
DROP PROCEDURE AddNewQuestionDifficulty

GO
Create procedure [dbo].[AddNewQuestionDifficulty]  
(
 @QuestionDifficultyLevel INT
)

AS
BEGIN 
  INSERT INTO QuestionDifficulty( QuestionDifficultyLevel) VALUES( @QuestionDifficultyLevel);
END
