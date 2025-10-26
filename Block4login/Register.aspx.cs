using System;
using MySql.Data.MySqlClient;
using System.Text.RegularExpressions;

public partial class Register : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Username"] == null)
            Response.Redirect("Login.aspx");
    }

    protected void btnRegister_Click(object sender, EventArgs e)
    {
        string username = Session["Username"].ToString();
        string password = Session["Password"].ToString();
        string fullName = txtFullName.Text.Trim();
        string job = txtJob.Text.Trim();
        string birthdateText = txtBirthdate.Text.Trim();

        // Validation
        DateTime birthdateValue;
        if (string.IsNullOrEmpty(fullName) || string.IsNullOrEmpty(job) ||
            string.IsNullOrEmpty(birthdateText) || !DateTime.TryParse(birthdateText, out birthdateValue))
        {
            lblMessage.Text = "Invalid input. Please fill all fields correctly.";
            return;
        }

        // Additional backend check: no numbers in job
        if (Regex.IsMatch(job, @"\d"))
        {
            lblMessage.Text = "Job cannot contain numbers!";
            return;
        }

        string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

        using (MySqlConnection conn = new MySqlConnection(connStr))
        {
            conn.Open();

            // Check if user already registered
            string checkQuery = "SELECT COUNT(*) FROM Users WHERE Username=@Username";
            using (MySqlCommand checkCmd = new MySqlCommand(checkQuery, conn))
            {
                checkCmd.Parameters.AddWithValue("@Username", username);
                int exists = Convert.ToInt32(checkCmd.ExecuteScalar());
                if (exists > 0)
                {
                    lblMessage.Text = "User already registered!";
                    return;
                }
            }

            string insertQuery = @"INSERT INTO Users (Username, Password, FullName, Birthdate, Job)
                                   VALUES (@Username, @Password, @FullName, @Birthdate, @Job)";

            using (MySqlCommand cmd = new MySqlCommand(insertQuery, conn))
            {
                cmd.Parameters.AddWithValue("@Username", username);
                cmd.Parameters.AddWithValue("@Password", password);
                cmd.Parameters.AddWithValue("@FullName", fullName);
                cmd.Parameters.AddWithValue("@Birthdate", birthdateValue.ToString("yyyy-MM-dd"));
                cmd.Parameters.AddWithValue("@Job", job);

                cmd.ExecuteNonQuery();
            }
        }

        Response.Redirect("Home.aspx");
    }
}
