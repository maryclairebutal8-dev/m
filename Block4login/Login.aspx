<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>Login -  Block4login</title>
    <style>
        body {
            background: #181818;
            color: #fff;
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .form-box {
            background: #222;
            padding: 30px;
            width: 350px;
            border-radius: 12px;
            box-shadow: 0 0 15px rgba(0,0,0,0.5);
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #fff;
        }
        label {
            display: block;
            margin-top: 10px;
            font-weight: bold;
        }
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: none;
            border-radius: 6px;
            background: #333;
            color: #fff;
        }
        .btn {
            width: 100%;
            padding: 12px;
            margin-top: 20px;
            border: none;
            border-radius: 6px;
            background: #2196F3;
            color: white;
            font-size: 16px;
            cursor: pointer;
        }
        .btn:hover {
            background: #1e88e5;
        }
        .message {
            text-align: center;
            margin-top: 10px;
            color: red;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="form-box">
            <h2>Login</h2>

            <label>Username:</label>
            <asp:TextBox ID="txtUsername" runat="server" />

            <label>Password:</label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" />

            <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn" OnClick="btnLogin_Click" />

            <asp:Label ID="lblMessage" runat="server" CssClass="message" />
        </div>
    </form>
</body>
</html>