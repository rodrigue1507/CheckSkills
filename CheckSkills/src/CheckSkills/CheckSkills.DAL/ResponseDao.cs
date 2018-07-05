using CheckSkills.Domain;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Text;

namespace CheckSkills.DAL
{
    class ResponseDao : IResponseDao
    {
        //chaine de connexion base de donnée
        private string connectionString = @"Data Source=SGEW0481\FORMULAIRE;Initial Catalog=CheckSkills;Integrated Security=true";

        public string Name { get; private set; }

        public IEnumerable<Response> GetAll()
        {

            // Use ADO.Net to DB access
            var Responses = new List<Response>();

            try
            {
                //objet de connection 
                using (var connection = new SqlConnection(connectionString))
                {
                    // Do work here
                    connection.Open();
                    //objet permettant de faire des requêtes SQL
                    var scriptGetAllResponse = @"
                                                SELECT 
	                                                r.Id,
	                                                r.Content,
                                                    r.isCorrect
                                                    FROM Response r
                                                            ";

                    var sqlCommand = new SqlCommand(scriptGetAllResponse, connection);
                    //recupère les données dans la resultReader
                    var resultReader = sqlCommand.ExecuteReader(); //lecture et stockage du resultat dans resultReader
                    //parse ResultReader 
                    while (resultReader.Read())
                    {
                        var Response = new Response()
                        {
                            Id = Convert.ToInt32(resultReader["Id"]),//recupère l'id de Category dans la database et le converti
                            Content = resultReader["Content"].ToString(),
                            IsCorrect = (bool)resultReader["isCorrect"],
                        };
                        Responses.Add(Response);
                    }
                }

            }
            catch (Exception e)
            {
                Console.WriteLine("L'erreur suivante a été rencontrée :" + e.Message);
            }

            return Responses;
        }
    }
}
