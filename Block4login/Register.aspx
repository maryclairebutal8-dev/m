<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Register" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>Register - Block4login</title>
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
        input[type="text"], input[type="date"] {
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
            background: #4CAF50;
            color: white;
            font-size: 16px;
            cursor: pointer;
        }
        .btn:hover {
            background: #45a049;
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
            <h2>Register Info</h2>

            <label>Full Name:</label>
            <asp:TextBox ID="txtFullName" runat="server" />

            <label>Birthdate:</label>
            <asp:TextBox ID="txtBirthdate" runat="server" TextMode="Date" />

            <label>Job:</label>
            <asp:TextBox ID="txtJob" runat="server" />

            <asp:Button ID="btnRegister" runat="server" Text="Submit" CssClass="btn" OnClick="btnRegister_Click" />

            <asp:Label ID="lblMessage" runat="server" CssClass="message" />
        </div>
    </form>
</body>
</html>

