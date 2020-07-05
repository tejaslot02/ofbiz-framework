<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<div class="container-fluid">
	<form name="RegisterPerson" class="basic-form" id="RegisterPerson">
		<input type="hidden" name="externalLoginKey" id="externalLoginKey" value="${externalLoginKey}"/>
		<style>
			#customers td {
			  border: 1px solid #ddd;
			  padding: 8px;
			}
			.button {
			  border: none;
			  color: white;
			  text-align: center;
			  text-decoration: none;
			  display: inline-block;
			  font-size: 16px;
			  margin: 4px 2px;
			  cursor: pointer;
			  border-radius: 12px;
			}
			.prdCat{
		      background-color: #2E86C1;
			  width: 100px;
			}
			.prdItem{
			  background-color: #F8C471;
			  width: 100.5px;
			}
			.totalDivBtnCss{
			  background-color: #B2BABB;
			  width: 48.2%;
			}
		</style>
	
		<div style="height:100%;">
			<table id="customers" height="100%">
				<tbody>
					<tr height="50%" >
						<td width="80%" height="50%">
							<div>
								<table id="billingItems" class="basic-table hover-bar">
									<thead>
										<tr class="header-row-2">
											<td style="text-align:center;">${uiLabelMap.srNo}</td>
											<td style="text-align:center;">${uiLabelMap.itemName}</td>
											<td style="text-align:center;">${uiLabelMap.amount}</td>
											<td style="text-align:center;">${uiLabelMap.quantity}</td>
											<td style="text-align:center;">${uiLabelMap.totalAmount}</td>
										</tr>
									</thead>
									<tbody>
										
									</tbody>
								</table>
							</div>
						</td>
						<td width="20%" height="50%">
							<div>
								<table id="" class="basic-table hover-bar">
									<tbody>
										<tr class="header-row-2">
											<td style="text-align:center;" colspan="2">${uiLabelMap.totalBilling}</td>
										</tr>
										<tr class="header-row-3">
											<td style="text-align:left; width:70%;">${uiLabelMap.totalQuantity}</td>
											<td style="text-align:left; width:30%;"></td>
										</tr>
										<tr class="header-row-3">
											<td style="text-align:left; width:70%;">${uiLabelMap.cartAmount}</td>
											<td style="text-align:left; width:30%;"></td>
										</tr>
										<tr class="header-row-3">
											<td style="text-align:left; width:70%;">${uiLabelMap.discount}</td>
											<td style="text-align:left; width:30%;"></td>
										</tr>
										<tr class="header-row-3">
											<td style="text-align:left; width:70%;">${uiLabelMap.totaCartAmnt}</td>
											<td style="text-align:left; width:30%;"></td>
										</tr>
									</tbody>
								</table>
								<div id="totalDiv">
										
								</div>
							</div>
						</td>
					</tr>
					<tr width="100%" height="50%" >
						<td colspan = "2">
							<div>
								<table>
									<tbody>
										<tr class="header-row-3">
											<td width="19.5%"> 
												<div id="productCategory">
													
												</div>
											</td>
											<td width="80.5%"> 
												<div id="products">
												
												</div>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	
		<!-- <div id="_G0_" class="fieldgroup">
			<div class="fieldgroup-title-bar">
				<table><tbody><tr><td class="collapse"> </td><td> </td></tr></tbody></table> 
			</div>
			<div class="fieldgroup-body" id="_G0__body">
			</div>
		</div> -->
	<!-- End  Form Widget - Form Element  component://myportal/widget/MyPortalForms.xml#RegisterPerson --><!-- End Section Widget  -->
	</form>
</div>

<script type="text/javascript">
	var baseUrlEnum = {
		baseUrlRetail : "/retailweb/control/"
	}
	var responseStatusEnum = {
		success : "success",
		error : "error"
	}
	var productCategoriesWithProducts = "";
	$(document).ready(function() { 
		$(window).resize(function() { 
			setLayout();
		}); 
		$('#billingItems tbody').append(appendItems({"index":"1","productName":"Item 1","amount":"10","qty":"1","totAmt":"10"}));
		$('#billingItems tbody').append(appendItems({"index":"2","productName":"Item 2","amount":"20","qty":"2","totAmt":"40"}));
		$('#billingItems tbody').append(appendItems({"index":"3","productName":"Item 3","amount":"30","qty":"3","totAmt":"90"}));
		$('#billingItems tbody').append(appendItems({"index":"4","productName":"Item 4","amount":"40","qty":"4","totAmt":"160"}));
		$('#billingItems tbody').append(appendItems({"index":"5","productName":"Item 5","amount":"50","qty":"5","totAmt":"250"}));
		$('#billingItems tbody').append(appendItems({"index":"6","productName":"Item 6","amount":"60","qty":"6","totAmt":"360"}));
		
		var response = ajaxEvent("getRetailCategoryMembers", "externalLoginKey="+ $('#externalLoginKey').val() + "&productCategoryTypeId=CATALOG_CATEGORY", false, "POST", baseUrlEnum.baseUrlRetail);
		if(response.status == responseStatusEnum.success){
			productCategoriesWithProducts = response.productCategoriesWithProducts;
			let x = 0;
			$.each(productCategoriesWithProducts, function(category, products){
				$('#productCategory').append(createButton({"id":category,"label":category,"btnCss":"prdCat"}));
				x++;
			})
		}
		createProductsAsPerCategory(Object.keys(productCategoriesWithProducts)[0]);
		$('#totalDiv').append(createButton({"id":"cash","label":"Cash","btnCss":"totalDivBtnCss"}));
		$('#totalDiv').append(createButton({"id":"card","label":"Card","btnCss":"totalDivBtnCss"}));
		$('#totalDiv').append(createButton({"id":"cash","label":"Cash","btnCss":"totalDivBtnCss"}));
		$('#totalDiv').append(createButton({"id":"cash","label":"Cash","btnCss":"totalDivBtnCss"}));	
	}); 
	
	function createProductsAsPerCategory(productCategory){
		console.log(productCategory);
		$('#products').html('');
		var y = 0;
		$.each(productCategoriesWithProducts[productCategory], function(key, value){
			$('#products').append(createButton({"id":y,"label":value.internalName,"btnCss":"prdCat"}));
			y++;
		})
	}
	$(document).load(function(){
	  setLayout();
	});
	setLayout();
	function setLayout(){
		var documentHeight = $( document ).height();
		documentHeight = documentHeight - 165;
		$('#RegisterPerson').height(documentHeight);
	}
	
	function appendItems(data){
		let rowData = 	'<tr class="header-row-3"> '+
				'	<td style="text-align:center;">'+data.index+'</td>'+
				'	<td style="text-align:center;">'+data.productName+'</td>'+
				'	<td style="text-align:center;">'+data.amount+'</td> '+
				'	<td style="text-align:center;">'+data.qty+'</td>'+
				'	<td style="text-align:center;">'+data.totAmt+'</td> '+
				'</tr> ';
		return rowData;
	}
	
	function createButton(data){
		return '<button class="button '+data.btnCss+'" id="'+data.id+'" onclick="createProductsAsPerCategory(\''+data.id+'\')">'+data.label+'</button>';
	}
	
	function ajaxEvent(serviceName, data, mode, ajaxType, url){
		var responseVariable = "";
		if(!url){
			url = baseUrlEnum.baseUrlRetail;
		}
		$.ajax({
				url : url + serviceName,
				type : ajaxType,
				data : encodeURI(data),
				async : mode,
				success : function(response) {
					responseVariable = response;
					},
				error : function(response) {
					responseVariable = response;
					},
				dataType : 'json'
			});
		return responseVariable;
	}
	</script>

