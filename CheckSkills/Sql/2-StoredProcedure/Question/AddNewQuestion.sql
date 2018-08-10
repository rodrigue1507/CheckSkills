USE  [CheckSkills]
 Go
IF  EXISTS(SELECT NULL FROM sys.procedures WHERE name='AddNewQuestion')
DROP PROCEDURE AddNewQuestion

GO
Create procedure [dbo].AddNewQuestion  
(
 @questionCategoryId INT,
 @questionDifficultyId INT,
 @questionTypeId INT,
 @content VARCHAR(50)
)

AS
BEGIN 
  INSERT INTO Question(QuestionCategoryId,QuestionDifficultyId,QuestionTypeId,Content) VALUES( @questionCategoryId,@questionDifficultyId,@questionTypeId, @content);
END
