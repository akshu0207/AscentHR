$PBExportHeader$w_report.srw
forward
global type w_report from window
end type
type cb_generate from commandbutton within w_report
end type
type sle_columns from singlelineedit within w_report
end type
type st_solumns from statictext within w_report
end type
type st_report from statictext within w_report
end type
type dw_report from datawindow within w_report
end type
end forward

global type w_report from window
integer width = 3378
integer height = 1956
boolean titlebar = true
string title = "Report"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_generate cb_generate
sle_columns sle_columns
st_solumns st_solumns
st_report st_report
dw_report dw_report
end type
global w_report w_report

on w_report.create
this.cb_generate=create cb_generate
this.sle_columns=create sle_columns
this.st_solumns=create st_solumns
this.st_report=create st_report
this.dw_report=create dw_report
this.Control[]={this.cb_generate,&
this.sle_columns,&
this.st_solumns,&
this.st_report,&
this.dw_report}
end on

on w_report.destroy
destroy(this.cb_generate)
destroy(this.sle_columns)
destroy(this.st_solumns)
destroy(this.st_report)
destroy(this.dw_report)
end on

type cb_generate from commandbutton within w_report
integer x = 974
integer y = 1384
integer width = 613
integer height = 140
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Generate Report"
end type

event clicked;string ls_columns, ls_filter, ls_layout, ls_sql, ls_presentation, ls_dwsyntax, ls_errors
long ll_rows

// 1. Get user inputs
ls_columns = TRIM(sle_columns.Text)     // e.g., "customer_id, customer_name"

// 2. Validate columns
IF ls_columns = "" THEN
    MessageBox("Error", "Please enter column names.")
    RETURN
END IF

// 3. Set default layout if none entered
IF ls_layout = "" THEN
    ls_layout = "grid"
END IF

// 4. Build SQL
ls_sql = "SELECT " + ls_columns + " FROM customers"


// 5. Create presentation layout string
ls_presentation = "style(type=grid)"

// 6. Generate DataWindow syntax
ls_dwsyntax = SQLCA.SyntaxFromSQL(ls_sql, ls_presentation, ls_errors)

IF Len(ls_errors) > 0 OR ls_dwsyntax = "" THEN
    MessageBox("Syntax Error", ls_errors)
    RETURN
END IF

// 7. Create and retrieve
dw_report.Reset()
IF dw_report.Create(ls_dwsyntax, ls_errors) <> 1 THEN
    MessageBox("Create Error", ls_errors)
    RETURN
END IF

dw_report.SetTransObject(SQLCA)
ll_rows = dw_report.Retrieve()

IF ll_rows < 0 THEN
    MessageBox("Retrieve Error", "Failed to retrieve data.")
ELSEIF ll_rows = 0 THEN
    MessageBox("Notice", "No data found.")
ELSE
    MessageBox("Success", "Report generated successfully.")
END IF
end event

type sle_columns from singlelineedit within w_report
integer x = 1303
integer y = 1156
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_solumns from statictext within w_report
integer x = 777
integer y = 1172
integer width = 462
integer height = 108
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Columns"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_report from statictext within w_report
integer x = 1266
integer y = 76
integer width = 613
integer height = 132
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Report"
alignment alignment = center!
long bordercolor = 10789024
boolean focusrectangle = false
end type

type dw_report from datawindow within w_report
integer x = 567
integer y = 240
integer width = 1979
integer height = 872
integer taborder = 10
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;string ls_columns, ls_filter, ls_layout, ls_sql, ls_presentation, ls_dwsyntax, ls_errors
long ll_rows

ls_columns = TRIM(sle_columns.Text)     

IF ls_columns = "" THEN
    MessageBox("Error", "Please enter column names.")
    RETURN
END IF

IF ls_layout = "" THEN
    ls_layout = "grid"
END IF

ls_sql = "SELECT " + ls_columns + " FROM customers" 

ls_presentation = "style(type=" + ls_layout + ")"

ls_dwsyntax = SQLCA.SyntaxFromSQL(ls_sql, ls_presentation, ls_errors)

IF Len(ls_errors) > 0 OR ls_dwsyntax = "" THEN
    MessageBox("Syntax Error", ls_errors)
    RETURN
END IF

dw_report.Reset()
IF dw_report.Create(ls_dwsyntax, ls_errors) <> 1 THEN
    MessageBox("Create Error", ls_errors)
    RETURN
END IF

dw_report.SetTransObject(SQLCA)
ll_rows = dw_report.Retrieve()

IF ll_rows < 0 THEN
    MessageBox("Retrieve Error", "Failed to retrieve data.")
ELSEIF ll_rows = 0 THEN
    MessageBox("Notice", "No data found.")
ELSE
    MessageBox("Success", "Report generated successfully.")
END IF
end event

