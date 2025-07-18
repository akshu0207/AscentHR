﻿$PBExportHeader$w_genapp_frame.srw
$PBExportComments$Generated MDI Frame
forward
global type w_genapp_frame from window
end type
type mdi_1 from mdiclient within w_genapp_frame
end type
end forward

global type w_genapp_frame from window
integer x = 256
integer y = 132
integer width = 2944
integer height = 1656
boolean titlebar = true
string title = "Frame"
string menuname = "m_genapp_frame"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = mdihelp!
long backcolor = 79416533
event type integer ue_new ( readonly string as_sheetname )
event type integer ue_open ( )
event ue_postopen ( )
event type integer ue_close ( )
event type integer ue_print ( )
event type integer ue_print_query ( )
mdi_1 mdi_1
end type
global w_genapp_frame w_genapp_frame

type variables
n_genapp_sheetmanager inv_sheetmgt
end variables

forward prototypes
public function long of_getsheetcount ()
public function integer of_sheetisclosing (readonly w_genapp_basesheet aw_sheet)
public function long of_classcount (readonly w_genapp_basesheet aw_sheet)
public function integer of_adjustmenu (ref m_genapp_frame am_menu)
end prototypes

event ue_new;//*-----------------------------------------------------------------*/
//*    ue_new:   Open a new instance of a specified sheet
//*-----------------------------------------------------------------*/
/*  Open an instance of passed sheet  */
Return inv_sheetmgt.of_OpenSheet ( as_sheetname )
end event

event type integer ue_open();//*-----------------------------------------------------------------*/
//*    ue_open:  Open <something>
//							 Add code here for any documents, etc you want
//							 to open.  When the code is successful,
//							 Return 1 from the event
//*-----------------------------------------------------------------*/

IF NOT IsValid(w_welcome) THEN
	HALT close
ELSE
	open(w_welcome)
     return -1
END IF
end event

event ue_postopen();//*-----------------------------------------------------------------*/
//*    ue_postopen:  Register the sheets
//*-----------------------------------------------------------------*/

/*  Define sheet windows and their display names */
string ls_sheets[] = { "w_customers", "w_products" }
string ls_display[] = { "Maintain Customers", "Maintain Products"}

/*  Register sheet windows with sheet manager  */
inv_sheetmgt.of_RegisterSheets ( ls_sheets, ls_display )
end event

event type integer ue_close();//*-----------------------------------------------------------------*/
//*    ue_close:   Close the Active Sheet
//*-----------------------------------------------------------------*/
window	lw_sheet

lw_sheet = this.GetActiveSheet ( )

If IsValid ( lw_sheet ) Then 
	Return Close ( lw_sheet )
Else
	Return -1
End If

end event

event ue_print;//*-----------------------------------------------------------------*/
//*    ue_print:   Print the Active Sheet
//*-----------------------------------------------------------------*/
long ll_job
w_genapp_basesheet lw_sheet

lw_sheet = this.GetActiveSheet ( )

If IsValid ( lw_sheet ) Then
	this.SetMicroHelp ( "Printing active sheet..." )
	ll_job = PrintOpen ( )
	lw_sheet.Print ( ll_job, 1, 1 )
	PrintClose ( ll_job )
	this.SetMicroHelp ( "" )
End If

Return 1
end event

event type integer ue_print_query();//*-----------------------------------------------------------------*/
//*    ue_print:   Print the Active Sheet and show Print Dialog to set print info before job started.
//*-----------------------------------------------------------------*/
long ll_job
w_genapp_basesheet lw_sheet

lw_sheet = this.GetActiveSheet ( )

If IsValid ( lw_sheet ) Then
	this.SetMicroHelp ( "Printing active sheet..." )
	ll_job = PrintOpen ("", true)
	if ll_job <> -1 and not IsNull(ll_job) then
		lw_sheet.Print ( ll_job, 1, 1 )
		PrintClose ( ll_job )
	end if
	this.SetMicroHelp ( "" )
End If

Return 1
end event

public function long of_getsheetcount ();//*-----------------------------------------------------------------*/
//*    of_GetSheetCount:  Obtain the number of open sheets
//*-----------------------------------------------------------------*/
Return inv_sheetmgt.of_SheetCount ( )
end function

public function integer of_sheetisclosing (readonly w_genapp_basesheet aw_sheet);//*-----------------------------------------------------------------*/
//*    of_SheetIsClosing:  Remove the sheet from the array
//*-----------------------------------------------------------------*/
Return inv_sheetmgt.of_SheetIsClosing ( aw_sheet )
end function

public function long of_classcount (readonly w_genapp_basesheet aw_sheet);//*-----------------------------------------------------------------*/
//*    of_ClassCount:  Obtain the number of open sheets
//*							 for the specified class
//*-----------------------------------------------------------------*/
Return inv_sheetmgt.of_ClassCount ( aw_sheet )
end function

public function integer of_adjustmenu (ref m_genapp_frame am_menu);//*-----------------------------------------------------------------*/
//*    of_AdjustMenu:  Add Sheet names to the menu
//*-----------------------------------------------------------------*/
Return inv_sheetmgt.of_AdjustMenu ( am_menu )
end function

event open;//*-----------------------------------------------------------------*/
//*    open:  Create sheet manager and post event
//*-----------------------------------------------------------------*/
string ls_sheets[]

/*  Create an instance of the sheet manager  */
inv_sheetmgt = Create n_genapp_sheetmanager

this.Post Event ue_postopen ( )

//open login window
open(w_welcome)
end event

on w_genapp_frame.create
if this.MenuName = "m_genapp_frame" then this.MenuID = create m_genapp_frame
this.mdi_1=create mdi_1
this.Control[]={this.mdi_1}
end on

on w_genapp_frame.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

type mdi_1 from mdiclient within w_genapp_frame
long BackColor=275287458
end type

