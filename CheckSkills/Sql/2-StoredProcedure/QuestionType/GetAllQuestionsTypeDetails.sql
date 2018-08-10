USE  [CheckSkills]
GO
IF  EXISTS(SELECT NULL FROM sys.procedures WHERE name='GetAllQuestionsTypeDetails')
DROP PROCEDURE GetAllQuestionsTypedetails
GO
Create procedure [dbo].[GetAllQuestionsTypeDetails]  

AS
BEGIN 
  Select Id,Name FROM QuestionType;
END
