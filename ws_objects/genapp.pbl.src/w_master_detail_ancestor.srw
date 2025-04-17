$PBExportHeader$w_master_detail_ancestor.srw
$PBExportComments$New ancestor basesheet for the w_customers and w_products sheet windows.
forward
global type w_master_detail_ancestor from w_genapp_basesheet
end type
type sle_search from singlelineedit within w_master_detail_ancestor
end type
type st_search from statictext within w_master_detail_ancestor
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
event ue_find ( )
event ue_new ( )
event ue_report ( )
sle_search sle_search
st_search st_search
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
dw_detail.Reset()
dw_detail.InsertRow(0)
dw_detail.SetFocus()
end event

event ue_find();//string ls_customers
//integer li_decision
//long ll_foundrow, ll_rv,  ll_newrow, ll_row
//boolean lb_modified = FALSE  
//dwItemStatus l_status
//ll_row = dw_master.RowCount()
//
//ls_customers = Trim(sle_search.Text)
//
//
//ll_foundrow = dw_master.Find( &
//      "first_name = '" + ls_customers + "'", 1, ll_row)
//
//IF ll_foundrow > 0 THEN
//
//    dw_master.ScrollToRow(ll_foundrow)
//    dw_master.SetRowFocusIndicator(Hand!)
//
//  
//    dw_detail.Reset()
//    dw_detail.InsertRow(1)
//    dw_detail.SetItem(1, "id", dw_master.GetItemNumber(ll_foundrow, "id"))
//    dw_detail.SetItem(1, "first_name", dw_master.GetItemString(ll_foundrow, "first_name"))
//    dw_detail.SetItem(1, "last_name", dw_master.GetItemString(ll_foundrow, "last_name"))
//    dw_detail.SetItem(1, "city", dw_master.GetItemString(ll_foundrow, "city"))
//    dw_detail.SetItem(1, "state", dw_master.GetItemString(ll_foundrow, "state"))
//
//    dw_detail.SetFocus()
//ELSE
//
//    li_decision = MessageBox("Insert", "No record found. Do you want to add a new row?", Question!, YesNo!, 2)
//
//    IF li_decision = 1 THEN
//  
//         ll_newrow = dw_master.InsertRow(0)
//        
//     
//        dw_detail.Reset()
//        dw_detail.InsertRow(1)
//        dw_detail.SetFocus()
//    ELSE
//        RETURN
//    END IF
//END IF
//
//
//dw_detail.AcceptText()
//
//l_status = dw_detail.GetItemStatus(1, 0, Primary!)
//
//IF l_status = NewModified! THEN
//
//		dw_detail.SetItemStatus(1, 0, Primary!, DataModified!)
//
//END IF
//
//
//IF dw_detail.ModifiedCount() > 0 THEN
//    lb_modified = TRUE  
//
//
//    IF ll_foundrow > 0 THEN
//        IF dw_detail.GetItemString(1, "first_name") <> dw_master.GetItemString(ll_foundrow, "first_name") THEN
//            dw_master.SetItem(ll_foundrow, "first_name", dw_detail.GetItemString(1, "first_name"))
//        END IF
//        IF dw_detail.GetItemString(1, "last_name") <> dw_master.GetItemString(ll_foundrow, "last_name") THEN
//            dw_master.SetItem(ll_foundrow, "last_name", dw_detail.GetItemString(1, "last_name"))
//        END IF
//        IF dw_detail.GetItemString(1, "city") <> dw_master.GetItemString(ll_foundrow, "city") THEN
//            dw_master.SetItem(ll_foundrow, "city", dw_detail.GetItemString(1, "city"))
//        END IF
//        IF dw_detail.GetItemString(1, "state") <> dw_master.GetItemString(ll_foundrow, "state") THEN
//            dw_master.SetItem(ll_foundrow, "state", dw_detail.GetItemString(1, "state"))
//        END IF
//    ELSE
//
//        dw_master.SetItem(ll_newrow, "first_name", dw_detail.GetItemString(1, "first_name"))
//        dw_master.SetItem(ll_newrow, "last_name", dw_detail.GetItemString(1, "last_name"))
//        dw_master.SetItem(ll_newrow, "city", dw_detail.GetItemString(1, "city"))
//        dw_master.SetItem(ll_newrow, "state", dw_detail.GetItemString(1, "state"))
//    END IF
//END IF
//
//
//IF lb_modified THEN
//    dw_master.AcceptText()
//    ll_rv = dw_master.Update()
//
//    IF ll_rv = 1 THEN
//        COMMIT USING SQLCA;
//    ELSE
//        ROLLBACK USING SQLCA;
//        MessageBox("Save Record", "Update Failed. SQLCode: " + String(SQLCA.SQLCode))
//    END IF
//ELSE
//    MessageBox("Insert", "click on the insert row button")
//END IF
end event

event ue_new();dw_detail.Reset()
dw_detail.InsertRow(0)
dw_detail.SetFocus()


end event

event ue_report();open(w_report)
end event

on w_master_detail_ancestor.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_my_sheet" then this.MenuID = create m_my_sheet
this.sle_search=create sle_search
this.st_search=create st_search
this.dw_detail=create dw_detail
this.dw_master=create dw_master
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_search
this.Control[iCurrent+2]=this.st_search
this.Control[iCurrent+3]=this.dw_detail
this.Control[iCurrent+4]=this.dw_master
end on

on w_master_detail_ancestor.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.sle_search)
destroy(this.st_search)
destroy(this.dw_detail)
destroy(this.dw_master)
end on

event open;call super::open;dw_master.settransobject ( sqlca )
dw_detail.settransobject ( sqlca )
this.EVENT ue_retrieve()
end event

event ue_clear;call super::ue_clear;dw_detail.ReplaceText("")
end event

event ue_copy;call super::ue_copy;dw_detail.copy()
dw_master.copy()
end event

event ue_cut;call super::ue_cut;dw_detail.cut()
end event

event ue_paste;call super::ue_paste;dw_detail.paste()
dw_master.paste()
end event

type sle_search from singlelineedit within w_master_detail_ancestor
integer x = 791
integer y = 932
integer width = 521
integer height = 140
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_search from statictext within w_master_detail_ancestor
integer x = 261
integer y = 948
integer width = 457
integer height = 92
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "search"
alignment alignment = center!
boolean focusrectangle = false
end type

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

