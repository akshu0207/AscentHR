$PBExportHeader$w_welcome.srw
forward
global type w_welcome from window
end type
type cb_cancel from commandbutton within w_welcome
end type
type cb_ok from commandbutton within w_welcome
end type
type sle_password from singlelineedit within w_welcome
end type
type sle_userid from singlelineedit within w_welcome
end type
type st_password from statictext within w_welcome
end type
type st_userid from statictext within w_welcome
end type
type st_sport from statictext within w_welcome
end type
type p_sports from picturebutton within w_welcome
end type
end forward

global type w_welcome from window
integer width = 3351
integer height = 1384
boolean titlebar = true
string title = "welcome"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
windowanimationstyle openanimation = rightroll!
cb_cancel cb_cancel
cb_ok cb_ok
sle_password sle_password
sle_userid sle_userid
st_password st_password
st_userid st_userid
st_sport st_sport
p_sports p_sports
end type
global w_welcome w_welcome

type variables
boolean bLoginSuccess
end variables

on w_welcome.create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.sle_password=create sle_password
this.sle_userid=create sle_userid
this.st_password=create st_password
this.st_userid=create st_userid
this.st_sport=create st_sport
this.p_sports=create p_sports
this.Control[]={this.cb_cancel,&
this.cb_ok,&
this.sle_password,&
this.sle_userid,&
this.st_password,&
this.st_userid,&
this.st_sport,&
this.p_sports}
end on

on w_welcome.destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.sle_password)
destroy(this.sle_userid)
destroy(this.st_password)
destroy(this.st_userid)
destroy(this.st_sport)
destroy(this.p_sports)
end on

event close;IF NOT bLoginSuccess THEN
	HALT CLOSE
END IF
end event

type cb_cancel from commandbutton within w_welcome
integer x = 1239
integer y = 312
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "cancel"
boolean cancel = true
end type

event clicked;HALT
end event

type cb_ok from commandbutton within w_welcome
integer x = 1239
integer y = 180
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "OK"
boolean default = true
end type

event clicked;// Local variable declarations
string ls_database, ls_userid, ls_password

// Assignment statements
ls_userid = Trim(sle_userid.text)
ls_password = Trim(sle_password.text)

IF ls_userid = "" OR ls_password = "" THEN
	MessageBox("Login Error", "User ID and Password cannot be Empty.")
	RETURN
END IF

IF ls_userid = "db1" AND ls_password = "Akshaya@123" THEN
	SQLCA.DBMS = "ODBC"
	SQLCA.UserID = ls_userid
	SQLCA.DBPass = ls_password
	SQLCA.DBParm = "ConnectString='DSN=akshaya_db1;UID=db1;PWD=Akshaya@123'"

	CONNECT USING SQLCA;

	IF SQLCA.SQLCode = 0 THEN
		bLoginSuccess = true
		MessageBox("Login Success", "Welcome, " + ls_userid)
		OPEN(w_genapp_frame)
		CLOSE(w_welcome)
	ELSE
		MessageBox("Connection Failed", SQLCA.SQLErrText)
	END IF
ELSE
	MessageBox("Login Error", "Invalid Username or Password")
END IF

end event

type sle_password from singlelineedit within w_welcome
integer x = 718
integer y = 308
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean password = true
borderstyle borderstyle = stylelowered!
end type

type sle_userid from singlelineedit within w_welcome
integer x = 718
integer y = 176
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
borderstyle borderstyle = stylelowered!
end type

type st_password from statictext within w_welcome
integer x = 434
integer y = 308
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "password:"
boolean focusrectangle = false
end type

type st_userid from statictext within w_welcome
integer x = 430
integer y = 180
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "User ID:"
boolean focusrectangle = false
end type

type st_sport from statictext within w_welcome
integer x = 425
integer y = 48
integer width = 498
integer height = 124
integer textsize = -18
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "sports,inc"
boolean focusrectangle = false
end type

type p_sports from picturebutton within w_welcome
integer x = 41
integer y = 88
integer width = 302
integer height = 252
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string picturename = "Bold1!"
alignment htextalign = left!
end type

