using MySql.Data.MySqlClient;
using System;
using System.Data;
using System.Data.SqlClient;

public partial class Home : System.Web.UI.Page
{
    private string ConnStr => System.Configuration.ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Username"] == null)
            Response.Redirect("Login.aspx");

        lblWelcome.Text = "Welcome, " + Session["Username"].ToString();
        if (!IsPostBack)
            LoadUsers();
    }

    private void LoadUsers()
    {
        DataTable dt = new DataTable();
        try
        {
            using (MySqlConnection conn = new MySqlConnection(ConnStr))
            {
                conn.Open();
                string q = "SELECT ID, Username, FullName, Birthdate, Job FROM Users ORDER BY ID DESC";
                using (MySqlCommand cmd = new MySqlCommand(q, conn))
                using (MySqlDataAdapter da = new MySqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            gvUsers.DataSource = dt;
            gvUsers.DataBind();
            lblMessage.Text = "";
        }
        catch (Exception ex)
        {
            lblMessage.Text = "Error loading users: " + ex.Message;
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Response.Redirect("Register.aspx");
    }

    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        Response.Redirect("Login.aspx");
    }

    protected void gvUsers_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
    {
        gvUsers.EditIndex = e.NewEditIndex;
        LoadUsers();
    }

    protected void gvUsers_RowCancelingEdit(object sender, System.Web.UI.WebControls.GridViewCancelEditEventArgs e)
    {
        gvUsers.EditIndex = -1;
        LoadUsers();
    }

    protected void gvUsers_RowUpdating(object sender, System.Web.UI.WebControls.GridViewUpdateEventArgs e)
    {
        int id = Convert.ToInt32(gvUsers.DataKeys[e.RowIndex].Value);
        var row = gvUsers.Rows[e.RowIndex];

        var txtFull = (System.Web.UI.WebControls.TextBox)row.FindControl("txtFull_Edit");
        var txtBirth = (System.Web.UI.WebControls.TextBox)row.FindControl("txtBirth_Edit");
        var txtJob = (System.Web.UI.WebControls.TextBox)row.FindControl("txtJob_Edit");

        string full = txtFull?.Text.Trim() ?? "";
        string birthText = txtBirth?.Text.Trim() ?? "";
        string job = txtJob?.Text.Trim() ?? "";

        DateTime birth;
        if (!DateTime.TryParse(birthText, out birth))
        {
            lblMessage.Text = "Invalid birthdate format.";
            return;
        }

        if (System.Text.RegularExpressions.Regex.IsMatch(job, @"\d"))
        {
            lblMessage.Text = "Job cannot contain numbers.";
            return;
        }

        try
        {
            using (MySqlConnection conn = new MySqlConnection(ConnStr))
            {
                conn.Open();
                string q = "UPDATE Users SET FullName=@fn, Birthdate=@bd, Job=@job WHERE ID=@id";
                using (MySqlCommand cmd = new MySqlCommand(q, conn))
                {
                    cmd.Parameters.AddWithValue("@fn", full);
                    cmd.Parameters.AddWithValue("@bd", birth.ToString("yyyy-MM-dd"));
                    cmd.Parameters.AddWithValue("@job", job);
                    cmd.Parameters.AddWithValue("@id", id);
                    cmd.ExecuteNonQuery();
                }
            }
            lblMessage.Text = "User updated.";
            gvUsers.EditIndex = -1;
            LoadUsers();
        }
        catch (Exception ex)
        {
            lblMessage.Text = "Error updating user: " + ex.Message;
        }
    }

    protected void gvUsers_RowDeleting(object sender, System.Web.UI.WebControls.GridViewDeleteEventArgs e)
    {
        int id = Convert.ToInt32(gvUsers.DataKeys[e.RowIndex].Value);
        try
        {
            using (MySqlConnection conn = new MySqlConnection(ConnStr))
            {
                conn.Open();
                string q = "DELETE FROM Users WHERE ID=@id";
                using (MySqlCommand cmd = new MySqlCommand(q, conn))
                {
                    cmd.Parameters.AddWithValue("@id", id);
                    cmd.ExecuteNonQuery();
                }
            }
            lblMessage.Text = "User deleted.";
            LoadUsers();
        }
        catch (Exception ex)
        {
            lblMessage.Text = "Error deleting user: " + ex.Message;
        }
    }
}