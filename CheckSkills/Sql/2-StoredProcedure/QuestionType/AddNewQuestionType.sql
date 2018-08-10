USE  [CheckSkills]
 GO
IF  EXISTS(SELECT NULL FROM sys.procedures WHERE name='AddNewQuestionType')
DROP PROCEDURE AddNewQuestionType

GO
Create procedure [dbo].[AddNewQuestionType]  
(
 @Name   Varchar(50) 
)

AS
BEGIN 
  INSERT INTO QuestionType (Name) VALUES( @Name);
END
