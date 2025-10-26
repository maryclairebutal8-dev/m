<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Home" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Home -  Block4login</title>
    <style>
        body { background:#05060A; color:#e6eef6; font-family:'Segoe UI',sans-serif; margin:0; }
        .topbar {
            background: linear-gradient(90deg,#0f1724,#091224); color:#fff; padding:14px 22px; display:flex; justify-content:space-between; align-items:center;
            border-bottom:1px solid rgba(255,255,255,0.03);
        }
        .brand { font-weight:700; color:#8be9fd; }
        .actions { display:flex; gap:10px; align-items:center; }
        .btn { padding:8px 12px; border-radius:8px; border:none; cursor:pointer; font-weight:700; }
        .primary { background:#1e90ff; color:#021; }
        .ghost { background:transparent; color:#9fb9d6; border:1px solid rgba(255,255,255,0.04); }
        .wrap { max-width:1100px; margin:22px auto; padding:0 18px; }
        .card { background:#0b1220; border-radius:12px; padding:18px; border:1px solid rgba(255,255,255,0.03); box-shadow:0 6px 18px rgba(0,0,0,0.6); }
        table { width:100%; border-collapse:collapse; margin-top:12px; font-size:14px; color:#dbeaf6; }
        th,td { padding:10px 12px; border-bottom:1px solid rgba(255,255,255,0.03); text-align:left; }
        th { color:#9fb9d6; font-weight:700; background:rgba(255,255,255,0.01); }
        tr:hover td { background: rgba(255,255,255,0.01); }
        .action-btn { padding:6px 8px; border-radius:6px; border:none; cursor:pointer; font-weight:700; }
        .edit { background:#ffd54f; color:#1b1b1b; }
        .save { background:#4caf50; color:#fff; }
        .delete { background:#ff6b6b; color:#fff; }
        .smallmsg { margin-top:10px; color:#ff7b7b; font-weight:700; }
        input.inline { background:transparent; border:1px solid rgba(255,255,255,0.04); color:#e6eef6; padding:6px 8px; border-radius:6px; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="topbar">
            <div class="brand"> Block4login Dashboard</div>
            <div class="actions">
                <asp:Label ID="lblWelcome" runat="server" Text=""></asp:Label>
                <asp:Button ID="btnAdd" runat="server" CssClass="btn primary" Text="Register New User" OnClick="btnAdd_Click" />
                <asp:Button ID="btnLogout" runat="server" CssClass="btn ghost" Text="Logout" OnClick="btnLogout_Click" />
            </div>
        </div>

        <div class="wrap">
            <div class="card">
                <h3>Users</h3>
                <asp:Label ID="lblMessage" runat="server" CssClass="smallmsg"></asp:Label>

                <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="false"
                    DataKeyNames="ID"
                    OnRowEditing="gvUsers_RowEditing"
                    OnRowCancelingEdit="gvUsers_RowCancelingEdit"
                    OnRowUpdating="gvUsers_RowUpdating"
                    OnRowDeleting="gvUsers_RowDeleting">
                    <Columns>
                        <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="true" />
                        <asp:BoundField DataField="Username" HeaderText="Username" ReadOnly="true" />
                        <asp:TemplateField HeaderText="Full Name">
                            <ItemTemplate><%# Eval("FullName") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtFull_Edit" runat="server" Text='<%# Bind("FullName") %>' CssClass="inline" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Birthdate">
                            <ItemTemplate><%# Eval("Birthdate", "{0:MM-dd-yyyy}") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtBirth_Edit" runat="server" Text='<%# Bind("Birthdate","{0:MM/dd/yyyy}") %>' CssClass="inline" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Job">
                            <ItemTemplate><%# Eval("Job") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtJob_Edit" runat="server" Text='<%# Bind("Job") %>' CssClass="inline" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:CommandField ShowEditButton="true" ShowDeleteButton="true" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </form>
</body>
</html>