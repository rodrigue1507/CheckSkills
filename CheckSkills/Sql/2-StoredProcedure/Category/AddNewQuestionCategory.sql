USE  [CheckSkills]
 Go
 IF  EXISTS(SELECT NULL FROM sys.procedures WHERE name='AddNewQuestionCategory')
DROP PROCEDURE AddNewQuestionCategory
Go
Create procedure [dbo].[AddNewQuestionCategory]  

 @Name varchar (50)
as
BEGIN 
  INSERT INTO QuestionCategory (Name) 
  VALUES 
	(@Name)
END

