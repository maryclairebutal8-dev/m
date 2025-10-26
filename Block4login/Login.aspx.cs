using System;
public partial class Login : System.Web.UI.Page
{
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string username = txtUsername.Text.Trim();
        string password = txtPassword.Text.Trim();

        if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
        {
            lblMessage.Text = "Enter username and password.";
            return;
        }

        // Allow anyone to login
        Session["Username"] = username;
        Session["Password"] = password;

        Response.Redirect("Register.aspx");
    }
}
