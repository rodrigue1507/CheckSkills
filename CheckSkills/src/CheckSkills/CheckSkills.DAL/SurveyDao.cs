using CheckSkills.Domain;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using CheckSkills.Domain.Entities;
using System.Text;

namespace CheckSkills.DAL
{
    class SurveyDao : ISurveyDao
    {
        //chaine de connexion base de donnée
        private readonly string _connectionString = @"Data Source=SGEW0481\FORMULAIRE;Initial Catalog=CheckSkills;Integrated Security=true";

        public string Name { get; private set; }
       

        public IEnumerable<Survey> GetAll()
        {

            // Use ADO.Net to DB access
            var surveys = new List<Survey>();

            try
            {
                //objet de connection 
                using (var connection = new SqlConnection(_connectionString))
                {
                    // Do work here
                    connection.Open();
                    //objet permettant de faire des requêtes SQL
                    var scriptGetAllSurvey = @"
                                                SELECT 
	                                                s.Id,
                                                    s.Name,
                                                    s.Content
	                                                FROM Survey s
                                                ";

                    var sqlCommand = new SqlCommand(scriptGetAllSurvey, connection);
                    //recupère les données dans la resultReader
                    var resultReader = sqlCommand.ExecuteReader(); //lecture et stockage du resultat dans resultReader
                    //parse ResultReader 
                    while (resultReader.Read())
                    {
                        var Survey = new Survey()
                        {
                            Id = Convert.ToInt32(resultReader["Id"]),//recupère l'id de Difficulty dans la database et le convert
                            Name = resultReader["Name"].ToString(),
                            Content = resultReader["Content"].ToString(),
                        };
                        surveys.Add(Survey);
                    }
                }

            }
            catch (Exception e)
            {
                Console.WriteLine("L'erreur suivante a été rencontrée :" + e.Message);
            }

            return surveys;
        }
    }

}


  
