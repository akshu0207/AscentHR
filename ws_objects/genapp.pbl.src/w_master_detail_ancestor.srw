$PBExportHeader$w_master_detail_ancestor.srw
$PBExportComments$New ancestor basesheet for the w_customers and w_products sheet windows.
forward
global type w_master_detail_ancestor from w_genapp_basesheet
end type
type dw_detail from u_dwstandard within w_master_detail_ancestor
end type
type dw_master from u_dwstandard within w_master_detail_ancestor
end type
end forward

global type w_master_detail_ancestor from w_genapp_basesheet
string menuname = "m_my_sheet"
event ue_retrieve ( )
event ue_insert ( )
event ue_update ( )
event ue_delete ( )
dw_detail dw_detail
dw_master dw_master
end type
global w_master_detail_ancestor w_master_detail_ancestor

event ue_retrieve();IF dw_master.Retrieve() <> -1 THEN
    dw_master.SetFocus()
    dw_master.SetRowFocusIndicator(Hand!)
END IF
end event

event ue_insert();dw_detail.Reset()
dw_detail.InsertRow(0)
dw_detail.SetFocus()
dw_master.InsertRow(0)

end event

event ue_update();IF dw_detail.update() =1 AND dw_master.update() = 1 THEN
	   COMMIT using SQLCA;
	    MessageBox("Save","Save succeeded")
	    this.event ue_retrieve()
ELSE
	     if sqlca.sqlcode <> 0 then
	        messagebox("error","ID already exists")
         else
	        messagebox("error","update failed. sqlcode: " + string(sqlca.sqlcode))
	     end if
	     rollback using sqlca;
	     return
END IF



end event

event ue_delete();dw_master.deleteRow(0)
messagebox("success","deletion successful")
messageBox("deletion","kindly update")
dw_detail.Reset()
dw_detail.InsertRow(0)
dw_detail.SetFocus()
end event

on w_master_detail_ancestor.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_my_sheet" then this.MenuID = create m_my_sheet
this.dw_detail=create dw_detail
this.dw_master=create dw_master
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_detail
this.Control[iCurrent+2]=this.dw_master
end on

on w_master_detail_ancestor.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_detail)
destroy(this.dw_master)
end on

event open;call super::open;dw_master.settransobject ( sqlca )
dw_detail.settransobject ( sqlca )
this.EVENT ue_retrieve()
end event

event ue_clear;call super::ue_clear;dw_detail.ReplaceText("")
end event

event ue_copy;call super::ue_copy;dw_master.copy()
dw_detail.copy()
end event

event ue_cut;call super::ue_cut;dw_detail.cut()
end event

event ue_paste;call super::ue_paste;dw_detail.paste()
dw_master.paste()
end event

type dw_detail from u_dwstandard within w_master_detail_ancestor
integer x = 119
integer y = 444
integer width = 1326
integer taborder = 20
end type

type dw_master from u_dwstandard within w_master_detail_ancestor
integer x = 119
integer y = 36
integer width = 1326
integer height = 356
integer taborder = 10
string dataobject = "d_customer"
boolean vscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;long ll_itemnum
ll_itemnum = this.object.data[currentrow, 1]
IF dw_detail.Retrieve(ll_itemnum) = -1 THEN
 MessageBox("Retrieve","Retrieve error-detail")
END IF


end event

