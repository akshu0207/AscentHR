$PBExportHeader$w_products.srw
$PBExportComments$Product sheet window inheriting from w_master_detail_ancestor.
forward
global type w_products from w_master_detail_ancestor
end type
end forward

global type w_products from w_master_detail_ancestor
string tag = "maintain product"
integer width = 2985
integer height = 1812
end type
global w_products w_products

on w_products.create
call super::create
end on

on w_products.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_detail from w_master_detail_ancestor`dw_detail within w_products
integer x = 169
integer y = 732
integer width = 2505
integer height = 840
string dataobject = "d_product"
end type

type dw_master from w_master_detail_ancestor`dw_master within w_products
integer width = 2560
integer height = 644
string dataobject = "d_prodlist"
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

