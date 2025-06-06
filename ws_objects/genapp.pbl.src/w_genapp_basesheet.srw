$PBExportHeader$w_genapp_basesheet.srw
$PBExportComments$Generated MDI Base Sheet Window
forward
global type w_genapp_basesheet from window
end type
end forward

global type w_genapp_basesheet from window
integer x = 672
integer y = 264
integer width = 2487
integer height = 1360
boolean titlebar = true
string title = "Sheet"
string menuname = "m_genapp_sheet"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79416533
event ue_postopen ( )
event ue_undo ( )
event ue_cut ( )
event ue_copy ( )
event ue_paste ( )
event ue_clear ( )
end type
global w_genapp_basesheet w_genapp_basesheet

event ue_postopen;//*-----------------------------------------------------------------*/
//*    ue_postopen:  Set Sheet title and adjust menu for new sheets
//*-----------------------------------------------------------------*/
long ll_count
m_genapp_frame lm_menu

lm_menu = this.MenuId

/*  Obtain the number of instance of this class  */
ll_count = w_genapp_frame.of_ClassCount ( this )

this.Title = this.Tag + ":" + String ( ll_count  ) 

w_genapp_frame.of_AdjustMenu ( lm_menu )
end event

event open;//*-----------------------------------------------------------------*/
//*    open:  Post event
//*-----------------------------------------------------------------*/
this.Post Event ue_postopen ( )
end event

on w_genapp_basesheet.create
if this.MenuName = "m_genapp_sheet" then this.MenuID = create m_genapp_sheet
end on

on w_genapp_basesheet.destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;//*-----------------------------------------------------------------*/
//*    close:  Remove sheet from the sheet manager array
//*-----------------------------------------------------------------*/
/*  Remove sheet from the array  */
w_genapp_frame.of_SheetIsClosing ( this ) 
end event

