$PBExportHeader$w_customers.srw
$PBExportComments$Customer sheet window inheriting from w_master_detail_ancestor.
forward
global type w_customers from w_master_detail_ancestor
end type
end forward

global type w_customers from w_master_detail_ancestor
string tag = "maintain customers"
integer width = 3086
integer height = 2108
end type
global w_customers w_customers

on w_customers.create
call super::create
end on

on w_customers.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_detail from w_master_detail_ancestor`dw_detail within w_customers
integer x = 23
integer y = 768
integer width = 2944
integer height = 960
string dataobject = "d_customer"
end type

type dw_master from w_master_detail_ancestor`dw_master within w_customers
integer x = 37
integer y = 44
integer width = 2921
integer height = 680
string dataobject = "d_custlist"
end type

event dw_master::itemchanged;call super::itemchanged;if dw_master.ModifiedCount()>0 then
	long ll_updatedRows
	ll_updatedRows = dw_master.update()
	if ll_updatedRows > 0 then
		COMMIT USING sqlca;
		messageBox("update", string(ll_updatedRows)+"row(s) updated successfully.")
	else
		ROLLBACK USING sqlca;
		MessageBox("update error", "update failed")
	end if
else
	MessageBOX("update", "no changes to update")
end if
end event

